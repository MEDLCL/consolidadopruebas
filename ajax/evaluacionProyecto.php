<?php
require_once "../config/Conexion.php";
require_once "../config/funciones.php";
require_once "../modelos/evaluacionProyecto.php";

$evaluacion = new evaluacionProyecto();

$idproyecto  = isset($_POST["idproyecto"]) ? $idproyecto = $_POST["idproyecto"] : $idproyecto = 0;
$codigoProyecto  = isset($_POST["codigoProyecto"]) ? $codigoProyecto = $_POST["codigoProyecto"] : $codigoProyecto = 0;
$idcliente  = isset($_POST["clienteEva"]) ? $idcliente = $_POST["clienteEva"] : $idcliente = 0;
$fechaInicio  = isset($_POST["fechainicio"]) ? $fechaInicio = $_POST["fechainicio"] : $fechaInicio = date('Y-m-d');
$fechaFinal  = isset($_POST["fechafinal"]) ? $fechaFinal = $_POST["fechafinal"] : $fechaFinal = date('Y-m-d');
$tipocargaProyecto  = isset($_POST["tipocargaProyecto"]) ? $tipocargaProyecto = $_POST["tipocargaProyecto"] : $tipocargaProyecto = 0;
$fianzaProyecto  = isset($_POST["fianzaPro"]) ? $fianzaProyecto = $_POST["fianzaPro"] : $fianzaProyecto = 0;
$pesopromedio  = isset($_POST["pesoPromedioPro"]) ? $pesopromedio = $_POST["pesoPromedioPro"] : $pesopromedio = 0;
$unidadMedida  = isset($_POST["unidadPesoPro"]) ? $unidadMedida = $_POST["unidadPesoPro"] : $unidadMedida = 0;
$piesCubico  = isset($_POST["piesCubicosPro"]) ? $piesCubico = $_POST["piesCubicosPro"] : $piesCubico = 0;
$mercaderia  = isset($_POST["mercaderiaPro"]) ? $mercaderia = $_POST["mercaderiaPro"] : $mercaderia = "";
$permisos  = isset($_POST["permisosEspecialesPro"]) ? $permisos = $_POST["permisosEspecialesPro"] : $permisos = "";
$entregasPromedio  = isset($_POST["entregasPromedioPro"]) ? $entregasPromedio = $_POST["entregasPromedioPro"] : $entregasPromedio = "";
$kilometrosPromedio  = isset($_POST["kilometrosPromedioPro"]) ? $kilometrosPromedio = $_POST["kilometrosPromedioPro"] : $kilometrosPromedio = "";
$frecuenciaViajes  = isset($_POST["frecuenciaViajes"]) ? $frecuenciaViajes = $_POST["frecuenciaViajes"] : $frecuenciaViajes = "";            

        
$seCargaPro  = isset($_POST["seCargaPro"]) ? $seCargaPro = $_POST["seCargaPro"] : $seCargaPro = 0;
$seDescargaPro  = isset($_POST["seDescargaPro"]) ? $seDescargaPro = $_POST["seDescargaPro"] : $seDescargaPro = 0;
$manejoEfectivoPro  = isset($_POST["manejoEfectivoPro"]) ? $manejoEfectivoPro = $_POST["manejoEfectivoPro"] : $manejoEfectivoPro = 0;

