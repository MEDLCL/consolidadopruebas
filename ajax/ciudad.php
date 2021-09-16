<?php
require_once "../config/Conexion.php";
require_once "../config/funciones.php";
require_once "../modelos/ciudad.php";

$ciudad = new ciudad();

$idpais = isset($_POST["paisCiudad"]) ? $idpais = $_POST["paisCiudad"] : $idpais = 0;
$idciudad = isset($_POST['idciudad']) ? $idciudad= limpia($_POST['idciudad']) : $idciudad = "";
$nombre = isset($_POST["nombreCiudad"]) ? $nombre = $_POST["nombreCiudad"] : $nombre = "";


switch ($_GET["op"]) {
    case 'guardaryeditar':
        if ($idciudad == 0 || $idciudad == "") {
            $resp = $ciudad->grabar($idpais,$nombre);
            echo $resp;
        } else {
            $resp = $ciudad->editar($idciudad, $nombre);
            echo $resp;
        }
        break;

    case 'mostrarC':
        $rsp = $ciudad->mostrarCiudad($idciudad);
        echo json_encode($rsp);
        break;
}
