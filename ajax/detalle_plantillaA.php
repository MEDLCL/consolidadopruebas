<?php
require_once "../config/Conexion.php";
require_once "../config/funciones.php";
require_once "../modelos/detalle_plantillaA.php";

$detalleP = new detallePlantilla();

$idmoneda =isset($_POST["idMonedaPlantillaMP"]) ? $idmoneda = $_POST["idMonedaPlantillaMP"] : $idmoneda = 0; 
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
        if ($iddetalle == 0 || $iddetalle == "") {
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
        //$idp = $_GET["idplantillaMP"];
        
        $rspt = $detalleP->listarDetallePlantilla($idplantilla);

        mb_internal_encoding('UTF-8');
        //se declara un array para almacenar todo el query
        $data = array();

        foreach ($rspt as $reg) {
           if ($reg->por_peso == 1 ){
              $porp = 'checked';
           }else{
               $porp = '';
           }
           if ($reg->por_volumen==1){
               $porv = 'checked';
           }else{
               $porv = '';
           }
           if ($reg->por_dia==1){
               $pord = 'checked';
           }else{
               $pord = '';
           }
  
            $data[] = array(
                "0" => $reg->nombre,
                "1" => "Accion",//'<button class="btn btn-warning" onclick="mostrarsucursal(' . $reg->id_detalle,$reg->id_catalogo . ')" data-toggle="modal"  data-target="#modalsucursal"  ><i class="fa fa-pencil"></i></button>',
                "2" => $minimo,
                "3" => $reg->tarifa,
                "4" => $reg->porcentaje,
                "5" => '<input disabled name="porP[]" class="form-check-input" type="checkbox" value="1" '. $porp .'>',
                "6" => '<input disabled name="porv[]" class="form-check-input" type="checkbox" value="1" '. $porv .'>',
                "7" => '<input disabled name="pord[]" class="form-check-input" type="checkbox" value="1" '. $porv .'>'
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
        //$rsp = $detalleP->muestraAlmacen($idalmacen);
        //echo json_encode($rsp);
        break;
}
