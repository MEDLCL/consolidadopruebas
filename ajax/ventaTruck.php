<?php
require_once "../config/Conexion.php";
require_once "../config/funciones.php";
require_once "../modelos/tarifaTruck.php";
require_once "../modelos/ventaTruck.php";

$tarifario = new tarifaTruck();
$venta = new ventaTruck();

$idproyecto = isset($_POST["proyectosTruck"]) ? $idproyecto = $_POST["proyectosTruck"] : $idproyecto = 0;
$idventa = isset($_POST["idVentaTruck"]) ? $idventa = $_POST["idVentaTruck"] : $idventa = 0;

$tipoVentaTRuck = isset($_POST["tipoVentaTRuck"]) ? $tipoVentaTRuck = $_POST["tipoVentaTRuck"] : $tipoVentaTRuck = 0;
$codigoVentaTruck = isset($_POST["codigoVentaTruck"]) ? $codigoVentaTruck = $_POST["codigoVentaTruck"] : $codigoVentaTruck = 0;
$clienteVentaTruck = isset($_POST["clienteVentaTruck"]) ? $clienteVentaTruck = $_POST["clienteVentaTruck"] : $clienteVentaTruck = 0;
$proyectosTruck = isset($_POST["proyectosTruck"]) ? $proyectosTruck = $_POST["proyectosTruck"] : $proyectosTruck = 0;
$observacionesVenta = isset($_POST["observacionesVenta"]) ? $observacionesVenta = limpia($_POST["observacionesVenta"]) : $observacionesVenta = "";

$embarcadorVenta = isset($_POST["embarcadorVenta"]) ? $embarcadorVenta = $_POST["embarcadorVenta"] : $embarcadorVenta = 0;
$notificaraVenta = isset($_POST["notificaraVenta"]) ? $notificaraVenta = $_POST["notificaraVenta"] : $notificaraVenta = 0;
$agenteVenta = isset($_POST["agenteVenta"]) ? $agenteVenta = $_POST["agenteVenta"] : $agenteVenta = 0;

$idcatalogos = isset($_POST["idcatalogos"]) ? $idcatalogos = $_POST["idcatalogos"] : $idcatalogos = array();
$origenesS = isset($_POST["origenesS"]) ? $origenesS = $_POST["origenesS"] : $origenesS = array();
$destinosS = isset($_POST["destinosS"]) ? $destinosS = $_POST["destinosS"] : $destinosS = array();
$grabaC = isset($_POST["grabaC"]) ? $grabaC = $_POST["grabaC"] : $grabaC = array();
$monedasS = isset($_POST["monedasS"]) ? $monedasS = $_POST["monedasS"] : $monedasS = array();
$tarifaVentaS = isset($_POST["tarifaVentaS"]) ? $tarifaVentaS = $_POST["tarifaVentaS"] : $tarifaVentaS = array();
$tarifaCostoS = isset($_POST["tarifaCostoS"]) ? $tarifaCostoS = $_POST["tarifaCostoS"] : $tarifaCostoS = array();
$cantidadS = isset($_POST["cantidadS"]) ? $cantidadS = $_POST["cantidadS"] : $cantidadS = array();
$profitS = isset($_POST["profitS"]) ? $profitS = $_POST["profitS"] : $profitS = array();
$codigoProyectoVenta = isset($_POST["codigoProyectoVenta"]) ? $codigoProyectoVenta = $_POST["codigoProyectoVenta"] : $codigoProyectoVenta = "";
$idservicioA = isset($_POST["idservicioadicional"]) ? $idservicioA = $_POST["idservicioadicional"] : $idservicioA = 0;

