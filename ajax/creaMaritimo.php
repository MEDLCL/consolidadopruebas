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
$observaciones = isset($_POST["obervaciones"]) ? $observaciones = $_POST["obervaciones"] : $observaciones = '';
$contenedoresM = isset($_POST['contenedores']) ? $contenedoresM = $_POST['contenedores'] : $contenedoresM = array();
$tiposDoc = isset($_POST['tipocM']) ? $tiposDoc = $_POST['tipocM'] : $tiposDoc = array();
$ventasM  = isset($_POST['idventasM']) ? $ventasM = $_POST['idventasM'] : $ventasM = array();
$clientesM = isset($_POST['clientesM']) ? $clientesM = $_POST['clientesM'] : $clientesM = array();
$orinales = isset($_POST['originalM']) ? $orinales = $_POST['originalM'] : $orinales = array();
$copias = isset($_POST['copiasM']) ? $copias = $_POST['copiasM'] : $copias = array();
$obserM = isset($_POST['obserM']) ? $obserM = $_POST['obserM'] : $obserM = array();
$numeroM = isset($_POST['nodocM']) ? $numeroM =  $_POST['nodocM'] : $numeroM = array();
$fechai = isset($_POST['fechaingreso']) ? $fechai =  $_POST['fechaingreso'] : $fechai = date('Y-m-d');
$archivos = isset($_FILES['CMarchivos']) ? $archivos =  $_FILES['CMarchivos'] : $archivos = array();
$iddocumento=isset($_POST['iddocumento']) ? $iddocumento =  $_POST['iddocumento'] : $iddocumento = 0;
$codigoembarque=isset($_POST['codigoMaritimo']) ? $codigoembarque =  $_POST['codigoMaritimo'] : $codigoembarque = '';

switch ($_GET['op']) {
    case 'guardaryeditar':
        //$,$, $
        if ($idembarque == 0) {
            $res = $creaMaritimo->grabar($cantClie, $idtipocarga, $idtiposervicio, $idcourier, $idbarco, $idagente, $idnavage, $viaje, $idpaisorigen, $idorigen, $idpaisdestino, $iddestino, $idusuarioA, $observaciones, $fechai, $contenedoresM, $tiposDoc, $ventasM, $clientesM, $orinales, $copias, $obserM, $numeroM, $archivos);

            echo json_encode($res);
        } else {
            // editar crea embarque
            $res = $creaMaritimo->editarE($idembarque, $idtipocarga, $idbarco, $viaje, $idnavage, $idusuarioA,$idtiposervicio,$fechai,$codigoembarque,$archivos);
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
                "0" => '<button class="btn btn-warning" onclick="mostrarEmbarque(' . $reg->id_embarque_maritimo . ')"><i class="fa fa-pencil" ></i></button>' 
                .' <button class="btn btn-danger" onclick="anularEmbarque(' . $reg->id_embarque_maritimo . ')"><i class="fa fa-trash" ></i></button>',               
                "1" => $reg->fechaingreso,
                "2" => $reg->codigo,
                "3" => $reg->consecutivo,
                "4" => $reg->tipocarga,
                "5" => $reg->tiposervicio,
                "6" => $reg->courier,
                "7" => $reg->barco,
                "8" => $reg->viaje,
                "9" => $reg->cant_clientes,
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

    case 'listarCNTR':

        $tablac = "";
        $res = $creaMaritimo->listarCNTR($idembarque);
        foreach ($res as $cntr) {
            $tablac = $tablac
                . '<tr>'
                . '<td ><input type "text"  readonly name ="listacntr[]" id ="listacntr[]" value="' . $cntr->numero . '"></td>'
                . '</tr>';
        }
        echo $tablac;
        break;

    case 'listarDoc':
        $tablaD = "";
        $res = $creaMaritimo->listarDocumentos($idembarque);
        foreach ($res as $reg) {
            $tablaD = $tablaD
                . '<tr id = "filad'.$reg->id_documentos .'">'

                . '<td ><button type = "button" class="btn btn-warning" onclick="eliminarDocumento(' . $reg->id_documentos . ')"><i class="fa fa-close" ></i></button></td>'

                . '<td ><input type "text" style="width: 50px;" readonly name ="tipocM[]" id ="tipocM[]" value="' . $reg->tipo_documento . '"></td>'
                . '<td ><input type "text" style="width: 50px;" readonly name ="ventasM[]" id ="ventasM[]" value="' . $reg->noventa . '"></td>'
                . '<td ><input type "text"  style="width: 50px;" readonly name ="idventasM[]" id ="idventasM[]" value="' . $reg->id_venta . '"></td>'
                . '<td ><input type "text"  readonly name ="clientesM[]" id ="clientesM[]" value="' . $reg->cliente . '"></td>'
                . '<td ><input type "text"  readonly name ="nodocM[]" id ="nodocM[]" value="' . $reg->numero . '"></td>'
                . '<td ><input type "text" style="width: 50px;" readonly name ="originalM[]" id ="originalM[]" value="' . $reg->original . '"></td>'
                . '<td ><input type "text" style="width: 50px;" readonly name ="copiasM[]" id ="copiasM[]" value="' . $reg->copia . '"></td>'
                . '<td ><input type "text"  readonly name ="obserM[]" id ="obserM[]" value="' . $reg->observaciones . '"></td>'
                . '</tr>';
        }
        echo $tablaD;
        break;
    case 'listarArchivosM':
        $tablaA = "";
        $res = $creaMaritimo->listarArchivosM($idembarque);
        $contador =0;
        $src = '';
        foreach ($res as $reg) {

            $contador = $contador +1;
            if (file_exists($reg->ubicacion.'/'.$reg->nombre_archivo)){
                $src = $reg->ubicacion.'/'.$reg->nombre_archivo;  
            }
            else{
                $src = '';
            }
            $tablaA = $tablaA
                . '<tr id = "filaA'.$reg->id_archivos .'">'
                . '<td >'. $contador.'</td>'
                . '<td >'.$reg->nombre_archivo.'</td>'
                . '<td ><img src ="'. $src. '" width = "50px" height = "50px"></td>'
                . '<td ><button type = "button" class="btn btn-warning" onclick="eliminarA(' . $reg->id_archivos . ')"><i class="fa fa-close" ></i></button></td>'
                . '<td ><button type = "button" class="btn btn-success"><a href="../ajax/download.php?nombre_archivo='.$reg->nombre_archivo.'&ubicacion='.$reg->ubicacion.'"   style="color:#FFF;"><i class="fa fa-download" ></i> </a></button></td>'
                . '</tr>';
        }
        echo $tablaA;
        break;
    case 'eliminarD':
        $res = $creaMaritimo->eliminaDcoumento ($iddocumento);
        echo $res;
        break;
    case 'AnulaEmbarque':
        $res = $creaMaritimo->anulaEmbarque($idembarque);
        echo json_encode($res);
        break;    
    default:
        # code...
        break;
}

/* 

 */