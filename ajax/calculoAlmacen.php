<?php

require_once "../config/Conexion.php";
require_once "../config/funciones.php";
require_once "../modelos/calculoAlmacen.php";

$calculo = new calculoAlmacen();


$iddetalleAlmacen = isset($_POST["iddetalleAlmacen"]) ? $iddetalleAlmacen = $_POST["iddetalleAlmacen"] : $iddetalleAlmacen = 0;
$del = isset($_POST['delCalculo']) ? $del= limpia($_POST['delCalculo']) : $del= date('Y-m-d');
$al = isset($_POST['alcalculo']) ? $al = limpia($_POST['alcalculo']) : $al = date('Y-m-d');
$idplantilla = isset($_POST['idplantilla']) ?  $idplantilla= limpia($_POST['idplantilla']) : $idplantilla = '';
$impuesto = isset($_POST['impuesto']) ? $impuesto = $_POST['impuesto'] : $impuesto = 0;
$baseParaS= isset($_POST['baseparas'])? $baseParaS = $_POST['baseparas']: $baseParaS = 0 ;
$peso = isset($_POST['peso']) ? limpia($_POST['peso']) : $peso = 0;
$volumen = isset($_POST['volumen']) ? limpia($_POST['volumen']) : $volumen = 0;
$bultos = isset($_POST['bultos']) ? limpia($_POST['bultos']) : $bultosT = 0;
$cntclie = isset($_POST['cntclie']) ? $cntclie =limpia($_POST['cntclie']) : $cntclie = 0;
$diaslibres = isset($_POST['diaslibres']) ?$diaslibres= limpia($_POST['diaslibres']) : $diaslibres = 0;
$tminimo = isset($_POST["tminimo"]) ? $tminimo= limpia($_POST["tminimo"]) : $tminimo = 0; 
$dcompleto = isset($_POST["dcompleto"])? $dcompleto = limpia($_POST["dcompleto"]):$dcompleto= 0;
$diasalma = isset($_POST["diasAlmacenaje"])?$diasalma = limpia($_POST["diasAlmacenaje"]):$diasalma = 0;
$totaldias = isset($_POST["totaldias"]) ? $totaldias = limpia($_POST['totaldias']):$totaldias =0;
$tipocambio = isset($_POST["tipocambio"])?$tipoCambio = limpia($_POST["tipocambio"]):$tipocambio =0 ;
if ($impuesto == ""){
    $impuesto = 0;
}
if ($baseParaS==""){
    $baseParaS =0 ;
}

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
        $rspt = $calculo->mostrarPlantillaCalcular($idplantilla);

        mb_internal_encoding('UTF-8');
        //se declara un array para almacenar todo el query
        $data = array();
        
        foreach ($rspt as $reg) {
            $data[] = array(
                "0" => $reg->nombre,
                "1" => $reg->signo,
                "2" => $calculo->calculosDescripciones($reg->nombre,$reg->minimo,$reg->tarifa,$reg->porcentaje,$impuesto,$diasalma,$reg->OA,$reg->dias_libres,$baseParaS,$totaldias,$peso,$tipocambio),
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
