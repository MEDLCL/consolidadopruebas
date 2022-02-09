<?php
require_once "../config/Conexion.php";
require_once "../config/funciones.php";
require_once "../modelos/asignaBarco.php";

$asignaBarco = new asignaBarco();

$idembarque =isset($_POST["idEmbarquemBarco"]) ? $idcatalogo = $_POST["idEmbarquemBarco"] : $idcatalogo = 0;
$idbarco = isset($_POST["barcoLlegada"]) ? $idbarco = $_POST["barcoLlegada"] : $idbarco = 0;
$viaje = isset($_POST["ViajeLlegada"]) ? $viaje = $_POST["ViajeLlegada"] : $viaje = "";
$etd = isset($_POST['etdOP']) ? $etd= limpia($_POST['etdOP']) : $etd = date('Y-m-d');
$eta = isset($_POST['etaOP']) ? $eta= limpia($_POST['etaOP']) : $eta = date('Y-m-d');

$ceta =  isset($_POST['cetaOP']) ? $ceta= limpia($_POST['cetaOP']) : $ceta = "";
$etaNaviera =isset($_POST['etaNavieraOP']) ? $etaNaviera= limpia($_POST['etaNavieraOP']) : $etaNaviera = "";
$completo = isset($_POST['completoOP']) ? $completo= limpia($_POST['completoOP']) : $completo = "";
$piloto = isset($_POST['pilotoOP']) ? $piloto= limpia($_POST['pilotoOP']) : $piloto = "";
$descarga=  isset($_POST['descargaOP']) ? $descarga= limpia($_POST['descargaOP']) : $descarga = "";
$liberado = isset($_POST['liberadoOP']) ? $liberado= limpia($_POST['liberadoOP']) : $liberado = "";
$devuelto = isset($_POST['devueltoOP']) ? $devuelto= limpia($_POST['devueltoOP']) : $devuelto = "";


switch ($_GET["op"]) {
    case 'guardaryeditar':
            $resp = $asignaBarco->grabarBarco($idembarque,$idbarco,$viaje,$etd,$eta,$ceta,$etaNaviera,$completo,$piloto,$descarga,$liberado,$devuelto);
            echo json_encode($resp);
        break;
}
