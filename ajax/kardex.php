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

switch ($_GET["op"]) {
    case 'guardaryeditar':
        if ($idalmacen == 0 || $idalmacen ==""){
            $resp = $kardex->grabar($codigoA,$idconsignado,$contenedor,$poliza,$referencia,$pesoT,$volumenT,$bultosT,$fechaI);
            echo $resp;
        }  
        break;
   
    case 'mostrar':
        
        break;

    case 'listar':
        $con = Conexion::getConexion();
        $rspt = $con->prepare("SELECT * 
                                        FROM  sucursal as s  LEFT JOIN 
                                        pais AS p ON p.idpais = s.idpais");
        $rspt->execute();
        $rspt = $rspt->fetchAll(PDO::FETCH_OBJ);
        //se declara un array para almacenar todo el query
        $data = array();
        foreach ($rspt as $reg) {
            $data[] = array(
                "0" => '<button class="btn btn-warning" onclick="mostrarsucursal(' . $reg->id_sucursal . ')" data-toggle="modal"  data-target="#modalsucursal"  ><i class="fa fa-pencil"></i></button>',
                "1" => ($reg->estado) ? '<button class="btn btn-danger" onclick="inactivar(' . $reg->id_sucursal . ')"><i class="fa fa-close"></i></button>' : '<button class="btn btn-primary" onclick="activar(' . $reg->id_sucursal . ')"><i class="fa fa-check"></i></button>',
                "2" => $reg->razons,
                "3" => $reg->nombrec,
                "4" => $reg->Telefono,
                "5" => $reg->nombre . ' ' . $reg->iniciales,
                "6" => file_exists("../logos/" . $reg->logo) ? "<img  src='../logos/" . $reg->logo . "'  width= '50px' height= '50px'>" : "<img src=''>",
                "7" => $reg->identificacion,
                "8" => $reg->direccion,
                "9" => $reg->codigo,
                "10" => ($reg->estado) ? '<span class="label bg-green">Activado</span>' : '<span class="label bg-red">Desactivado</span>'
            );
        }
        $results = array(
            "sEcho" => 1, //informacion para el datatable
            "iTotalRecords" => count($data), //enviamos el total al datatable
            "iTotalDisplayRecords" => count($data), //enviamos total de rgistror a utlizar
            "aaData" => $data
        );
        echo json_encode($results);
        $con = Conexion::cerrar();
        break;
        
        case 'codigo':
          $codigo =  $kardex->codigo();
          echo $codigo;
        break;
}
