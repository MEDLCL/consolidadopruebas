<?php
include_once "../config/funciones.php";
include_once "../modelos/creaMaritimo.php";

$creaMaritimo = new creaMaritimo();

$idembarque = isset($_POST['idembarquemaritimo']) ? $idembarque = limpia($_POST['idembarquemaritimo']) : $idembarque = 0;
$idtipocarga = isset($_POST['tipocarga']) ? $idtipocarga = limpia($_POST['tipocarga']) : $idtipocarga = 0;
$idtiposervicio = isset($_POST['tipoServicio']) ? $idtiposervicio = limpia($_POST['tipoServicio']) : $idtiposervicio = 0;
$idcourier = isset($_POST['envioCourier']) ? $idcourier = limpia($_POST['envioCourier']) : $idcourier = 0;
$idbarco = isset($_POST['barco']) ? $idbarco = limpia($_POST['barco']) : $idbarco = 0;
$idagente = isset($_POST['agente']) ? $idagente = limpia($_POST['agente']) : $idagente = '';
$idnavage = isset($_POST['naviera']) ? $idnavage = limpia($_POST['naviera']) : $idnavage = '';
$viaje = isset($_POST['Viaje']) ? $viaje = limpia($_POST['Viaje']) : $viaje = '';
$idpaisorigen = isset($_POST['PaisOrigen']) ? $idpaisorigen = limpia($_POST['PaisOrigen']) : $idpaisorigen = 0;
$idorigen = isset($_POST['Origen']) ? $idorigen = limpia($_POST['Origen']) : $idorigen = 0;
$idpaisdestino = isset($_POST['PaisDestino']) ? $idpaisdestino = $_POST['PaisDestino'] : $idpaisdestino = 0;
$iddestino = isset($_POST['Destino']) ? $iddestino = $_POST['Destino'] : $iddestino = 0;
$idusuarioA = isset($_POST["usuarioAsignado"]) ? $idusuarioA = $_POST["usuarioAsignado"] : $idusuarioA = 0;
$cantClie = isset($_POST["cntClientes"]) ? $cantClie = $_POST["cntClientes"] : $cantClie = 0;
$observaciones =isset($_POST["obervaciones"]) ? $observaciones = $_POST["obervaciones"] : $observaciones = '';
$contenedoresM = isset($_POST['contenedores']) ? $contenedoresM = $_POST['contenedores'] : $contenedoresM = array();
$tiposDoc = isset($_POST['tipocM']) ? $tiposDoc = $_POST['tipocM'] : $tiposDoc = array();
$ventasM  = isset($_POST['idventasM']) ? $ventasM = $_POST['idventasM'] : $ventasM = array();
$clientesM = isset($_POST['clientesM']) ? $clientesM = $_POST['clientesM'] : $clientesM = array();
$orinales= isset($_POST['originalM']) ? $orinales = $_POST['originalM'] : $orinales = array();
$copias = isset($_POST['copiasM']) ? $copias = $_POST['copiasM'] : $copias = array();
$obserM = isset($_POST['obserM']) ? $obserM = $_POST['obserM'] : $obserM = array();
$numeroM = isset($_POST['nodocM']) ? $numeroM =  $_POST['nodocM'] : $numeroM = array();
$fechai = isset($_POST['fechaingreso']) ? $fechai =  $_POST['fechaingreso'] : $fechai = date('Y-m-d');

switch ($_GET['op']) {
    case 'guardaryeditar':
        //$,$, $
        if ($idembarque == 0) {
            $res = $creaMaritimo->grabar($cantClie,$idtipocarga,$idtiposervicio,$idcourier,$idbarco,$idagente,$idnavage,$viaje,$idpaisorigen,$idorigen,$idpaisdestino,$iddestino,$idusuarioA,$observaciones,$fechai,$contenedoresM,$tiposDoc,$ventasM,$clientesM,$orinales,$copias,$obserM,$numeroM);
            
            echo json_encode($res);
        } else {
            // editar crea embarque
            $res = $creaMaritimo->editarE($idembarque, $idtipocarga, $idbarco, $viaje, $idnavage, $idusuarioA);
            echo json_encode($res);
        }
        break;
    case 'buscaEmbarque':
        $res = $creaMaritimo->buscaEmbarque($idembarque);
        echo json_encode($res);
        break;

    case 'listarEmbarque':
        $res = $creaMaritimo->listarEmbarque();
        $data = array();
        foreach ($res as $reg) {
            $data[] = array(
                "0" => '<button class="btn btn-warning" onclick="mostrarEmbarque(' . $reg->id_embarque_maritimo . ')"><i class="fa fa-pencil" ></i></button>',
                "1" => $reg->fechaingreso,
                "2" => $reg->codigo,
                "3" => $reg->consecutivo,
                "4" => $reg->tipocarga,
                "5" => $reg->tiposervicio,
                "6" => $reg->courier,
                "7" => $reg->barco,
                "8" => $reg->viaje,
                "9" =>$reg->cant_clientes,
                "10" => $reg->agente,
                "11" => $reg->Naviera,
                "12" => $reg->origen,
                "13" => $reg->destino,
                "14" => $reg->usuarioA,
                "15" => $reg->observaciones
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
    
        case 'cargac':
        $tablac = "";
        $res = $empresa->listarcontacto($idempresa);
        foreach ($res as $contactos) {
            $tablac = $tablac
                . '<tr class="filas" id ="fila' . $contactos->id_contacto . '">'
                . '<td><button type="button" class="btn btn-danger" onclick="eliminarfila(' . $contactos->id_contacto . ')"><span class="fa fa-trash-o"></span></button></td>'
                . '<td ><input type "text"    name ="nombresc[]" id ="nombresc[]" value="' . $contactos->nombre . '"></td>'
                . '<td ><input type "text"    name ="apellidosc[]" id ="apellidosc[]" value="' . $contactos->apellido . '"></td>'
                . '<td ><input type "text"    name ="correosc[]" id ="correosc[]" value="' . $contactos->correo . '"></td>'
                . '<td ><input type "text"    name ="telefonosc[]" id ="telefonosc[]" value="' . $contactos->telefono . '"></td>'
                . '<td ><input type "text"    name ="puestosc[]" id ="puestosc[]" value="' . $contactos->puesto . '"></td>'
                . '</tr>';
        }
        echo $tablac;
        break;
    
    default:
        # code...
        break;
}
