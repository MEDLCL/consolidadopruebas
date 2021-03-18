<?php
require_once "../config/Conexion.php";
require_once "../config/funciones.php";
require_once "../modelos/kardex.php"; 
$kardex = new kardex();


$idalmacen = isset($_POST["idAlmacen"]) ? $idsucursal = $_POST["idAlmacen"] : $idsucursal = 0;
$idconsignado = isset($_POST['consignado']) ? limpia($_POST['consignado']) : $idconsignado = '';
$contenedor = isset($_POST['contenedor']) ? limpia($_POST['contenedor']) : $contenedor = '';
$poliza = isset($_POST['poliza']) ? limpia($_POST['poliza']) : $poliza = '';
$referencia = isset($_POST['referencia']) ? $_POST['referencia'] : $referencia = 0;
$pesoT = isset($_POST['pesoT']) ? limpia($_POST['pesoT']) : $pesoT = '';
$volumenT = isset($_POST['volumenT']) ? limpia($_POST['volumenT']) : $volumenT = '';
$bultosT = isset($_POST['bultosT']) ? limpia($_POST['bultosT']) : $bultosT = '';
$codigoA = isset($_POST['codigoAlmacen']) ? limpia($_POST['codigoAlmacen']) : $codigoA = '';
$fechaI = isset($_POST['fechaI']) ? limpia($_POST['fechaI']) : $fechaI = '';
$cant_clientes = isset($_POST["cntClientes"])?limpia($_POST["cntClientes"]):$cant_clientes = "";

switch ($_GET["op"]) {
    case 'guardaryeditar':
        if ($idalmacen == 0 || $idalmacen ==""){
            $resp = $kardex->grabar($codigoA,$idconsignado,$contenedor,$poliza,$referencia,$pesoT,$volumenT,$bultosT,$fechaI,$cant_clientes);
            echo $resp;
        }  
        break;
   
    case 'mostrar':
        
        break;

    case 'listarK':
         $rspt = $kardex->listar();
           //se declara un array para almacenar todo el query
        $data = array();
        foreach ($rspt as $reg) {

            $data[] = array(
                "0" =>'<div class="btn-group">
                    <button type="button" class="btn btn-success dropdown-toggle btn-sm" data-toggle="dropdown">
                        <span class="fa fa-cog"></span>
                        Acciones
                        <span class="caret"></span>
                        <span class="sr-only">Desplegar menú</span>
                     </button>

                    <ul class="dropdown-menu" role="menu">
                        <li><a href="#"Editar onclick = "editarAlmacen('. $reg->id_almacen .')">Editar</a></li>
                        <li><a href="#">Anular</a></li>
                        <li><a href="#">Calculo</a></li>
                        <li class="divider"></li>
                        <li><a href="#">Acción #4</a></li>
                    </ul>
                    </div>',
                "1"=>$reg->estado,    
                "2" => $reg->annio,
                "3" => $reg->Codigo,
                "4" => $reg->consignado,
                "5" => $reg->contenedor_placa,
                "6" => $reg->poliza,
                "7" => $reg->referencia,
                "8" => $reg->fecha_almacen,
                "9" => $reg->cliente_Final,
                "10" => $reg->cant_clientes,
                "11" => $reg->nohbl,
                "12" => $reg->mercaderia,
                "13" => $reg->peso,
                "14" => $reg->volumen,
                "15" => $reg->bultos,
                "16" => $reg->ubicacion,
                "17" => $reg->linea,
                "18" => $reg->resa,
                "19" => $reg->Fecha_Retiro,
                "20" => $reg->Dias_Almacenaje,
                "21" => $reg->Dias_Libres_Almacenaje,
                "22" => $reg->Almacenaje,
                "23" => $reg->Gastos,
                "24" => $reg->Cif,
                "25" => $reg->Impuestos

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
        
        case 'codigo':
          $codigo =  $kardex->codigo();
          echo $codigo;
        break;
}
