<?php
require_once "../config/Conexion.php";
require_once "../config/funciones.php";
require_once "../modelos/catalogo.php";

$catalogo = new catalogo();

$idcatalogo = isset($_POST["idcatalogo"]) ? $idcatalogo = $_POST["idcatalogo"] : $idcatalogo = 0;
$nombreDescripcion = isset($_POST["nombreDescripcion"]) ? $nombreDescripcion = $_POST["nombreDescripcion"] : $nombreDescripcion = "";
$nombreDescripcionIngles = isset($_POST['nombreDescripcionIngles']) ? $nombreDescripcionIngles= limpia($_POST['nombreDescripcionIngles']) : $nombreDescripcionIngles = 0;
$codigo = isset($_POST['codigoCatalogo']) ? $codigo= limpia($_POST['codigoCatalogo']) : $codigo = '';


switch ($_GET["op"]) {
    case 'guardaryeditar':
        if ($idcatalogo == 0 || $idcatalogo == "") {
            $resp = $catalogo->grabar($nombreDescripcion,$nombreDescripcionIngles,$codigo);
            echo $resp;
        } else {
            $resp = $catalogo->editar($idcatalogo, $nombreDescripcion,$nombreDescripcionIngles,$codigo);
            echo $resp;
        }
        break;

    case 'mostrarC':
        $rsp = $catalogo->mostrarCatalogo($idcatalogo);
        echo json_encode($rsp);
        break;
}