//para tipo de unidades 
$idtipounidadtransporte = isset($_POST["idtipounidadtransporte"]) ? $idtipounidadtransporte = $_POST["idtipounidadtransporte"] : $idtipounidadtransporte = 0;
$cantUnidad = isset($_POST["numeroUnidadesPro"]) ? $cantUnidad = $_POST["numeroUnidadesPro"] : $cantUnidad = 0;
$tipoUnida = isset($_POST['tipoUnidaPro']) ? $tipoUnida = limpia($_POST['tipoUnidaPro']) : $tipoUnida = 0;
$tipoEquipo = isset($_POST["tipoEquipoPro"]) ? $tipoEquipo = $_POST["tipoEquipoPro"] : $tipoEquipo = 0;
$temperatura = isset($_POST["temperaturaPro"]) ? $temperatura = $_POST["temperaturaPro"] : $temperatura = "";
$caracEquipo = isset($_POST['caracEquipoPro']) ? $caracEquipo = limpia($_POST['caracEquipoPro']) : $caracEquipo = "";
$seguridad = isset($_POST["cajillaSeguridadPro"]) ? $seguridad = $_POST["cajillaSeguridadPro"] : $seguridad = 0;
$marchamo = isset($_POST["marchamoPro"]) ? $marchamo = $_POST["marchamoPro"] : $marchamo = 0;
$gps = isset($_POST["gpsPro"]) ? $gps = $_POST["gpsPro"] : $gps = 0;
$lugarCargaPro = isset($_POST["lugarCargaPro"]) ? $lugarCargaPro = $_POST["lugarCargaPro"] : $lugarCargaPro = "";
$lugarDescargaPro = isset($_POST["lugarDescargaPro"]) ? $lugarDescargaPro = $_POST["lugarDescargaPro"] : $lugarDescargaPro = "";
$canalDistribucionPro = isset($_POST["canalDistribucionPro"]) ? $canalDistribucionPro = $_POST["canalDistribucionPro"] : $canalDistribucionPro = "";

// unidades para nueva evaluacion 
$cantUnidadM = isset($_POST["numeroUnidadesProM"]) ? $cantUnidadM = $_POST["numeroUnidadesProM"] : $cantUnidadM = array();
$tipoUnidaM = isset($_POST['tipoUnidaProM']) ? $tipoUnidaM = $_POST['tipoUnidaProM'] : $tipoUnidaM = array();
$tipoEquipoM = isset($_POST["tipoEquipoProM"]) ? $tipoEquipoM = $_POST["tipoEquipoProM"] : $tipoEquipoM = array();
$temperaturaM = isset($_POST["temperaturaProM"]) ? $temperaturaM = $_POST["temperaturaProM"] : $temperaturaM = array();
$caracEquipoM = isset($_POST['caracEquipoProM']) ? $caracEquipoM = $_POST['caracEquipoProM'] : $caracEquipoM = array();
$seguridadM = isset($_POST["cajillaSeguridadProM"]) ? $seguridadM = $_POST["cajillaSeguridadProM"] : $seguridadM = array();
$marchamoM = isset($_POST["marchamoProM"]) ? $marchamoM = $_POST["marchamoProM"] : $marchamoM = array();
$gpsM = isset($_POST["gpsProM"]) ? $gpsM = $_POST["gpsProM"] : $gpsM = array();
$lugarCargaProM = isset($_POST["lugarCargaProM"]) ? $lugarCargaProM = $_POST["lugarCargaProM"] : $lugarCargaProM = array();
$lugarDescargaProM = isset($_POST["lugarDescargaProM"]) ? $lugarDescargaProM = $_POST["lugarDescargaProM"] : $lugarDescargaProM = array();
$canalDistribucionProM = isset($_POST["canalDistribucionProM"]) ? $canalDistribucionProM = $_POST["canalDistribucionProM"] : $canalDistribucionProM = array();


//
$idtarifatarget = isset($_POST["idtarifatarget"]) ? $idtarifatarget = $_POST["idtarifatarget"] : $idtarifatarget = 0;
$tipounidadTarget = isset($_POST["tipounidadTarget"]) ? $tipounidadTarget = $_POST["tipounidadTarget"] : $tipounidadTarget = 0;
$fianzaTarget = isset($_POST["fianzaTarget"]) ? $lugarDesfianzaTargetcargaPro = $_POST["fianzaTarget"] : $fianzaTarget = 0;
$lugarCargaTarget = isset($_POST["lugarCargaTarget"]) ? $lugarCargaTarget = $_POST["lugarCargaTarget"] : $lugarCargaTarget = "";
$lugardescargaTarget = isset($_POST["lugardescargaTarget"]) ? $lugardescargaTarget = $_POST["lugardescargaTarget"] : $lugardescargaTarget = "";

$idserviciotarget = isset($_POST["idserviciotarget"]) ? $idserviciotarget = $_POST["idserviciotarget"] : $idserviciotarget = 0;
$servicioTarget = isset($_POST["servicioTarget"]) ? $servicioTarget = $_POST["servicioTarget"] : $servicioTarget = 0;
$lugarCargaTargetServicios = isset($_POST["lugarCargaTargetServicios"]) ? $lugarCargaTargetServicios = $_POST["lugarCargaTargetServicios"] : $lugarCargaTargetServicios = "";
$lugarDescargaTargetServicios = isset($_POST["lugarDescargaTargetServicios"]) ? $lugarDescargaTargetServicios = $_POST["lugarDescargaTargetServicios"] : $lugarDescargaTargetServicios = "";

