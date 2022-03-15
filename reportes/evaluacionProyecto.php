<?php
//AddPage (orientacion [PORTRAIT,LANDSCAPE]), tamaño (A3,A4,A5,LETTER,LEGAL,rotacion)
//SetFont (tipo [COURIER,HELVETICA,ARIAL,TIMES,SYMBOL,ZAPDINGBATS],estilo[])
//Cell (ancho,alto,texto,bordes,?,alineacion,rellenar,link)
//Output (destino (I,D,FS),nombre,utf8)

$idproyecto  = isset($_GET["idproyecto"]) ? $idproyecto = $_GET["idproyecto"] : $idproyecto = 0;
$tipo = isset($_POST["tipo"]) ? $tipo = $_POST["tipo"] : $tipo = 1;

require_once "../config/Conexion.php";
require_once "../config/funciones.php";
require_once "../modelos/evaluacionProyecto.php";
require ("../fpdf184/fpdf.php");
require_once "../correo/correo.php";

$evaluacion = new evaluacionProyecto();
$resp = $evaluacion->listarProyecto($idproyecto);
$uni = $evaluacion->listarUnidades($idproyecto);
$TTS = $evaluacion->listarServiciosTarget($idproyecto);
$TT = $evaluacion->listarTarifasTarget($idproyecto);

$codigo = $resp->codigo;

$Path = $_SERVER['DOCUMENT_ROOT']."/".explode("/", $_SERVER['REQUEST_URI'])[1];
if (explode("/", $_SERVER['REQUEST_URI'])[1] != "TruckDelivery"){
    $Path = $_SERVER['DOCUMENT_ROOT'];
}

$ruta = $Path.'/pdf/';
$nombrearchivo='Proyecto'.$codigo.'.pdf';
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
        $this->Cell(100,8,"EVALUACIÓN DE PROYECTO",0,1,'C',0);
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
$fpdf->Cell(50,8,"Evaluación No.:",1,0,'L',0);
$fpdf->Cell(50,8,$resp->codigo,1,1,'L',0);
$fpdf->SetX(50);
$fpdf->Cell(25,8,"Cliente:",1,0,'L',0);
$fpdf->Cell(160,8,$resp->cliente,1,1,'L',0);

$fpdf->SetX(50);
$fpdf->Cell(56,8,"Fecha Estimada de Inicio:",1,0,'L',0);
$fpdf->Cell(37,8,$resp->fechainicio,1,0,'C',0);

$fpdf->Cell(55,8,"Fecha Estimada de Final:",1,0,'L',0);
$fpdf->Cell(37,8,$resp->fechafinal,1,1,'C',0);

$fpdf->SetX(50);
$fpdf->Cell(40,8,"Descripción:",1,0,'L',0);
$fpdf->MultiCell(145,8,$resp->descripcionProyecto,1,'L',0);

$fpdf->Ln(5);
$fpdf->SetX(50);
$fpdf->SetTextColor(240, 255, 240); //Letra color blanco
$fpdf->SetFillColor(37,150,190);//Fondo verde de celda
$fpdf->Cell(185,8,"INFORMACIÓN DE LA CARGA",1,1,'C',1);

$fpdf->SetX(50);
$fpdf->SetTextColor(0, 0, 0); //Letra color blanco
$fpdf->Cell(40,8,"Tipo de Carga:",1,0,'L',0);
$fpdf->Cell(50,8,$resp->tipocarga,1,0,'L',0);
$fpdf->Cell(35,8,"Fianza:",1,0,'L',0);
$fpdf->Cell(20,8,$resp->Fianza,1,1,'C',0);
$fpdf->SetX(50);
$fpdf->Cell(40,8,"Peso Promedio:",1,0,'L',0);
$fpdf->Cell(50,8,$resp->peso.$resp->Unidad,1,0,'C',0);
$fpdf->Cell(35,8,"Pies Cubicos:",1,0,'L',0);
$fpdf->Cell(40,8,$resp->pies_cubicos,1,1,'C',0);

$fpdf->SetX(50);
$fpdf->SetFont('Arial','B',12);
$fpdf->Cell(65,8,"Descripción de la Mercadería:",1,0,'L',0);
$fpdf->MultiCell(120,8,$resp->descripcionProyecto,1,'L',0);
$fpdf->SetX(50);
$fpdf->Cell(65,8,"Permisos Especiales:",1,0,'L',0);
$fpdf->MultiCell(120,8,$resp->permisos,1,'L',0);
$fpdf->Ln(5);

