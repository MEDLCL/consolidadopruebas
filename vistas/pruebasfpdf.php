<?php
require "../plantilla/plugins/fpdf184/fpdf.php";
class PDF extends FPDF{
    function Header()
    {
        $this->SetFont('Arial','',12);//definimos tipo y tamaño de letra
        $this->Image('../logos/1604900509.png',0,8,70);//agregamos una imagen imagen,poiscionx,posiciony, tamaño
        $this->SetXY(80,15);
        $this->Cell(100,8,utf8_decode("Titulo del reporte"),1,1,'C',0);
        $this->Ln(40);
    }
    function Footer()
    {
        $this->SetY(-15);
        $this->SetFont('Arial','',12);  
        $this->Cell(0,10,utf8_decode("Pagina").$this->PageNo().' / {nb}',0,0,'C'); 

    }
}

$fpdf = new PDF();
$fpdf->AddPage();//agregamos una pagina
$fpdf->SetMargins(10,10,10);
$fpdf->SetAutoPageBreak(true,20);
//$fpdf->SetFont('Arial','',12);//definimos tipo y tamaño de letra
//$fpdf->Image('../logos/1604900509.png',0,8,70);//agregamos una imagen imagen,poiscionx,posiciony, tamaño
//$fpdf->Ln(10);
//$fpdf->SetXY(70,5);//posiccion en x y lo que siga despues
//for ($i=1;$i<=10;$i++)
//    $fpdf->SetX(70);//posicion solo en x
//    $fpdf->Cell(50,10,utf8_decode("prueba"),1,1);//agrega texto a la celdas,ancho, alto, texto,border,salto de linea,posicion,relleno ono
//$fpdf->AddPage();
//$fpdf->Write(5,'Hola Mundo');
//$fpdf->SetXY(80,15);
//$fpdf->Cell(100,8,utf8_decode("Titulo del reporte"),1,1,'C',0);
//$fpdf->Ln(40);
$fpdf->SetX(15);
$fpdf->SetFont('Helvetica','B',15);
$fpdf->Cell(10,8,utf8_decode("N"),1,0,'C',0);
$fpdf->Cell(60,8,utf8_decode("Producto"),1,0,'C',0);
$fpdf->Cell(30,8,utf8_decode("Costo"),1,0,'C',0);
$fpdf->Cell(35,8,utf8_decode("Cantidad"),1,0,'C',0);
$fpdf->Cell(50,8,utf8_decode("Total"),1,1,'C',0);

$fpdf->SetFillColor(233,229,235);//color del borde
$fpdf->SetDrawColor(181,14,246);//color de fondo de cada celda

$fpdf->Ln(0.5);

//$fpdf->SetXY(70,5);//posiccion en x y lo que siga despues
for ($i=1;$i<=50;$i++){
    $fpdf->ln(0.5);
    $fpdf->SetX(15);//posicion solo en x
    $fpdf->Cell(10,8,$i,1,0,'C',1);// el ultimo al colocar 1 indica el color de fondo de la celda
    $fpdf->Cell(60,8,'Leche',1,0,'C',0);
    $fpdf->Cell(30,8,'$',1,0,'C',0);
    $fpdf->Cell(35,8,2,1,0,'C',0);
    $fpdf->Cell(50,8,40,1,1,'C',0);
}

$fpdf->Output();
?>