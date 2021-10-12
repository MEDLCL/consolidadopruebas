<?php
// Downloads files
if (isset($_GET['nombre_archivo'])) {
    $ruta = $_GET['ubicacion'];
    $filename = $_GET['nombre_archivo']; 
    $filepath = $ruta.'/' . $filename;

    if (file_exists($filepath)) {
        header('Content-Description: File Transfer');
        header('Content-Type: application/octet-stream');
        header('Content-Disposition: attachment; filename=' . basename($filepath));
        header('Expires: 0');
        header('Cache-Control: must-revalidate');
        header('Pragma: public');
        header('Content-Length: ' . filesize('uploads/' . $filename));
        readfile('uploads/' . $filename);
        exit;
    }

}
