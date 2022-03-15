<?php
//AddPage (orientacion [PORTRAIT,LANDSCAPE]), tamaño (A3,A4,A5,LETTER,LEGAL,rotacion)
//SetFont (tipo [COURIER,HELVETICA,ARIAL,TIMES,SYMBOL,ZAPDINGBATS],estilo[])
//Cell (ancho,alto,texto,bordes,?,alineacion,rellenar,link)
//Output (destino (I,D,FS),nombre,utf8)
require_once "../config/Conexion.php";
require_once "../config/funciones.php";
require_once "../modelos/tarifaTruck.php";
require ("../fpdf184/fpdf.php");
require_once "../correo/correo.php";

$idproyecto  = isset($_GET["idproyecto"]) ? $idproyecto = $_GET["idproyecto"] : $idproyecto = 0;
$codigo = isset($_GET["codigo"]) ? $codigo = $_GET["codigo"] : $codigo = '';
$tipo = isset($_POST["tipo"]) ? $tipo = $_POST["tipo"] : $tipo = 1;

$tarifario = new tarifaTruck();
$TF =  $tarifario->listarTarifasFlete($idproyecto);
$TS = $tarifario->listarServiciosFlete($idproyecto);

$Path = $_SERVER['DOCUMENT_ROOT']."/".explode("/", $_SERVER['REQUEST_URI'])[1];
if (explode("/", $_SERVER['REQUEST_URI'])[1] != "TruckDelivery"){
    $Path = $_SERVER['DOCUMENT_ROOT'];
}

$ruta = $Path.'/pdf/';
$nombrearchivo='Tarifas'.$codigo.'.pdf';
if (file_exists($ruta.$nombrearchivo)){
    chmod ($ruta.$nombrearchivo,0777);
    unlink($ruta.$nombrearchivo);
}

class PDF extends FPDF{
    function plot_table($widths, $lineheight, $table, $border=1, $aligns=array(), $fills=array(), $links=array()){
        $func = function($text, $c_width){
            $len=strlen($text);
            $twidth = $this->GetStringWidth($text);
            if ($twidth==0){
                $twidth =1;
            }
            $split = floor($c_width * $len / $twidth);
            $w_text = explode( "\n", wordwrap( $text, $split, "\n", true));
            return $w_text;
        };
        foreach ($table as $line){
            $line = array_map($func, $line, $widths);
            $maxlines = max(array_map("count", $line));
            foreach ($line as $key => $cell){
                $x_axis = $this->getx();
                $height = $lineheight * $maxlines / count($cell);
                $len = count($line);
                $width = (isset($widths[$key]) === TRUE ? $widths[$key] : $widths / count($line));
                $align = (isset($aligns[$key]) === TRUE ? $aligns[$key] : '');
                $fill = (isset($fills[$key]) === TRUE ? $fills[$key] : false);
                $link = (isset($links[$key]) === TRUE ? $links[$key] : '');
                foreach ($cell as $textline){
                    $this->cell($widths[$key],$height,$textline,0,0,'C',$fill,$link);
                    $height += 2 * $lineheight * $maxlines / count($cell);
                    $this->SetX($x_axis);
                }
                if($key == $len - 1){
                    $lbreak=1;
                }
                else{
                    $lbreak = 0;
                }
                $this->cell($widths[$key],$lineheight * $maxlines, '',$border,$lbreak,'C',0);
            }
        }
    }
    function Header()
    {
        $this->SetFont('Arial','',18);//definimos tipo y tamaño de letra
        $this->Image('../logos/truckdelivery.jpeg',5,8,60);//agregamos una imagen imagen,poiscionx,posiciony, tamaño
        $this->SetXY(100,15);
        $this->Cell(100,8,"TARIFARIO",0,1,'C',0);
        $this->SetXY(240,5);
        $this->Cell(20,8,date('d-m-Y'),0,1,'C',0);
        $this->Ln(25);
    }
    function Footer()
    {
        $this->SetY(-15);
        $this->SetFont('Arial','',12);  
        $this->Cell(0,10,'Página'.$this->PageNo().'/{nb}',0,0,'C');

    }
}

$fpdf = new PDF();
$fpdf->AddPage('LANDSCAPE','LETTER' );//agregamos una pagina
$fpdf->SetMargins(10,10,10);
$fpdf->SetAutoPageBreak(true,20);


$fpdf->SetX(15);
$fpdf->Cell(50,8,"Codigo Proyecto:",1,0,'C',0);
$fpdf->Cell(60,8,$codigo,1,1,'C',0);