$fpdf->SetX(15);
$fpdf->SetTextColor(240, 255, 240); //Letra color blanco
$fpdf->SetFillColor(37,150,190);//Fondo verde de celda
$fpdf->Cell(250,8,"TIPO DE UNIDAD DE TRASPORTE",1,1,'C',1);
$fpdf->Ln(5);
$fpdf->SetTextColor(0, 0, 0); //Letra color blanco

$lineheight = 8;
$fpdf->SetFont('Arial','B',10);
$fpdf->SetX(15);
$table = array(array('Cantidad Unidades', 'Tipo Unidad', 'Tipo Equipo','Temp. Promedio','Especificación del Equipo','Seguridad.','Marchamo.','GPS','Lugar Carga','Lugar Descarga','Canal Disbtribución'));
$widths = array(18,15,15,18,40,20,20,10,35,35,25);
$fpdf->plot_table($widths, $lineheight, $table);
//$table = array(array('Cantidad Unidades', 'Hi2', 'Hi3'), array('Hi4', 'Hi5 (xtra)', 'Hi6'), array('Hi7', 'Hi8', 'Hi9'));

$fpdf->Ln(1);

$fpdf->SetFont('Arial','',10);

foreach ($uni as $reg) {
    $fpdf->SetX(15);

    $tableD = array(array($reg->cantidad_unidad, $reg->unidad, $reg->Equipo,$reg->temperatura,$reg->especificacion,$reg->seguridad,$reg->marchamo,$reg->gps,$reg->lugar_carga, $reg->lugar_descarga,$reg->canal_distrbucion));
    $widths = array(18,15,15,18,40,20,20,10,35,35,25);
    $fpdf->plot_table($widths, $lineheight, $tableD);
}


$fpdf->Ln(5);
$fpdf->SetX(50);
$fpdf->SetFont('Arial','B',12);
$fpdf->SetTextColor(240, 255, 240); //Letra color blanco
$fpdf->SetFillColor(37,150,190);//Fondo verde de celda
$fpdf->Cell(185,8,"DATOS DE LA OPERACIÓN",1,1,'C',1);

$fpdf->SetX(50);
$fpdf->SetTextColor(0, 0, 0); //Letra color blanco
$fpdf->Cell(25,8,"Se Carga:",1,0,'L',0);
$fpdf->Cell(15,8,$resp->secarga,1,0,'C',0);

$fpdf->Cell(30,8,"Se Descaga:",1,0,'L',0);
$fpdf->Cell(15,8,$resp->sedescarga,1,0,'C',0);

$fpdf->Cell(40,8,"Maneja Efectivo:",1,0,'L',0);
$fpdf->Cell(15,8,$resp->efectivo,1,0,'C',0);

$fpdf->Cell(30,8,"Días Libres:",1,0,'L',0);
$fpdf->Cell(15,8,$resp->dias_libres,1,1,'C',0);

$fpdf->SetX(50);
$fpdf->Cell(65,8,"Prom. Entregas Por Viaje:",1,0,'L',0);
$fpdf->MultiCell(120,8,$resp->entregas,1,'L',0);

$fpdf->SetX(50);
$fpdf->Cell(65,8,"Prom. Kilometros Recorridos:",1,0,'L',0);
$fpdf->MultiCell(120,8,$resp->recorrido,1,'L',0);

$fpdf->SetX(50);
$fpdf->Cell(65,8,"Frecuencua de Viajes:",1,0,'L',0);
$fpdf->MultiCell(120,8,$resp->frecuencua,1,'L',0);

$fpdf->SetX(50);
$fpdf->Cell(65,8,"Comentario:",1,0,'L',0);
$fpdf->MultiCell(120,8,$resp->comentario_operacion,1,'L',0);


$fpdf->Ln(5);
$fpdf->SetX(15);
$fpdf->SetTextColor(240, 255, 240); //Letra color blanco
$fpdf->SetFillColor(37,150,190);//Fondo verde de celda
$fpdf->Cell(250,8,"TARIFAS TARGET",1,1,'C',1);

$fpdf->Ln(5);
$lineheight = 8;
$fpdf->SetFont('Arial','B',10);
$fpdf->SetTextColor(0, 0, 0); //Letra color blanco
$fpdf->SetX(15);
$tableTT = array(array('Tipo de Unidad','Fianza','Tarifa Venta','Tarifa Costo','Signo','Lugar Carga','Lugar Descarga'));
$widths = array(39,15,25,25,15,66,66);
$fpdf->plot_table($widths, $lineheight, $tableTT);
//$table = array(array('Cantidad Unidades', 'Hi2', 'Hi3'), array('Hi4', 'Hi5 (xtra)', 'Hi6'), array('Hi7', 'Hi8', 'Hi9'));