$descripcionPro  = isset($_POST["descripcionProyecto"]) ? $descripcionPro = limpia($_POST["descripcionProyecto"]): $descripcionPro = "";
$diaslibres= isset($_POST["diasLibresProyecto"]) ? $diaslibres = $_POST["diasLibresProyecto"] : $diaslibres = 0;
$comentarioOP= isset($_POST["comentarioOperacionPro"]) ? $comentarioOP = limpia($_POST["comentarioOperacionPro"]) : $comentarioOP = "";

$tarifaVentaFlete = isset($_POST["tarifaVentaFleteProyecto"]) ? $tarifaVentaFlete = $_POST["tarifaVentaFleteProyecto"] : $tarifaVentaFlete = 0;
$tarifaCostoFlete= isset($_POST["tarifaCostoFleteProyecto"]) ? $tarifaCostoFlete = $_POST["tarifaCostoFleteProyecto"] : $tarifaCostoFlete = 0;
$monedaFleteTarget = isset($_POST["monedaTargetProyecto"]) ? $monedaFleteTarget = $_POST["monedaTargetProyecto"] : $monedaFleteTarget = 0;

$tipounidadTargetM = isset($_POST['tipounidadTargetM']) ? $tipounidadTargetM = $_POST['tipounidadTargetM'] : $tipounidadTargetM = array();
$fianzaTargetM = isset($_POST['fianzaTargetM']) ? $fianzaTargetM = $_POST['fianzaTargetM'] : $fianzaTargetM = array();

$lugarCargaTargetM = isset($_POST['lugarCargaTargetM']) ? $lugarCargaTargetM = $_POST['lugarCargaTargetM'] : $lugarCargaTargetM = array();
$lugardescargaTargetM = isset($_POST['lugardescargaTargetM']) ? $lugardescargaTargetM = $_POST['lugardescargaTargetM'] : $lugardescargaTargetM = array();

$tarifaVentaFleteProyectoM = isset($_POST['tarifaVentaFleteProyectoM']) ? $tarifaVentaFleteProyectoM = $_POST['tarifaVentaFleteProyectoM'] : $tarifaVentaFleteProyectoM = array();
$tarifaCostoFleteProyectoM = isset($_POST['tarifaCostoFleteProyectoM']) ? $tarifaCostoFleteProyectoM = $_POST['tarifaCostoFleteProyectoM'] : $tarifaCostoFleteProyectoM = array();
$monedaTargetProyectoM= isset($_POST['monedaTargetProyectoM']) ? $monedaTargetProyectoM = $_POST['monedaTargetProyectoM'] : $monedaTargetProyectoM = array();

$tarifaVentaServicioT= isset($_POST['tarifaVentaServicioT']) ? $tarifaVentaServicioT = $_POST['tarifaVentaServicioT'] : $tarifaVentaServicioT = 0;
$tarifaCostoServicioT= isset($_POST['tarifaCostoServicioT']) ? $tarifaCostoServicioT = $_POST['tarifaCostoServicioT'] : $tarifaCostoServicioT = 0;
$idmonedaServicioT = isset($_POST['idmonedaServicioT']) ? $idmonedaServicioT = $_POST['idmonedaServicioT'] : $idmonedaServicioT = 0;

