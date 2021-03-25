<?php
require_once "../config/Conexion.php";
require_once "../config/funciones.php";
require_once "../modelos/detalleAlmacen.php";

$detalleA = new detalleAlmacen();


$idalmacen = isset($_POST["idAlmacenD"]) ? $idsucursal = $_POST["idAlmacenD"] : $idsucursal = 0;
$iddetalleA = isset($_POST["iddetallealmacen"]) ? $iddetalleA = $_POST["iddetallealmacen"] : $iddetalleA = 0;
$idcliente = isset($_POST['cliente']) ? limpia($_POST['cliente']) : $idconsignado = 0;
$nohbl = isset($_POST['nohbl']) ? limpia($_POST['nohbl']) : $contenedor = '';
$peso = isset($_POST['peso']) ? limpia($_POST['peso']) : $peso = 0;
$ubicacion = isset($_POST['ubicacion']) ? $_POST['ubicacion'] : $ubicacion = "";
$volumen = isset($_POST['volumen']) ? limpia($_POST['volumen']) : $volumen = 0;
$dut = isset($_POST['dut']) ? limpia($_POST['dut']) : $dut = '';
$bultos = isset($_POST['bultos']) ? limpia($_POST['bultos']) : $bultos = '';
$embalajeD = isset($_POST['embalajeD']) ? limpia($_POST['embalajeD']) : $embalajeD = 0;
$liberado = isset($_POST['liberado']) ? limpia($_POST['liberado']) : $liberado = 0;
$resa = isset($_POST["resa"]) ? limpia($_POST["resa"]) : $resa = "";
$dti = isset($_POST['dti']) ? limpia($_POST['dti']) : $dti = "";
$ncancel = isset($_POST['ncancel']) ? limpia($_POST['ncancel']) : $ncancel = "";
$norden = isset($_POST["norden"]) ? limpia($_POST["norden"]) : $norden = "";
$mercaderia = isset($_POST['mercaderia']) ? limpia($_POST['mercaderia']) : $mercaderia = "";
$observaciones = isset($_POST['observaciones']) ? limpia($_POST['observaciones']) : $observaciones = "";
$linea  = isset($_POST['linea']) ? limpia($_POST['linea']) : $linea = "";


switch ($_GET["op"]) {
    case 'guardaryeditar':
        if ($iddetalleA == 0 || $iddetalleA == "") {
            $resp = $detalleA->grabar($idalmacen, $idcliente, $nohbl, $ubicacion, $peso, $volumen, $dut, $bultos, $embalajeD, $liberado, $resa, $dti, $ncancel, $norden, $mercaderia, $observaciones, $linea);
            echo $resp;
        } else {
            $resp = $detalleA->editarDAlmacen($iddetalleA, $idcliente, $nohbl, $ubicacion, $peso, $volumen, $dut, $bultos, $embalajeD, $liberado, $resa, $dti, $ncancel, $norden, $mercaderia, $observaciones, $linea);
            echo $resp;
        }
        break;

    case 'listarDA':
        $rspt = $detalleA->listar($idalmacen);
        $acciones = "";
        $estado = 0;
        mb_internal_encoding('UTF-8');
        //se declara un array para almacenar todo el query
        $data = array();
        foreach ($rspt as $reg) {
            $acciones = "";
            $estado = 0;
            if ($reg->estado == 1) {
                $acciones = '<div class="btn-group">
                    <button type="button" class="btn btn-success dropdown-toggle btn-sm" data-toggle="dropdown">
                        <span class="fa fa-cog"></span>
                        Acciones
                        <span class="caret"></span>
                        <span class="sr-only">Desplegar menú</span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="#"Editar onclick = "mostrarDetalleA(' . $reg->id_detalle . ')">Editar</a></li>
                        <li><a href="#" onclick= "anulaDetalle(' . $reg->id_detalle . ')">Anular</a></li>
                    </ul>
                    </div>';
                $estado = '<span class="label bg-green">Activo</span>';
            } else {
                $estado = '<span class="label bg-red">Anulado</span>';
            }
            $data[] = array(
                "0" => $acciones,
                "1" => $estado,
                "2" => $reg->cliente,
                "3" => $reg->nohbl,
                "4" => $reg->peso,
                "5" => $reg->volumen,
                "6" => $reg->bultos,
                "7" => $reg->ubicacion,
                "8" => $reg->empaque,
                "9" => $reg->dut,
                "10" => $reg->liberado,
                "11" => $reg->linea,
                "12" => $reg->resa,
                "13" => $reg->dti,
                "14" => $reg->no_cancel,
                "15" => $reg->no_orden,
                "16" => $reg->mercaderia,
                "17" => $reg->observaciones
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

    case 'mostrarDetalleA':
        $rsp = $detalleA->muestraDAlmacen($iddetalleA);
        echo json_encode($rsp);
        break;
    case 'anularDetalle':
        $rsp = $detalleA->anularDetalle($iddetalleA);
        echo $rsp;
        break;
}
