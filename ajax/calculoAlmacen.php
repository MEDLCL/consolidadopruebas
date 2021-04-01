<?php

require_once "../config/Conexion.php";
require_once "../config/funciones.php";
require_once "../modelos/calculoAlmacen.php";

$calculo = new calculoAlmacen();


$iddetalleAlmacen = isset($_POST["iddetalleAlmacen"]) ? $idsucursal = $_POST["iddetalleAlmacen"] : $idsucursal = 0;
/* $idconsignado = isset($_POST['consignado']) ? limpia($_POST['consignado']) : $idconsignado = '';
$contenedor = isset($_POST['contenedor']) ? limpia($_POST['contenedor']) : $contenedor = '';
$poliza = isset($_POST['poliza']) ? limpia($_POST['poliza']) : $poliza = '';
$referencia = isset($_POST['referencia']) ? $_POST['referencia'] : $referencia = 0;
$pesoT = isset($_POST['pesoT']) ? limpia($_POST['pesoT']) : $pesoT = '';
$volumenT = isset($_POST['volumenT']) ? limpia($_POST['volumenT']) : $volumenT = '';
$bultosT = isset($_POST['bultosT']) ? limpia($_POST['bultosT']) : $bultosT = '';
$codigoA = isset($_POST['codigoAlmacen']) ? limpia($_POST['codigoAlmacen']) : $codigoA = '';
$fechaI = isset($_POST['fechaI']) ? limpia($_POST['fechaI']) : $fechaI = '';
$cant_clientes = isset($_POST["cntClientes"]) ? limpia($_POST["cntClientes"]) : $cant_clientes = ""; */

switch ($_GET["op"]) {
    case 'guardaryeditar':
        
        break;

    case 'mostrar':

        break;

    case 'MostrarCalculoNuevo':
        $rspt = $calculo->MostrarNuevoCalculo($iddetalleAlmacen);
        mb_internal_encoding('UTF-8');
        echo json_encode($rspt);
        break;

    case 'listarCliente':
        $rspt = $calculo->listarCliente($iddetalleAlmacen);
        $selec = '<option value="0" selected>Seleccione una Opcion</option>';
        foreach ($rspt as  $resp) {
            $selec = $selec . '<option value="' . $resp->id_empresa . '">' . $resp->Razons . '</option>';
        }
        echo $selec;
        break;

    case 'mostrarA':
      
}
