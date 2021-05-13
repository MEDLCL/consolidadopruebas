<?php

require_once "../config/Conexion.php";
require_once "../config/funciones.php";
require_once "../modelos/calculoAlmacen.php";

$calculo = new calculoAlmacen();


$iddetalleAlmacen = isset($_POST["iddetalleAlmacen"]) ? $idsucursal = $_POST["iddetalleAlmacen"] : $idsucursal = 0;
$del = isset($_POST['delCalculo']) ? limpia($_POST['delCalculo']) : $del= date('Y-m-d');
$al = isset($_POST['alcalculo']) ? limpia($_POST['alcalculo']) : $al = date('Y-m-d');
$idplantilla = isset($_POST['idplantilla']) ?$idplantilla= limpia($_POST['idplantilla']) : $idplantilla = '';
/*$referencia = isset($_POST['referencia']) ? $_POST['referencia'] : $referencia = 0;
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

    case 'contarDias':
        $fechadel = new DateTime ($del);
        $fechahasta = new DateTime($al);
        $diff = $fechadel->diff($fechahasta);
        $dias = $diff->days;
        echo intval($dias) + 1;
        break;
    case 'calcular':
        $rspt = $calculo->calcular($idplantilla);

        mb_internal_encoding('UTF-8');
        //se declara un array para almacenar todo el query
        $data = array();
        
        foreach ($rspt as $reg) {
            $data[] = array(
                "0" => $reg->nombre,
                "1" => '',
                "2" => '',
                "3" => '',
                "4" => '',
                "5" => '',
                "6" => ''
            );
        }
        $results = array(
            "sEcho" => 1, //informacion para el datatable
            "iTotalRecords" => count($data), //enviamos el total al datatable
            "iTotalDisplayRecords" => count($data), //enviamos total de rgistror a utlizar
            "aaData" => $data
        );
        echo json_encode($results);

        break;    

}
