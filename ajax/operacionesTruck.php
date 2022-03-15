<?php
require_once "../config/Conexion.php";
require_once "../config/funciones.php";
require_once "../modelos/tarifaTruck.php";
require_once "../modelos/ventaTruck.php";

$venta = new ventaTruck();

$idventa = isset($_POST["ventaOperaciones"]) ? $idventa = $_POST["ventaOperaciones"] : $idventa = 0;

switch ($_GET["op"]) {
    case '':
        
        break;
    case '':
        
        break;
    case '':

        break;    
    case '':

        break; 
    case '':
        break; 
    case '':
        break;      
    case 'listarServiosNuevo':
        
        break;
    case 'listarTarifaFleteNuevo':
        break;
    case '':

        break;
    case '':
        break;
    case '':

    break;
    
    case '':
        break;

    case '':
            break;
    case 'listarFletes':
        $rspt = $venta->listarFletes($idventa);
        mb_internal_encoding('UTF-8');
        //se declara un array para almacenar todo el query
        $data = array();
        foreach ($rspt as $reg) {
            $data[] = array(
                "0" =>$reg->origen.', '.$reg->destino,
                "1" =>$reg->tipounidad,
                "2" => $reg->unidades,
                "3" => $reg->tarifa_venta,
                "4" => $reg->tarifa_costo,
                "5" => $reg->signo,
                "6" => $reg->total_venta,
                "7" => $reg->hora_posicionamiento,
                "8" => $reg->tipocarga        
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