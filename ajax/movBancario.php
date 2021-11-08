<?php
require_once "../config/Conexion.php";
require_once "../config/funciones.php";
require_once "../modelos/movBancario.php";

$movbancario = new movBancario();
$idmovimiento  = isset($_POST["idmovbancario"]) ? $idmovimiento = $_POST["idmovbancario"] : $idmovimiento = 0;
$idbanco = isset($_POST["movBanco"]) ? $idbanco = $_POST["movBanco"] : $idbanco = 0;
$idcuenta = isset($_POST["movcuentaBancaria"]) ? $idcuenta = $_POST["movcuentaBancaria"] : $idcuenta = 0;
$tipo = isset($_POST['tipoOperacion']) ? $tipo = limpia($_POST['tipoOperacion']) : $tipo = 0;
$monto = isset($_POST["movMonto"]) ? $monto = $_POST["movMonto"] : $monto = 0;
$comision = isset($_POST["movChequeCaja"]) ? $comision = $_POST["movChequeCaja"] : $comision = 0;
$fechaoperacion = isset($_POST['movFechaOperacion']) ? $fechaoperacion = limpia($_POST['movFechaOperacion']) : $fechaoperacion = date('Y-m-d');
$nooperacion = isset($_POST["movNoOperacion"]) ? $nooperacion = $_POST["movNoOperacion"] : $nooperacion = 0;
$beneficiario = isset($_POST["movAnombreDe"]) ? $beneficiario = $_POST["movAnombreDe"] : $beneficiario = "";
$obser = isset($_POST["movObservaciones"]) ? $obser = $_POST["movObservaciones"] : $obser = "";


switch ($_GET["op"]) {
    case 'guardaryeditar':
        if ($idmovimiento == 0 || $idmovimiento == "") {
            $resp = $movbancario->grabar($idbanco,$idcuenta,$tipo,$monto,$comision,$fechaoperacion,$nooperacion,$beneficiario,$obser);
            echo json_encode($resp);
        } else {
            $resp = $movbancario->editar($idbanco, $nombre, $ejecutivo, $telefono, $ext, $correo, $obser);
            echo json_encode($resp);
        }
        break;
    case 'listarMov':
        $rspt = $movbancario->listarMovimientos();
        $acciones= "";
            mb_internal_encoding('UTF-8');
            //se declara un array para almacenar todo el query
            $data = array();
            foreach ($rspt as $reg) {
                if ($reg->estado==1){
                    $acciones = "<button type= 'button' class='btn btn-warning' onclick='mostrarMovimientobancario(". $reg->id_movimiento .")' ><i class='fa fa-pencil'></i></button>". 
                                " <button type= 'button' class='btn btn-danger' onclick='anularMovimiento(". $reg->id_movimiento .")' ><i class='fa fa-close'></i></button>";
                    $estado ='<span class="label bg-green">Activado</span>';
                }else{
                    $acciones = '';
                    $estado = '<span class="label bg-red">Anulado</span>';
                }
                $data[] = array(
                    "0" =>$acciones, 
                    "1" =>$estado,
                    "2" => $reg->Banco,
                    "3" => $reg->Cuenta,
                    "4" => $reg->operacion,
                    "5" => $reg->monto,
                    "6" => $reg->comision,
                    "7" => $reg->fecha_operacion,
                    "8" => $reg->no_operacion,
                    "9" => $reg->beneficiario,
                    "10"=> $reg->observaciones
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
        case 'mostrarMov':
            $rspt = $movbancario->mostarCuenta($idmovimiento);
            echo json_encode($rspt);
            break;
        case 'AnularMov':
            $rsp = $movbancario->anular($idmovimiento);
            echo json_encode($rsp);
        break;
}
