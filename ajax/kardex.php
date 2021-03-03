<?php
require_once "../config/Conexion.php";
require_once "../config/funciones.php";
/* require_once "../modelos/sucursal.php";
$sucursal = new Sucursal();

$idsucursal = isset($_POST["idsucursal"]) ? $idsucursal = $_POST["idsucursal"] : $idsucursal = 0;
$razons = isset($_POST['razons']) ? limpia($_POST['razons']) : $razons = '';
$nombrec = isset($_POST['nombrec']) ? limpia($_POST['nombrec']) : $nombrec = '';
$telefono = isset($_POST['Telefono']) ? limpia($_POST['Telefono']) : $telefono = '';
$pais = isset($_POST['pais']) ? $_POST['pais'] : $pais = 0;
$identificacion = isset($_POST['identificacion']) ? limpia($_POST['identificacion']) : $identificacion = '';
$direccion = isset($_POST['direccion']) ? limpia($_POST['direccion']) : $direccion = '';
$logo = isset($_POST['logo']) ? limpia($_POST['logo']) : $logo = '';
$codigo = isset($_POST['codigo']) ? limpia($_POST['codigo']) : $codigo = ''; */


switch ($_GET["op"]) {
    case 'guardaryeditar':
        
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
}