$fpdf->ln(2);
$fpdf->SetFont('Arial','B',12);
$fpdf->SetX(15);
$fpdf->SetTextColor(240, 255, 240); //Letra color blanco
$fpdf->SetFillColor(37,150,190);//Fondo verde de celda
$fpdf->Cell(250,8,"TARIFAS FLETE",1,1,'C',1);

$fpdf->Ln(1);
$fpdf->SetTextColor(0, 0, 0); //Letra color blanco
$lineheight = 8;
$fpdf->SetFont('Arial','B',10);
$fpdf->SetX(15);
$table = array(array('Origen', 'Destino','Tipo Unidad','No. Ayudantes','Validez.','Tipo Carga.','Tarifa Venta','Tarifa Costo','Signo'));
$widths = array(45,45,25,20,23,25,25,25,15);
$fpdf->plot_table($widths, $lineheight, $table);
//$table = array(array('Cantidad Unidades', 'Hi2', 'Hi3'), array('Hi4', 'Hi5 (xtra)', 'Hi6'), array('Hi7', 'Hi8', 'Hi9'));

$fpdf->Ln(1);
$fpdf->SetFont('Arial','',10);

foreach ($TF as $reg) {
    $fpdf->SetX(15);

    $tableD = array(array($reg->origen, $reg->destino, $reg->unidad ,$reg->ayudantes,$reg->validez,$reg->tipocarga,$reg->tarifa_venta,$reg->tarifa_costo,$reg->moneda));
    $widths = array(45,45,25,20,23,25,25,25,15);
    $fpdf->plot_table($widths, $lineheight, $tableD);
}

$fpdf->Ln(5);
$fpdf->SetFont('Arial','B',12);
$fpdf->SetX(15);
$fpdf->SetTextColor(240, 255, 240); //Letra color blanco
$fpdf->SetFillColor(37,150,190);//Fondo verde de celda
$fpdf->Cell(250,8,"TARIFAS SERVICIOS",1,1,'C',1);

$fpdf->Ln(1);
$fpdf->SetTextColor(0, 0, 0); //Letra color blanco
$lineheight = 8;
$fpdf->SetFont('Arial','B',10);
$fpdf->SetX(15);
$table = array(array('Servicio', 'Origen','Destino','Validez','Tarifa Venta','Tarifa Costo','Signo'));
$widths = array(60,50,50,25,23,25,15);
$fpdf->plot_table($widths, $lineheight, $table);
//$table = array(array('Cantidad Unidades', 'Hi2', 'Hi3'), array('Hi4', 'Hi5 (xtra)', 'Hi6'), array('Hi7', 'Hi8', 'Hi9'));

$fpdf->Ln(1);
$fpdf->SetFont('Arial','',10);

foreach ($TS as $reg) {
    $fpdf->SetX(15);

    $tableD = array(array($reg->servicio, $reg->origen, $reg->destino ,$reg->validez,$reg->tarifa_venta,$reg->tarifa_costo,$reg->moneda));
    $widths = array(60,50,50,25,23,25,15);
    $fpdf->plot_table($widths, $lineheight, $tableD);
}

if ($tipo==1){
    $fpdf->Output();
}else{
    $fpdf->Output($ruta.$nombrearchivo,'F');
}

$ruta = $ruta.$nombrearchivo;

$correo = new Correo();

if ($tipo==2){
    $asunto = 'Tarifario de Proyecto No. '.$codigo;
    $cuerpoCorreo = '<div style="font-family: Arial,Regular; font-size: 14px; line-height: 160%;">
                        <div style="font-size: 18px; padding: 14px 36px 0px; color: #4e4e4e;">
                            Tarifario de Proyecto Truck And Delivery
                        </div>    
                        <div style="padding: 14px 36px 0px; color: #4e4e4e;">
                            Adjunto  Encontrara El Tarifario del Proyecto No. 
                            <strong>"'.$codigo.'"</strong>.
                        </div>    
                        <div style="padding: 14px 36px 28px; color: #4e4e4e;">      
                            <div>
                                <strong>Generado por:</strong> TRUCK AND DELIVERY SYSTEM
                            </div>      
                            <div>
                                <strong>Fecha:</strong> "'.date("d-m-Y").'"</div>    
                            </div>    
                                <hr style="border: 0; height: 1px; background-color: #d7d7d7;"/>    
                            <div style="font-size: 11px; padding: 14px 37px; color: #4e4e4e;">      
                                <div>&copy; '.date("Y").' TRUCK AND DELIVERY GUATEMALA GUATEMALA, 
                                </div>      
                            <div>correo electronico generado automaticamente no responder.
                            </div>    
                        </div>  
                    </div>';
    $respuesta = $correo->EnviarCorreo($nombrearchivo,$ruta,$asunto,$cuerpoCorreo);
    echo json_encode($respuesta);
}