//servicios target
$idserviciotargetM = isset($_POST['idserviciotargetM']) ? $idserviciotargetM = $_POST['idserviciotargetM'] : $idserviciotargetM = array();
$tarifaVentaServicioTM= isset($_POST['tarifaVentaServicioTM']) ? $tarifaVentaServicioTM = $_POST['tarifaVentaServicioTM'] : $tarifaVentaServicioTM = array();
$tarifaCostoServicioTM= isset($_POST['tarifaCostoServicioTM']) ? $tarifaCostoServicioTM = $_POST['tarifaCostoServicioTM'] : $tarifaCostoServicioTM = array();
$idmonedaServicioTM= isset($_POST['idmonedaServicioTM']) ? $idmonedaServicioTM = $_POST['idmonedaServicioTM'] : $idmonedaServicioTM = array();
$lugarCargaTargetServiciosM= isset($_POST['lugarCargaTargetServiciosM']) ? $lugarCargaTargetServiciosM = $_POST['lugarCargaTargetServiciosM'] : $lugarCargaTargetServiciosM = array();
$lugarDescargaTargetServiciosM= isset($_POST['lugarDescargaTargetServiciosM']) ? $lugarDescargaTargetServiciosM = $_POST['lugarDescargaTargetServiciosM'] : $lugarDescargaTargetServiciosM = array();


$botasVenta = isset($_POST["botasVenta"]) ? $botasVenta = $_POST["botasVenta"] : $botasVenta = 0;
$chalecoVenta = isset($_POST["chalecoVenta"]) ? $chalecoVenta = $_POST["chalecoVenta"] : $chalecoVenta = 0;
$lentesVenta = isset($_POST["lentesVenta"]) ? $lentesVenta = $_POST["lentesVenta"] : $lentesVenta = 0;
$guantesVenta = isset($_POST["guantesVenta"]) ? $guantesVenta = $_POST["guantesVenta"] : $guantesVenta = 0;
$mascarillaVenta = isset($_POST["mascarillaVenta"]) ? $mascarillaVenta = $_POST["mascarillaVenta"] : $mascarillaVenta = 0;
$caretaVenta = isset($_POST["caretaVenta"]) ? $caretaVenta = $_POST["caretaVenta"] : $caretaVenta = 0;
$otrosVenta = isset($_POST["otrosVenta"]) ? $otrosVenta = limpia($_POST["otrosVenta"]) : $otrosVenta = "";

$archivos = isset($_FILES['archivosEvaProyecto']) ? $archivos =  $_FILES['archivosEvaProyecto'] : $archivos = array();

