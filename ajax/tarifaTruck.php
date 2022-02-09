<?php
require_once "../config/Conexion.php";
require_once "../config/funciones.php";
require_once "../modelos/tarifaTruck.php";

$tarifario = new tarifaTruck();

$idtarifaflete  = isset($_POST["idtarifaflete"]) ? $idtarifaflete = $_POST["idtarifaflete"] : $idtarifaflete = 0;
$origenTarifa = isset($_POST["origenTarifa"]) ? $origenTarifa = $_POST["origenTarifa"] : $origenTarifa = "";
$destinoTarifa = isset($_POST["destinoTarifa"]) ? $destinoTarifa = $_POST["destinoTarifa"] : $destinoTarifa = "";
$tipoUnidadTarifa = isset($_POST['tipoUnidadTarifa']) ? $tipoUnidadTarifa = limpia($_POST['tipoUnidadTarifa']) : $tipoUnidadTarifa = 0;
$pilotoTarifa = isset($_POST["pilotoTarifa"]) ? $pilotoTarifa = $_POST["pilotoTarifa"] : $pilotoTarifa = 0;
$numeroayudantes = isset($_POST["numeroPilotos"]) ? $numeroayudantes = $_POST["numeroPilotos"] : $numeroayudantes = 0;
$validezTarifaFlete = isset($_POST['validezTarifaFlete']) ? $validezTarifaFlete = limpia($_POST['validezTarifaFlete']) : $validezTarifaFlete = date('Y-m-d');
$tipoCargaTarifa = isset($_POST["tipoCargaTarifa"]) ? $tipoCargaTarifa = $_POST["tipoCargaTarifa"] : $tipoCargaTarifa = 0;
$tarifaVentaFlete = isset($_POST["tarifaVentaFlete"]) ? $tarifaVentaFlete = $_POST["tarifaVentaFlete"] : $tarifaVentaFlete = 0;
$tarifaCostoFlete = isset($_POST["tarifaCostoFlete"]) ? $tarifaCostoFlete = $_POST["tarifaCostoFlete"] : $tarifaCostoFlete = 0;
$idproyecto = isset($_POST["idproyecto"]) ? $idproyecto = $_POST["idproyecto"] : $idproyecto = 0;
$monedaTarifaFlete = isset($_POST["monedaTarifaFlete"]) ? $monedaTarifaFlete = $_POST["monedaTarifaFlete"] : $monedaTarifaFlete = 0;


switch ($_GET["op"]) {
    case 'grabarEditarTarifaF':
        if ($idtarifaflete == 0 || $idtarifaflete == "") {
            $resp = $tarifario->grabar($origenTarifa,$destinoTarifa,$tipoUnidadTarifa,$pilotoTarifa,$numeroayudantes,$validezTarifaFlete,$tipoCargaTarifa,$tarifaVentaFlete,$tarifaCostoFlete,$monedaTarifaFlete,$idproyecto);
            echo json_encode($resp);
        } else {
            $resp = $tarifario->editar($origenTarifa,$destinoTarifa,$tipoUnidadTarifa,$pilotoTarifa,$numeroayudantes,$validezTarifaFlete,$tipoCargaTarifa,$tarifaVentaFlete,$tarifaCostoFlete,$monedaTarifaFlete,$idtarifaflete);
            echo json_encode($resp);
        }
        break;
    case 'listarTarifasFlete':
        $rspt = $tarifario->listarTarifasFlete($idproyecto);
        $acciones= "";
            mb_internal_encoding('UTF-8');
            //se declara un array para almacenar todo el query
            $data = array();
            foreach ($rspt as $reg) {
                    $acciones = "<button type= 'button' class='btn btn-warning btn-sm' onclick='listarTarifaflete(". $reg->id_tarifario_truck .")' ><i class='fa fa-pencil'></i></button>". 
                                " <button type= 'button' class='btn btn-danger btn-sm' onclick='anularMovimiento(". $reg->id_tarifario_truck .")' ><i class='fa fa-close'></i></button>";
                $data[] = array(
                    "0" =>$acciones, 
                    "1" =>$reg->origen,
                    "2" => $reg->destino,
                    "3" => $reg->unidad,
                    "4" => $reg->piloto,
                    "5" => $reg->ayudantes,
                    "6" => $reg->validez,
                    "7" => $reg->tipocarga,
                    "8" => $reg->tarifa_venta,
                    "9" => $reg->tarifa_costo,
                    "10"=> $reg->moneda
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
        case 'listarTarifaFlete':
            $rspt = $tarifario->listarTarifaFlete($idtarifaflete);
            echo json_encode($rspt);
            break;
        case 'AnularMov':
            $rsp = $movbancario->anular($idmovimiento);
            echo json_encode($rsp);
        break;
}
