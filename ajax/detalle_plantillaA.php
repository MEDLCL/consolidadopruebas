<?php
require_once "../config/Conexion.php";
require_once "../config/funciones.php";
require_once "../modelos/kardex.php";

$detalleP = new detallePlantilla();

$idmoneda ==isset($_POST["idMonedaPlantillaMP"]) ? $idmoneda = $_POST["idMonedaPlantillaMP"] : $idmoneda = 0; 
$idplantilla =isset($_POST["idplantillaMP"]) ? $idplantilla = $_POST["idplantillaMP"] : $idplantilla = 0; 
$iddetalle = isset($_POST["iddetallePlnatilla"]) ? $iddetalle = $_POST["iddetallePlnatilla"] : $iddetalle = 0;
$idcatalogo = isset($_POST['catalogoPlantillaAlmacen']) ? $idcatalogo= limpia($_POST['catalogoPlantillaAlmacen']) : $idcatalogo = 0;
$minimo = isset($_POST['minimoDetallePlantillaA']) ? $minimo= limpia($_POST['minimoDetallePlantillaA']) : $minimo = 0;
$tarifa = isset($_POST['tarifaDetallePlantillaA']) ? $tarifa= limpia($_POST['tarifaDetallePlantillaA']) : $tarifa = 0;
$porcentaje = isset($_POST['porcentajeDetallePA']) ? $porcentaje= $_POST['porcentajeDetallePA'] : $porcentaje = 0;
$porpeso = isset($_POST['porPeso']) ?$porpeso= limpia($_POST['porPeso']) : $porpeso = 0;
$porvolumen = isset($_POST['porVolumen']) ?$porvolumen= limpia($_POST['porVolumen']) : $porvolumen = 0;
$pordia = isset($_POST['porDia']) ? $pordia=limpia($_POST['porDia']) : $pordia = 0;



switch ($_GET["op"]) {
    case 'guardaryeditar':
        if ($idalmacen == 0 || $idalmacen == "") {
            $resp = $detalleP->grabar($idplantilla,$idcatalogo,$idmoneda,$minimo,$tarifa,$porcentaje,$porpeso,$porvolumen,$pordia);
            echo $resp;
        } else {
            $resp = $detalleP->editarDetalle($iddetalle,$idcatalogo,$minimo,$tarifa,$porcentaje,$porpeso,$porvolumen,$pordia);
            echo $resp;
        }
        break;

    case 'mostrar':

        break;

    case 'listarDP':
        $rspt = $detalleP->listarDetallePlantilla($idplantilla);
        $acciones = '';
        $estado = 0;
        mb_internal_encoding('UTF-8');
        //se declara un array para almacenar todo el query
        $data = array();
        foreach ($rspt as $reg) {
         
            $data[] = array(
                "0" => $acciones,
                "1" => $estado,
                "2" => $reg->annio,
                "3" => $reg->Codigo,
                "4" => $reg->consignado,
                "5" => $reg->contenedor_placa,
                "6" => $reg->poliza,
                "7" => $reg->referencia,
                "8" => $reg->fecha_almacen,
                "9" => $reg->cliente_Final,
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

    case 'mostrarA':
        $rsp = $detalleP->muestraAlmacen($idalmacen);
        echo json_encode($rsp);
        break;
}
