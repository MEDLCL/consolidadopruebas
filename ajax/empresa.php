<?php
include_once "../config/funciones.php";
include_once "../modelos/empresa.php";
$empresa = new Empresa();

$idempresa = isset($_POST['idemprea']) ? $idempresa = limpia($_POST['idempresa']) : $idempresa = 0;
$codigo = isset($_POST['codigo']) ? $codigo = limpia($_POST['codigo']) : $codigo = '';
$tipoE = isset($_POST['tipoE']) ? $tipoE = limpia($_POST['tipoE']) : $tipoE = '';

$razons = isset($_POST['Razons']) ? $razons = limpia($_POST['Razons']) : $razons = '';
$nombrec = isset($_POST['Nombrec']) ? $nombrec = limpia($_POST['Nombrec']) : $nombrec = '';
$nit = isset($_POST['identificacion']) ? $nit = limpia($_POST['identificacion']) : $nit = '';
$telefono = isset($_POST['telefono']) ? $telefono = limpia($_POST['telefono']) : $telefono = '';
$dire = isset($_POST['direccion']) ? $dire = limpia($_POST['direccion']) : $dire = '';
$comision = isset($_POST['comision']) ? $comision = limpia($_POST['comision']) : $comision = 0;
$cbmtarifa = isset($_POST['cbmtarifa']) ? $cbmtarifa = limpia($_POST['cbmtarifa']) : $cbmtarifa = '';

switch ($_GET['op']) {
    case 'guardaryeditar':
        if ($idempresa == 0) {
            $res = $empresa->grabar($codigo, $tipoE, $razons, $nombrec, $nit, $telefono, $dire, $comision, $cbmtarifa, $_POST['nombresc'], $_POST['apellidosc'], $_POST['correosc'], $_POST['telefonosc'], $_POST['puestosc']);
        }
        break;

    default:
        # code...
        break;
}
