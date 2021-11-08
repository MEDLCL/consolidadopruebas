<?php
require_once "../config/Conexion.php";
require_once "../config/funciones.php";
require_once "../modelos/cuentaBanco.php";

$cuenta = new cuentaBanco();

$idbanco = isset($_POST["slcBanco"]) ? $idbanco = $_POST["slcBanco"] : $idbanco = 0;
$idcuenta = isset($_POST["idcuenta"]) ? $idcuenta = $_POST["idcuenta"] : $idcuenta = 0;
$nombre = isset($_POST["nombreCuentaNuevo"]) ? $nombre = $_POST["nombreCuentaNuevo"] : $nombre = "";
$numero = isset($_POST['numeroCuentaNuevo']) ? $numero= limpia($_POST['numeroCuentaNuevo']) : $numero = "";
$idmoneda = isset($_POST["monedaCuentaBanco"]) ? $idmoneda = $_POST["monedaCuentaBanco"] : $idmoneda = "";


switch ($_GET["op"]) {
    case 'guardaryeditar':
        if ($idcuenta == 0 || $idcuenta == "") {
            $resp = $cuenta->grabar($idbanco,$nombre,$numero,$idmoneda);
            echo json_encode ($resp);
        } else {
            $resp = $cuenta->editar($idcuenta,$nombre,$numero,$idmoneda);
            echo json_encode($resp);
        }
        break;
        case 'listarCuentas':
            $rspt = $cuenta->listarCuentas($idbanco);
            mb_internal_encoding('UTF-8');
            //se declara un array para almacenar todo el query
            $data = array();
            foreach ($rspt as $reg) {
                $data[] = array(
                    "0" => '<button type= "button" class="btn btn-warning" onclick="mostrarCuenta(' . $reg->idcuenta_bancaria . ')" ><i class="fa fa-pencil"></i></button>',
                    "1" => $reg->nombre,
                    "2" => $reg->numero_cuenta,
                    "3" => $reg->signo
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
        case 'mostarCuenta':
        $res = $cuenta->mostarCuenta($idcuenta);
            echo json_encode($res);
        break;    
}