switch ($_GET["op"]) {
    case 'guardaryeditarProyecto':
        if ($idproyecto == 0 || $idproyecto == "") {
            $resp = $evaluacion->grabar($descripcionPro,$idcliente,$fechaInicio,$fechaFinal,$tipocargaProyecto,$fianzaProyecto,$pesopromedio,$unidadMedida,$piesCubico,$mercaderia,$permisos,$entregasPromedio,$kilometrosPromedio,$frecuenciaViajes,$seCargaPro,$seDescargaPro,$manejoEfectivoPro,$cantUnidadM, $tipoUnidaM, $tipoEquipoM, $temperaturaM, $caracEquipoM, $seguridadM, $marchamoM, $gpsM, $lugarCargaProM, $lugarDescargaProM, $canalDistribucionProM,$diaslibres,$comentarioOP,$tipounidadTargetM,$fianzaTargetM,$lugarCargaTargetM,$lugardescargaTargetM,$tarifaVentaFleteProyectoM,$tarifaCostoFleteProyectoM,$monedaTargetProyectoM,$idserviciotargetM,$tarifaVentaServicioTM,$tarifaCostoServicioTM,$idmonedaServicioTM,$lugarCargaTargetServiciosM,$lugarDescargaTargetServiciosM, $botasVenta, $chalecoVenta, $lentesVenta, $guantesVenta, $mascarillaVenta, $caretaVenta, $otrosVenta,$archivos);
            echo json_encode($resp);
        } else {
            $resp = $evaluacion->editar($descripcionPro,$idproyecto,$codigoProyecto,$idcliente,$fechaInicio,$fechaFinal,$tipocargaProyecto,$fianzaProyecto,$pesopromedio,$unidadMedida,$piesCubico,$mercaderia,$permisos,$entregasPromedio,$kilometrosPromedio,$frecuenciaViajes,$seCargaPro,$seDescargaPro,$manejoEfectivoPro,$diaslibres,$comentarioOP,$botasVenta, $chalecoVenta, $lentesVenta, $guantesVenta, $mascarillaVenta, $caretaVenta, $otrosVenta,$archivos);
            echo json_encode($resp);
        }
        break;
    case 'listarProyectos':
        $rspt = $evaluacion->listarProyectos();
        $acciones = "";
        mb_internal_encoding('UTF-8');
        //colocar if 
        $data = array();
        foreach ($rspt as $reg) {
            
            $acciones = "<button type= 'button' class='btn btn-warning btn-sm' onclick='listarProyecto(" . $reg->idproyecto . ")' ><i class='fa fa-pencil'></i></button>" .
                " <button type= 'button' class='btn btn-danger btn-sm' onclick='eliminarUnidad(" . $reg->idproyecto . ")' ><i class='fa fa-close'></i></button>";
            $data[] = array(
                "0" => $acciones,
                "1" => $reg->codigo,
                "2" => $reg->cliente,
                "3" => $reg->fechainicio,
                "4" => $reg->fechafinal,
                "5" => $reg->tipocarga,
                "6" => $reg->Fianza,
                "7" => $reg->peso.$reg->Unidad,
                "8" => $reg->pies_cubicos,
                "9" => $reg->descripcion_mercaderia,
                "10" => $reg->permisos,
                "11" => $reg->entregas,
                "12" => $reg->recorrido,
                "13" => $reg->frecuencua,
                "14" => $reg->secarga,
                "15" => $reg->sedescarga,
                "16" => $reg->efectivo,
                "17" =>  $reg->descripcionProyecto,
                "18" =>  $reg->dias_libres,
                "19" =>  $reg->comentario_operacion
            );
        }
        $results = array(
            "sEcho" => 1, //informacion para el datatable
            "iTotalRecords" => count($data), //enviamos el total al datatable
            "iTotalDisplayRecords" => count($data), //enviamos total de rgistror a utlizar
            "aaData" => $data
        );
        echo json_encode($results);
        # code...
        break;
        case 'listarProyecto':
            $resp = $evaluacion->listarProyecto($idproyecto);
        echo json_encode($resp);
            break;
    case 'guardaUnidades':
        if ($idtipounidadtransporte == 0 || $idtipounidadtransporte == "") {
            $resp = $evaluacion->grabarUnidades($idproyecto, $cantUnidad, $tipoUnida, $tipoEquipo, $temperatura, $caracEquipo, $seguridad, $marchamo, $gps, $lugarCargaPro, $lugarDescargaPro, $canalDistribucionPro);
            echo json_encode($resp);
        }else {
            $resp = $evaluacion->editarUnidad($idtipounidadtransporte, $cantUnidad, $tipoUnida, $tipoEquipo, $temperatura, $caracEquipo, $seguridad, $marchamo, $gps, $lugarCargaPro, $lugarDescargaPro, $canalDistribucionPro);
            echo json_encode($resp);
        }
        break;
    case 'listarUnidad':
        $resp = $evaluacion->listaUnidad($idtipounidadtransporte);
        echo json_encode($resp);
        break;

    case 'listarUnidades':
        $rspt = $evaluacion->listarUnidades($idproyecto);
        $acciones = "";
        mb_internal_encoding('UTF-8');
        //colocar if 
        $data = array();
        foreach ($rspt as $reg) {
            
            $acciones = "<button type= 'button' class='btn btn-warning btn-sm' onclick='listarUnidad(" . $reg->id_asigna_unidad . ")' ><i class='fa fa-pencil'></i></button>" .
                " <button type= 'button' class='btn btn-danger btn-sm' onclick='eliminarUnidad(" . $reg->id_asigna_unidad . ")' ><i class='fa fa-close'></i></button>";
            $data[] = array(
                "0" => $acciones,
                "1" => $reg->cantidad_unidad,
                "2" => $reg->unidad,
                "3" => $reg->Equipo,
                "4" => $reg->temperatura,
                "5" => $reg->especificacion,
                "6" => $reg->seguridad,
                "7" => $reg->marchamo,
                "8" => $reg->gps,
                "9" => $reg->lugar_carga,
                "10" => $reg->lugar_descarga,
                "11" => $reg->canal_distrbucion
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

    case 'guardaTarifasT':
        if ($idtarifatarget==0 || $idtarifatarget ==""){
            $rspt = $evaluacion->grabarTarifaTarget($idproyecto,$tipounidadTarget,$fianzaTarget,$lugarCargaTarget,$lugardescargaTarget,$tarifaVentaFlete,$tarifaCostoFlete,$monedaFleteTarget);
        }else{
            $rspt = $evaluacion->editarTarifaTarget($idtarifatarget,$tipounidadTarget,$fianzaTarget,$lugarCargaTarget,$lugardescargaTarget,$tarifaVentaFlete,$tarifaCostoFlete,$monedaFleteTarget);
        }
            echo json_encode($rspt);
        break;

    case 'listarTarifa':
        $rsp = $evaluacion->listarTarifaTarget($idtarifatarget);
        echo json_encode($rsp);
        break;
    case 'eliminaTarifaTF':
        # code...
        break;
    case 'listarTarifasT':
        $rspt = $evaluacion->listarTarifasTarget($idproyecto);
        $acciones = "";
        mb_internal_encoding('UTF-8');
        //colocar if 
        $data = array();
        foreach ($rspt as $reg) {
            
            $acciones = "<button type= 'button' class='btn btn-warning btn-sm' onclick='listaTarifa(" . $reg->idtarifa_target . ")' ><i class='fa fa-pencil'></i></button>" .
                " <button type= 'button' class='btn btn-danger btn-sm' onclick='eliminarUnidad(" . $reg->idtarifa_target . ")' ><i class='fa fa-close'></i></button>";
            $data[] = array(
                "0" => $acciones,
                "1" => $reg->unidad,
                "2" => $reg->fianza,
                "3" => $reg->venta,
                "4" => $reg->costo,
                "5" => $reg->signo,
                "6" => $reg->lugar_carga,
                "7" => $reg->lugar_descarga
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

        case 'grabaServicioTarget':
            if ($idserviciotarget==0 || $idserviciotarget ==""){
                $rspt = $evaluacion->grabaServicoTarget($idproyecto,$servicioTarget,$lugarCargaTargetServicios,$lugarDescargaTargetServicios,$tarifaVentaServicioT,$tarifaCostoServicioT,$idmonedaServicioT);
            }else{
                $rspt = $evaluacion->editaServicioTarget($idserviciotarget,$servicioTarget,$lugarCargaTargetServicios,$lugarDescargaTargetServicios,$tarifaVentaServicioT,$tarifaCostoServicioT,$idmonedaServicioT);
            }
                echo json_encode($rspt);
            break;
        case 'listarServicoTarget':
                $rsp = $evaluacion->listarServicioTarget($idserviciotarget);
                echo  json_encode($rsp);
            break;
        case 'listarServiosTarget':
            $rspt = $evaluacion->listarServiciosTarget($idproyecto);
            $acciones = "";
            mb_internal_encoding('UTF-8');
            //colocar if 
            $data = array();
            foreach ($rspt as $reg) {
                
                $acciones = "<button type= 'button' class='btn btn-warning btn-sm' onclick='listarServicio(" . $reg->id_servicio_target . ")' ><i class='fa fa-pencil'></i></button>" .
                    " <button type= 'button' class='btn btn-danger btn-sm' onclick='eliminarUnidad(" . $reg->id_servicio_target . ")' ><i class='fa fa-close'></i></button>";
                $data[] = array(
                    "0" => $acciones,
                    "1" => $reg->servicio,
                    "2" => $reg->venta,
                    "3" => $reg->costo,
                    "4" => $reg->signo,
                    "5" => $reg->lugar_carga,
                    "6" => $reg->lugar_descarga,
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
        case "listarArchivos":
            $tablaA = "";
            $res = $evaluacion->listarArchivos($idproyecto);
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
                    . '<tr id = "filaA'.$reg->id_archivo .'">'
                    . '<td >'. $contador.'</td>'
                    . '<td >'.$reg->nombre_archivo.'</td>'
                    . '<td ><img src ="'. $src. '" width = "50px" height = "50px"></td>'
                    . '<td ><button type = "button" class="btn btn-warning" onclick="eliminarA(' . $reg->id_archivo . ')"><i class="fa fa-close" ></i></button></td>'
                    . '<td ><button type = "button" class="btn btn-success"><a href="../ajax/download.php?nombre_archivo='.$reg->nombre_archivo.'&ubicacion='.$reg->ubicacion.'"   style="color:#FFF;"><i class="fa fa-download" ></i> </a></button></td>'
                    . '</tr>';
            }
            echo $tablaA;
            break;
        
}