$origenesF= isset($_POST["origenesF"]) ? $origenesF = $_POST["origenesF"] : $origenesF = array();
$destinosF= isset($_POST["destinosF"]) ? $destinosF = $_POST["destinosF"] : $destinosF = array();
$monedasF= isset($_POST["monedasF"]) ? $monedasF = $_POST["monedasF"] : $monedasF = array();
$grabaF= isset($_POST["grabaF"]) ? $grabaF = $_POST["grabaF"] : $grabaF = array();
$tarifaVentaIF= isset($_POST["tarifaVentaIF"]) ? $tarifaVentaIF = $_POST["tarifaVentaIF"] : $tarifaVentaIF = array();
$tarifaCostoIF= isset($_POST["tarifaCostoIF"]) ? $tarifaCostoIF = $_POST["tarifaCostoIF"] : $tarifaCostoIF = array();
$unidadesF= isset($_POST["unidadesF"]) ? $unidadesF = $_POST["unidadesF"] : $unidadesF = array();
$totalVentaF= isset($_POST["totalVentaF"]) ? $totalVentaF = $_POST["totalVentaF"] : $totalVentaF = array();
$totalCostoF= isset($_POST["totalCostoF"]) ? $totalCostoF = $_POST["totalCostoF"] : $totalCostoF = array();
$profitF= isset($_POST["profitF"]) ? $profitF = $_POST["profitF"] : $profitF = array();
$horaP= isset($_POST["horaP"]) ? $horaP = $_POST["horaP"] : $horaP = array();

$diaslibres= isset($_POST["diaslibres"]) ? $diaslibres = $_POST["diaslibres"] : $diaslibres = array();
$fechap= isset($_POST["fechap"]) ? $profitF = $_POST["fechap"] : $fechap = array();
$tiposcarga= isset($_POST["tiposcarga"]) ? $tiposcarga = $_POST["tiposcarga"] : $tiposcarga = array();


$idProductos= isset($_POST["idProductos"]) ? $idProductos = $_POST["idProductos"] : $idProductos = array();
$codigosPVenta= isset($_POST["codigosPVenta"]) ? $codigosPVenta = $_POST["codigosPVenta"] : $codigosPVenta = array();
$descripcionPVenta= isset($_POST["descripcionPVenta"]) ? $descripcionPVenta = $_POST["descripcionPVenta"] : $descripcionPVenta = array();
$volumenPVenta= isset($_POST["volumenPVenta"]) ? $volumenPVenta = $_POST["volumenPVenta"] : $volumenPVenta = array();
$pesoPVenta= isset($_POST["pesoPVenta"]) ? $pesoPVenta = $_POST["pesoPVenta"] : $pesoPVenta = array();
$bultosPVenta= isset($_POST["bultosPVenta"]) ? $bultosPVenta = $_POST["bultosPVenta"] : $bultosPVenta = array();
$pesoBultoPVenta= isset($_POST["pesoBultoPVenta"]) ? $pesoBultoPVenta = $_POST["pesoBultoPVenta"] : $pesoBultoPVenta = array();


$idcatalogo= isset($_POST["servicioVentaTruck"]) ? $idcatalogo = $_POST["servicioVentaTruck"] : $idcatalogo = 0;
$servicioTarifaVenta= isset($_POST["servicioTarifaVenta"]) ? $servicioTarifaVenta = $_POST["servicioTarifaVenta"] : $servicioTarifaVenta = 0;
$servicioTarifaCosto= isset($_POST["servicioTarifaCosto"]) ? $servicioTarifaCosto = $_POST["servicioTarifaCosto"] : $servicioTarifaCosto = 0;
$servicioMonedaVenta= isset($_POST["servicioMonedaVenta"]) ? $servicioMonedaVenta = $_POST["servicioMonedaVenta"] : $servicioMonedaVenta = 0;
$servicioCantidadVenta= isset($_POST["servicioCantidadVenta"]) ? $servicioCantidadVenta = $_POST["servicioCantidadVenta"] : $servicioCantidadVenta = 1;
$servicioOrigenVenta= isset($_POST["servicioOrigenVenta"]) ? $servicioOrigenVenta = limpia($_POST["servicioOrigenVenta"]) : $servicioOrigenVenta = "";
$servicioDestinoVenta= isset($_POST["servicioDestinoVenta"]) ? $servicioDestinoVenta = limpia($_POST["servicioDestinoVenta"]) : $servicioDestinoVenta = "";


