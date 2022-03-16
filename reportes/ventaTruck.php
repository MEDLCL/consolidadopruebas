<?php
//AddPage (orientacion [PORTRAIT,LANDSCAPE]), tamaño (A3,A4,A5,LETTER,LEGAL,rotacion)
//SetFont (tipo [COURIER,HELVETICA,ARIAL,TIMES,SYMBOL,ZAPDINGBATS],estilo[])
//Cell (ancho,alto,texto,bordes,?,alineacion,rellenar,link)
//Output (destino (I,D,FS),nombre,utf8)

$tipo = isset($_POST["tipo"]) ? $tipo = $_POST["tipo"] : $tipo = 1;

require_once "../config/Conexion.php";
require_once "../config/funciones.php";
require ("../fpdf184/fpdf.php");
require_once "../correo/correo.php";
require_once "../modelos/ventaTruck.php";

$venta = new ventaTruck();
$idventa = isset($_GET["idVentaTruck"]) ? $idventa = $_GET["idVentaTruck"] : $idventa = 0;
$resp = $venta->listarVenta($idventa);
$SRV = $venta->listarServiciosAdicionales($idventa);
$VTF = $venta->listarFletes($idventa);

$codigo = $resp->codigo;

$Path = $_SERVER['DOCUMENT_ROOT']."/".explode("/", $_SERVER['REQUEST_URI'])[1];
if (explode("/", $_SERVER['REQUEST_URI'])[1] != "TruckDelivery"){
    $Path = $_SERVER['DOCUMENT_ROOT'];
}

$ruta = $Path.'/pdf/';
$nombrearchivo='Venta '.$codigo.'.pdf';
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
        $this->Cell(100,8,"VENTA TRUCKS AND DELIVERY",0,1,'C',0);
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
$fpdf->SetFont('Arial','B',12);
$fpdf->SetX(50);
$fpdf->SetTextColor(240, 255, 240); //Letra color blanco
$fpdf->SetFillColor(37,150,190);//Fondo verde de celda
$fpdf->Cell(185,8,"DATOS GENERALES",1,1,'C',1);

$fpdf->SetX(50);

$fpdf->SetTextColor(0, 0, 0); //Letra color blanco
$fpdf->Cell(25,8,"Venta No.:",1,0,'L',0);
$fpdf->Cell(80,8,$resp->codigo,1,1,'L',0);
$fpdf->SetX(50);
$fpdf->Cell(25,8,"Cliente:",1,0,'L',0);
$fpdf->Cell(160,8,$resp->cliente,1,1,'L',0);

$fpdf->SetX(50);
$fpdf->Cell(25,8,"Tipo Venta:",1,0,'L',0);
$fpdf->Cell(37,8,$resp->tipoventa,1,1,'C',0);

$fpdf->SetX(50);
$fpdf->Cell(40,8,"Observaciones:",1,0,'L',0);
$fpdf->MultiCell(145,8,$resp->observaciones,1,'L',0);

$fpdf->Ln(5);
$fpdf->SetX(15);
$fpdf->SetTextColor(240, 255, 240); //Letra color blanco
$fpdf->SetFillColor(37,150,190);//Fondo verde de celda
$fpdf->Cell(245,8,"SERVICIOS ADICIONALES",1,1,'C',1);

$fpdf->Ln(1);
$lineheight = 8;
$fpdf->SetFont('Arial','B',10);
$fpdf->SetTextColor(0, 0, 0); //Letra color blanco
$fpdf->SetX(15);
$tableSV = array(array('Origen','Destino','Servicio','Tarifa Venta','Tarifa Costo','Signo','Cantidad','Comision','Profit'));
$widths = array(40,40,35,25,25,10,20,25,25);
$fpdf->plot_table($widths, $lineheight, $tableSV);
//$table = array(array('Cantidad Unidades', 'Hi2', 'Hi3'), array('Hi4', 'Hi5 (xtra)', 'Hi6'), array('Hi7', 'Hi8', 'Hi9'));


$fpdf->Ln(1);
$fpdf->SetFont('Arial','',8);
foreach ($SRV as $reg) {
    $fpdf->SetX(15);

    $tableTTD = array(array($reg->origen, $reg->destino, $reg->descripcion, strval($reg->tarifa_venta),strval($reg->tarifa_costo), $reg->signo, $reg->cantidad,$reg->comision,$reg->profit));
    $widths = array(40,40,35,25,25,10,20,25,25);
    $fpdf->plot_table($widths, $lineheight, $tableTTD);
}

$fpdf->Ln(5);

$fpdf->SetX(10);
$fpdf->SetFont('Arial','B',12);
$fpdf->SetTextColor(240, 255, 240); //Letra color blanco
$fpdf->SetFillColor(37,150,190);//Fondo verde de celda
$fpdf->Cell(255,8,"DETALLE POSICIONAMIENTO",1,1,'C',1);
$fpdf->Ln(5);


$lineheight = 8;
$fpdf->SetFont('Arial','B',10);
$fpdf->SetTextColor(0, 0, 0); //Letra color blanco
$fpdf->SetX(10);
$tableTS = array(array('Origen','Destino','Tarifa Venta','Tarifa Costo','Signo','No. U.','Venta Total','Costo Total','Hola P.','Fecha P.','Días Libres','Tipo Carga','Comision','Profit'));
$widths = array(25,25,20,20,10,10,20,20,15,15,15,20,20,20);
$fpdf->plot_table($widths, $lineheight, $tableTS);
//$table = array(array('Cantidad Unidades', 'Hi2', 'Hi3'), array('Hi4', 'Hi5 (xtra)', 'Hi6'), array('Hi7', 'Hi8', 'Hi9'));

$fpdf->Ln(1);

$fpdf->SetFont('Arial','',8);
foreach ($VTF as $reg) {
    $fpdf->SetX(10);

    $tableTSD = array(array($reg->origen, strval($reg->destino), strval($reg->tarifa_venta),strval($reg->tarifa_costo) ,$reg->signo, $reg->unidades,strval($reg->total_venta),strval($reg->total_costo), $reg->hora_posicionamiento,$reg->fecha_posicion,$reg->dias_libres,$reg->tipocarga,$reg->comision,$reg->profit));
    $widths = array(25,25,20,20,10,10,20,20,15,15,15,20,20,20);
    $fpdf->plot_table($widths, $lineheight, $tableTSD);
} 

if ($tipo==1){
    $fpdf->Output();
}else{
    $fpdf->Output($ruta.$nombrearchivo,'F');
}

$ruta = $ruta.$nombrearchivo;

$correo = new Correo();

if ($tipo==2){
    $asunto = 'Venta No. '.$codigo;
    $cuerpoCorreo = '<div style="font-family: Arial,Regular; font-size: 14px; line-height: 160%;">
                        <div style="font-size: 18px; padding: 14px 36px 0px; color: #4e4e4e;">
                            Venta Truck And Delivery
                        </div>    
                        <div style="padding: 14px 36px 0px; color: #4e4e4e;">
                            Adjunto  Encontrara La Venta No. 
                            <strong>"'.$codigo.'"</strong>.
                        </div>    
                        <div style="padding: 14px 36px 28px; color: #4e4e4e;">      
                            <div>
                                <strong>Generado por:</strong> TRUCKS AND DELIVERY SYSTEM
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