<?php
require_once "../config/Conexion.php";
require_once "../config/funciones.php";
require_once "../modelos/barco.php";

$barco = new barco();

$idbarco = isset($_POST["idbarco"]) ? $idcatalogo = $_POST["idbarco"] : $idcatalogo = 0;
$nombre = isset($_POST["nombreBarco"]) ? $nombre = $_POST["nombreBarco"] : $nombre = "";
$bandera = isset($_POST['bandera']) ? $bandera= limpia($_POST['bandera']) : $bandera = "";



switch ($_GET["op"]) {
    case 'guardaryeditar':
        if ($idbarco == 0 || $idbarco == "") {
            $resp = $barco->grabar($nombre,$bandera);
            echo $resp;
        } else {
            $resp = $barco->editar($idbarco, $nombre,$bandera);
            echo $resp;
        }
        break;

    case 'mostrarB':
        $rsp = $barco->mostarBarco($idbarco);
        echo json_encode($rsp);
        break;
}
