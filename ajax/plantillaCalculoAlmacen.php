<?php
require_once "../config/Conexion.php";
require_once "../config/funciones.php";
require_once "../modelos/plantillaCalculoAlmacen.php";

$plantillaA = new plantillaA();

$idplantilla = isset($_POST["idplantillaG"]) ? $idplantilla = $_POST["idplantillaG"] : $idplantilla = 0;
$nombreP = isset($_POST["nombrePlantillaG"]) ? $nombreP = $_POST["nombrePlantillaG"] : $nombreP = "";
$tarifaM = isset($_POST['tarifaMinimaG']) ? $tarifaM= limpia($_POST['tarifaMinimaG']) : $tarifaM = 0;
$diasL = isset($_POST['diasLibresPlantillaG']) ? $diasL=limpia($_POST['diasLibresPlantillaG']) : $diasL = 0;
$omitirD = isset($_POST['omitirDiasLibre']) ?$omitirD= limpia($_POST['omitirDiasLibre']) : $omitirD = 0;
$moneda = isset($_POST['monedaPlantillaG']) ?$moneda= limpia($_POST['monedaPlantillaG']) : $moneda = 0;


switch ($_GET["op"]) {
    case 'guardaryeditar':
        if ($idplantilla == 0 || $idplantilla == "") {
            $resp = $plantillaA->grabar($nombreP,$tarifaM,$diasL,$omitirD,$moneda);
            echo $resp;
        } else {
            $resp = $plantillaA->editar($idplantilla, $nombreP,$tarifaM,$diasL,$omitirD,$moneda);
            echo $resp;
        }
        break;

    case 'mostrarP':
        $rsp = $plantillaA->mostrarPlantilla($idplantilla);
        echo json_encode($rsp);
        break;
}