$fpdf->Ln(1);
$fpdf->SetFont('Arial','',10);
foreach ($TT as $reg) {
    $fpdf->SetX(15);

    $tableTTD = array(array($reg->unidad, $reg->fianza, strval($reg->venta), strval($reg->costo), $reg->signo, $reg->lugar_carga,$reg->lugar_descarga));
    $widths = array(39,15,25,25,15,66,66);
    $fpdf->plot_table($widths, $lineheight, $tableTTD);
}

$fpdf->Ln(5);

$fpdf->SetX(15);
$fpdf->SetFont('Arial','B',12);
$fpdf->SetTextColor(240, 255, 240); //Letra color blanco
$fpdf->SetFillColor(37,150,190);//Fondo verde de celda
$fpdf->Cell(250,8,"TARIFAS TARGET SERVICIOS ADICIONALES",1,1,'C',1);
$fpdf->Ln(5);


$lineheight = 8;
$fpdf->SetFont('Arial','B',10);
$fpdf->SetTextColor(0, 0, 0); //Letra color blanco
$fpdf->SetX(15);
$tableTS = array(array('Servicio','Tarifa Venta','Tarifa Costo','Signo','Lugar de Carga','Lugar Descarga'));
$widths = array(54,25,25,15,66,66);
$fpdf->plot_table($widths, $lineheight, $tableTS);
//$table = array(array('Cantidad Unidades', 'Hi2', 'Hi3'), array('Hi4', 'Hi5 (xtra)', 'Hi6'), array('Hi7', 'Hi8', 'Hi9'));

$fpdf->Ln(1);
$fpdf->SetFont('Arial','',10);
foreach ($TTS as $reg) {
    $fpdf->SetX(15);

    $tableTSD = array(array($reg->servicio, strval($reg->venta), strval($reg->costo), $reg->signo, $reg->lugar_carga, $reg->lugar_descarga));
    $widths = array(54,25,25,15,66,66);
    $fpdf->plot_table($widths, $lineheight, $tableTSD);
}

$fpdf->Ln(5);

$fpdf->SetX(50);
$fpdf->SetFont('Arial','B',12);
$fpdf->SetTextColor(240, 255, 240); //Letra color blanco
$fpdf->SetFillColor(37,150,190);//Fondo verde de celda
$fpdf->Cell(184,8,"DATOS DE LA OPERACION",1,1,'C',1);
$fpdf->Ln(1);

$lineheight = 8;
$fpdf->SetFont('Arial','B',10);
$fpdf->SetTextColor(0, 0, 0); //Letra color blanco
$fpdf->SetX(50);
$table = array(array('Botas','Chaleco','Lentes','Guantes','Mascarilla','Careta','Otros'));
$widths = array(23,23,23,23,23,23,46);
$fpdf->plot_table($widths, $lineheight, $table);

$botas = $resp->botas==1? 'X':'';
$chaleco = $resp->chaleco==1? 'X':'';
$lentes = $resp->lentes==1? 'X':'';
$guantes = $resp->guantes==1? 'X':'';
$mascarilla = $resp->mascarilla==1? 'X':'';
$careta = $resp->careta==1? 'X':'';

$fpdf->Ln(0.5);
$fpdf->SetX(50);
$table = array(array($botas,$chaleco,$lentes,$guantes,$mascarilla,$mascarilla,$resp->otros));
$widths = array(23,23,23,23,23,23,46);
$fpdf->plot_table($widths, $lineheight, $table);

if ($tipo==1){
    $fpdf->Output();
}else{
    $fpdf->Output($ruta.$nombrearchivo,'F');
}

$ruta = $ruta.$nombrearchivo;

$correo = new Correo();

if ($tipo==2){
    $asunto = 'Evaluacion de Proyecto No. '.$codigo;
    $cuerpoCorreo = '<div style="font-family: Arial,Regular; font-size: 14px; line-height: 160%;">
                        <div style="font-size: 18px; padding: 14px 36px 0px; color: #4e4e4e;">
                            Evaluacion de Proyecto Truck And Delivery
                        </div>    
                        <div style="padding: 14px 36px 0px; color: #4e4e4e;">
                            Adjunto  Encontrara La Evaluacion de Proyecto No. 
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