$idfleteadicionalm = isset($_POST["idfleteadicionalm"]) ? $idfleteadicionalm = limpia($_POST["idfleteadicionalm"]) : $idfleteadicionalm = 0;
$tarifaVentaFleteMV = isset($_POST["tarifaVentaFleteMV"]) ? $tarifaVentaFleteMV = limpia($_POST["tarifaVentaFleteMV"]) : $tarifaVentaFleteMV = 0;
$tarifaCostoFleteMV = isset($_POST["tarifaCostoFleteMV"]) ? $tarifaCostoFleteMV = limpia($_POST["tarifaCostoFleteMV"]) : $tarifaCostoFleteMV = 0;
$monedaFleteMV =isset($_POST["monedaFleteMV"]) ? $monedaFleteMV = limpia($_POST["monedaFleteMV"]) : $monedaFleteMV = 0;
$unidadesFleteMV=isset($_POST["unidadesFleteMV"]) ? $unidadesFleteMV = limpia($_POST["unidadesFleteMV"]) : $unidadesFleteMV = 1;
$horaFleteMV=isset($_POST["horaFleteMV"]) ? $horaFleteMV = limpia($_POST["horaFleteMV"]) : $horaFleteMV = "";
$fechaPosFleteMV=isset($_POST["fechaPosFleteMV"]) ? $fechaPosFleteMV = limpia($_POST["fechaPosFleteMV"]) : $fechaPosFleteMV = "";
$diaslibreFleteMV=isset($_POST["diaslibreFleteMV"]) ? $diaslibreFleteMV = limpia($_POST["diaslibreFleteMV"]) : $diaslibreFleteMV = 0;
$tipocargaFleteMV=isset($_POST["tipocargaFleteMV"]) ? $tipocargaFleteMV = limpia($_POST["tipocargaFleteMV"]) : $tipocargaFleteMV = 0;

$origenFleteMV=isset($_POST["origenFleteMV"]) ? $origenFleteMV = limpia($_POST["origenFleteMV"]) : $origenFleteMV = "";
$desitinoFleteMV=isset($_POST["desitinoFleteMV"]) ? $desitinoFleteMV = limpia($_POST["desitinoFleteMV"]) : $desitinoFleteMV = "";

$tiposunidadesF =isset($_POST["tiposunidadesF"]) ? $tiposunidadesF = $_POST["tiposunidadesF"] : $tiposunidadesF = array();
$tipounidadFleteVenta=isset($_POST["tipounidadFleteVenta"]) ? $tipounidadFleteVenta = limpia($_POST["tipounidadFleteVenta"]) : $tipounidadFleteVenta = 0;

