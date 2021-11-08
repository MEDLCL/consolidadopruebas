<?php
require_once "../config/Conexion.php";
require_once "../config/funciones.php";
require_once "../modelos/banco.php";

$banco = new banco();

/*-- `id_banco` INT NOT NULL AUTO_INCREMENT,
  `id_sucursal` INT NULL,
  `id_usuario` INT NULL,
  `nombre` VARCHAR(75) NULL,
  `ejecutivo` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `extension` VARCHAR(5) NULL,
  `correo` VARCHAR(75) NULL,
  `observaciones` VARCHAR(250) NULL, -->*/

$idbanco = isset($_POST["idbanco"]) ? $idcatalogo = $_POST["idbanco"] : $idcatalogo = 0;
$nombre = isset($_POST["nombreBanco"]) ? $nombre = $_POST["nombreBanco"] : $nombre = "";
$ejecutivo = isset($_POST['ejecutivo']) ? $ejecutivo = limpia($_POST['ejecutivo']) : $ejecutivo = "";
$telefono = isset($_POST["telefonobanco"]) ? $telefono = $_POST["telefonobanco"] : $telefono = "";
$ext = isset($_POST["extensionBanco"]) ? $ext = $_POST["extensionBanco"] : $ext = "";
$correo = isset($_POST['correo']) ? $correo = limpia($_POST['correo']) : $correo = "";
$obser = isset($_POST["bancoObser"]) ? $obser = $_POST["bancoObser"] : $obser = 0;



switch ($_GET["op"]) {
    case 'guardaryeditar':
        if ($idbanco == 0 || $idbanco == "") {
            $resp = $banco->grabar($idbanco, $nombre, $ejecutivo, $telefono, $ext, $correo, $obser);
            echo json_encode($resp);
        } else {
            $resp = $banco->editar($idbanco, $nombre, $ejecutivo, $telefono, $ext, $correo, $obser);
            echo json_encode($resp);
        }
        break;
    case 'mostarBanco':
        $resp = $banco->mostrarBanco($idbanco);
        echo json_encode($resp);
        //echo $resp;
        break;
}