switch ($_GET["op"]) {
    case 'guardarEditarVnt':
        if ($idventa == 0 || $idventa == "") {
            $resp = $venta->grabar($codigoProyectoVenta, $tipoVentaTRuck, $clienteVentaTruck, $proyectosTruck,$embarcadorVenta, $notificaraVenta, $agenteVenta, $observacionesVenta, $grabaC, $idcatalogos, $tarifaVentaS, $tarifaCostoS, $cantidadS, $profitS, $monedasS, $origenesS, $destinosS,$grabaF,$origenesF,$destinosF,$tarifaVentaIF,$tarifaCostoIF,$unidadesF,$totalVentaF,$totalCostoF,$profitF,$horaP,$monedasF,$codigosPVenta,$descripcionPVenta,$volumenPVenta,$pesoPVenta,$bultosPVenta,$pesoBultoPVenta,$diaslibres,$fechap,$tiposcarga,$tiposunidadesF);
            echo json_encode($resp);
        } else {
            $resp = $venta->editar($idventa,$observacionesVenta,$embarcadorVenta,$notificaraVenta,$agenteVenta,$idProductos,$codigosPVenta,$descripcionPVenta,$volumenPVenta,$pesoPVenta,$bultosPVenta,$pesoBultoPVenta);
            echo json_encode($resp);
        }
        break;
    case 'grabarEditarServicio':
        if ($idservicioA ==0 || $idservicioA == ""){
            $resp = $venta->grabarServicio($idventa,$idcatalogo,$servicioTarifaVenta,$servicioTarifaCosto,$servicioCantidadVenta,$servicioMonedaVenta,$servicioOrigenVenta,$servicioDestinoVenta);
            echo json_encode($resp);
        }else{
            $resp = $venta->editarServicio($idservicioA,$idcatalogo,$servicioTarifaVenta,$servicioTarifaCosto,$servicioCantidadVenta,$servicioMonedaVenta,$servicioOrigenVenta,$servicioDestinoVenta);
            echo json_encode($resp);
        }
        break;
    case 'grabarEditarFleteAdicional':
        if ($idfleteadicionalm ==0 || $idfleteadicionalm == ""){
            $resp = $venta->grabarFlete($idventa,$tarifaVentaFleteMV,$tarifaCostoFleteMV,$monedaFleteMV,$unidadesFleteMV,$horaFleteMV,$fechaPosFleteMV,$diaslibreFleteMV,$tipocargaFleteMV,$origenFleteMV,$desitinoFleteMV,$tipounidadFleteVenta);
            echo json_encode($resp);
        }else{
            $resp = $venta->editarFlete($idfleteadicionalm,$tarifaVentaFleteMV,$tarifaCostoFleteMV,$monedaFleteMV,$unidadesFleteMV,$horaFleteMV,$fechaPosFleteMV,$diaslibreFleteMV,$tipocargaFleteMV,$origenFleteMV,$desitinoFleteMV,$tipounidadFleteVenta);
            echo json_encode($resp);
        }
        break;    
    case 'anularVenta':
        $resp = $venta->anulaVenta($idventa);
        echo json_encode($resp);
        break; 
    case 'anularServicioAdicional':
        $resp = $venta->anulaServicioAdicional($idservicioA);
        echo json_encode($resp);
        break; 
    case 'anularFlete':
        $resp = $venta->anularFlete($idfleteadicionalm);
        echo json_encode($resp);
        break;      
    case 'listarServiosNuevo':
        $rspt = $tarifario->listarServiciosFlete($idproyecto);
        $acciones = "";
        mb_internal_encoding('UTF-8');
        //se declara un array para almacenar todo el query
        $data = array();
        foreach ($rspt as $reg) {
            $acciones = '';
            $data[] = array(
                "0" => $acciones,
                "1" => '<input type="checkbox" name="grabaC[]" value = "1">'. 
                        '<input type="hidden" name="idcatalogos[]" value= "' . $reg->id_catalogo . '">' .
                        '<input type="hidden" name="origenesS[]" value= "' . $reg->origen . '">' .
                        '<input type="hidden" name="destinosS[]" value= "' . $reg->destino . '">' .
                        '<input type="hidden" name="monedasS[]" value= "' . $reg->id_moneda . '">',
                "2" => $reg->origen,
                "3" => $reg->destino,
                "4" => $reg->servicio,
                "5" => '<input  style="width: 70px; height:10px;" type="number" name="tarifaVentaS[]" id="tarifaVentaS' . $reg->id_tarifa_servicio . '" value="' . $reg->tarifa_venta . '" onclick="calculaProfit('.$reg->id_tarifa_servicio.')" onkeyup = "calculaProfit('.$reg->id_tarifa_servicio.')" class="form-control input-sm">',
                "6" => '<input  style="width: 70px; height:10px;" type="number" name="tarifaCostoS[]" id="tarifaCostoS' . $reg->id_tarifa_servicio . '" value="' . $reg->tarifa_costo . '" onclick="calculaProfit('.$reg->id_tarifa_servicio.')" onkeyup = "calculaProfit('.$reg->id_tarifa_servicio.')" class="form-control input-sm">',
                "7" => $reg->moneda,
                "8" => '<input  style="width: 50px; height:10px;" type="number" name="cantidadS[]" id="cantidadS' . $reg->id_tarifa_servicio . '"  onclick="calculaProfit('.$reg->id_tarifa_servicio.')" onkeyup = "calculaProfit('.$reg->id_tarifa_servicio.')" class="form-control input-sm" value= "1">',
                "9" => '<input  style="width: 70px; height:10px;" type="number" name="comisions[]" id="comisions' . $reg->id_tarifa_servicio . '" class="form-control input-sm" readonly>',
                "10" => '<input  style="width: 70px; height:10px;" type="number" name="profitS[]" id="profitS' . $reg->id_tarifa_servicio . '" class="form-control input-sm" readonly>'
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
    case 'listarTarifaFleteNuevo':
        $rspt = $tarifario->listarTarifasFlete($idproyecto);
        $acciones = "";
        mb_internal_encoding('UTF-8');
        //se declara un array para almacenar todo el query
        $data = array();
        foreach ($rspt as $reg) {
            $acciones = '';
            $data[] = array(
                "0" => $acciones,
                "1" => '<input type="checkbox" name="grabaF[]" value = "1">'.
                        '<input type="hidden" name="origenesF[]" value= "' . $reg->origen . '">' .
                        '<input type="hidden" name="destinosF[]" value= "' . $reg->destino . '">' .
                        '<input type="hidden" name="monedasF[]" value= "' . $reg->id_moneda . '">'.
                        '<input type="hidden" name="tiposcarga[]" value= "' . $reg->id_tipo_carga . '">'.
                        '<input type="hidden" name="tiposunidadesF[]" value= "' . $reg->idtipo_unidades . '">',
                "2" => $reg->origen,
                "3" => $reg->destino,
                "4" => '<input  style="width: 70px; height:10px;" type="number" name="tarifaVentaIF[]" id="tarifaVentaIF' . $reg->id_tarifario_truck . '" value="' . $reg->tarifa_venta . '" onclick="calculaProfitflete('.$reg->id_tarifario_truck.')" onkeyup = "calculaProfitflete('.$reg->id_tarifario_truck.')"  class="form-control input-sm">',
                "5" => '<input  style="width: 70px; height:10px;" type="number" name="tarifaCostoIF[]" id="tarifaCostoIF' . $reg->id_tarifario_truck . '" value="' . $reg->tarifa_costo . '" onclick="calculaProfitflete('.$reg->id_tarifario_truck.')" onkeyup = "calculaProfitflete('.$reg->id_tarifario_truck.')" class="form-control input-sm">',              
                "6" => $reg->moneda,
                "7" => $reg->unidad,
                "8" => '<input  style="width: 50px; height:10px;" type="number" name="unidadesF[]" id="unidadesF' . $reg->id_tarifario_truck . '" onclick="calculaProfitflete('.$reg->id_tarifario_truck.')" onkeyup = "calculaProfitflete('.$reg->id_tarifario_truck.')" class="form-control input-sm"  value = "1">',
                "9" => '<input  style="width: 50px; height:10px;" type="number" readonly name="totalVentaF[]" id="totalVentaF' . $reg->id_tarifario_truck . '" class="form-control input-sm">',
                "10" => '<input  style="width: 50px; height:10px;" type="number" readonly name="totalCostoF[]" id="totalCostoF' . $reg->id_tarifario_truck . '" class="form-control input-sm">',
                "11" => '<input  style="width: 60px; height:10px;" type="time" name="horaP[]" id="horaP' . $reg->id_tarifario_truck . '" class="form-control input-sm">',
                "12" => '<input  style="width: 100px; height:10px;" type="date" name="fechap[]" id="fechap' . $reg->id_tarifario_truck . '" class="form-control input-sm">',
                "13" => '<input  style="width: 60px; height:10px;" type="number" name="diaslibres[]" id="diaslibres' . $reg->id_tarifario_truck . '" class="form-control input-sm">',
                "14" => $reg->tipocarga,
                "15" => '<input  style="width: 50px; height:10px;" type="number" readonly name="comisionf[]" id="comisionf' . $reg->id_tarifario_truck . '" class="form-control input-sm">',
                "16" => '<input  style="width: 50px; height:10px;" type="number" readonly name="profitF[]" id="profitF' . $reg->id_tarifario_truck . '" class="form-control input-sm">',
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
    case 'listarVentas':
        $rspt = $venta->listarVentas();
        $acciones = "";
        mb_internal_encoding('UTF-8');
        //se declara un array para almacenar todo el query
        $data = array();
        foreach ($rspt as $reg) {

            $acciones = "<button type= 'button' class='btn btn-warning btn-sm' onclick='mostrarVenta(". $reg->id_venta_truck .")' ><i class='fa fa-pencil'></i></button>". 
                        " <button type= 'button' class='btn btn-danger btn-sm' onclick='anularVenta(". $reg->id_venta_truck .")' ><i class='fa fa-close'></i></button>";
            $data[] = array(
                "0" => $acciones,
                "1" => $reg->codigo,
                "2" => $reg->cliente,
                "3" => $reg->proyecto,
                "4" => $reg->observaciones,
                "5"=> $reg->notificara

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
    case 'mostrarVenta':
        $rspt = $venta->listarVenta($idventa);
        echo json_encode($rspt);  
        break;
    case 'listarServicioA':
        $rspt = $venta->listarServiciosAdicionales($idventa);
        $acciones = "";
        mb_internal_encoding('UTF-8');
        //se declara un array para almacenar todo el query
        $data = array();
        foreach ($rspt as $reg) {
            $acciones ="<button type= 'button' class='btn btn-warning btn-sm' data-target='#modalServicioAdicionalVentaTruck' onclick='mostrarServicioAdicional(". $reg->id_servicio_adicional .")' ><i class='fa fa-pencil'></i></button>". 
            " <button type= 'button' class='btn btn-danger btn-sm' onclick='anulaServicioAdicional(". $reg->id_servicio_adicional .")' ><i class='fa fa-close'></i></button>";
            $data[] = array(
                "0" => $acciones,
                "1" => "",
                "2" => $reg->origen,
                "3" => $reg->destino,
                "4" => $reg->descripcion,
                "5" => $reg->tarifa_venta,
                "6" => $reg->tarifa_costo,
                "7" => $reg->signo,
                "8" => $reg->cantidad,
                "9" =>$reg->comision,
                "10" => $reg->profit
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
    
    case 'listarServicio':
        $rspt = $venta->listarServicioAdiconal($idservicioA);
        echo json_encode($rspt);  
        break;

    case 'listarFlete':
            $rspt = $venta->listarFlete($idfleteadicionalm);
            echo json_encode($rspt);     
            break;
    case 'listarFletes':
        $rspt = $venta->listarFletes($idventa);
        $acciones = "";
        mb_internal_encoding('UTF-8');
        //se declara un array para almacenar todo el query
        $data = array();
        foreach ($rspt as $reg) {
            $acciones ="<button type= 'button' class='btn btn-warning btn-sm'  data-target='#modalventafletetruck' onclick='mostrarFlete(". $reg->id_servicio_flete .")' ><i class='fa fa-pencil'></i></button> ". 
                        "<button type= 'button' class='btn btn-danger btn-sm' onclick='anularFlete(". $reg->id_servicio_flete .")' ><i class='fa fa-close'></i></button>";
            $data[] = array(
                "0" =>$acciones,
                "1" => "",
                "2" => $reg->origen,
                "3" => $reg->destino,
                "4" => $reg->tarifa_venta,
                "5" => $reg->tarifa_costo,
                "6" => $reg->signo,
                "7" =>$reg->tipounidad,
                "8" => $reg->unidades,
                "9" => $reg->total_venta,
                "10" => $reg->total_costo,
                "11" => $reg->hora_posicionamiento,
                "12" => $reg->fecha_posicion,
                "13" => $reg->dias_libres,
                "14" => $reg->tipocarga,
                "15" => $reg->comision,
                "16" => $reg->profit,               
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
        case 'listarProdcutos':
            $rspt = $venta->listarProductos($idventa);
            $tabla = '';
            mb_internal_encoding('UTF-8');
            //se declara un array para almacenar todo el query
            $data = array();
            foreach ($rspt as $reg) {
                $tabla = $tabla.'<tr class="filas" id ="fila'. $reg->id_producto .'">'.
                '<td><button type="button" class="btn btn-danger btn-sm" onclick="eliminarProducto('.   $reg->id_producto . ')"><span class="fa fa-trash-o"></span></button>'.
                '<input type="hidden" name="idProductos[]" value= "'.$reg->id_producto.'"></td>'.
                '<td ><input type "text"  style="width: 50px;"  name ="codigosPVenta[]" id ="codigosPVenta[]" value="'.$reg->codigo_producto.'"></td>'.
                '<td ><textarea name ="descripcionPVenta[]" id ="descripcionPVenta[]"  class ="form-control" rows="1">'.$reg->descripcion.' </textarea></td>'.
                '<td ><input type = "number"  style="width: 100px;"  name ="volumenPVenta[]" id ="volumenPVenta[]" value="'.$reg->volumen.'"></td>'.
                '<td ><input type ="number"  style="width: 100px;"  name ="pesoPVenta[]" id ="pesoPVenta[]" value="'.$reg->peso.'" ></td>'.
                '<td ><input type ="number"  style="width: 100px;"  name ="bultosPVenta[]" id ="bultosPVenta[]" value="'.$reg->bultos.'"></td>'.
                '<td ><input type ="number"  style="width: 100px;"  name ="pesoBultoPVenta[]" id ="pesoBultoPVenta[]" value="'.$reg->peso_bultos.'"></td>'.
                '</tr>';
            }
            echo $tabla;
            break;
}