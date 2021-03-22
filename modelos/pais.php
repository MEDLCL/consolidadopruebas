<?php
session_start();
include_once  "../config/Conexion.php";

$tabla = isset($_GET['tabla']) ? $tabla = $_GET['tabla'] : $tabla = '';
$campo = isset($_GET['campo']) ? $campo = $_GET['campo'] : $campo = '';
$id = isset($_POST['id']) ? $id = $_POST['id'] : $id = '';
$tipoe = isset($_POST['tipoe'])?$tipoe = $_POST['tipoe']:$tipoe = '';

switch ($_GET['op']) {
    case 'pais':
        pais();
        break;
    case 'selectP':
        selectPadre($tabla, $campo, $id);
    case 'selecEmpresa':
        selecEmpresa($tabla, $campo, $id,$tipoe);
        break;
    case 'selectN':
        selectNomal($tabla,$campo,$id);
        break;
    default:
        
    break;
}

function selectPadre($tabla, $campo, $id)
{
    $con = Conexion::getConexion();
    $stmt = $con->prepare("SELECT * FROM $tabla ORDER  BY $campo ASC");
    $stmt->execute();
    $selec = '';
    $selec = '<option value="0" selected>Seleccione una Opcion</option>';
    foreach ($stmt->fetchAll(PDO::FETCH_OBJ) as  $resp) {
        $selec = $selec . '<option value="' . $resp->$id . '">' . $resp->$campo . '</option>';
    }
    echo $selec;
    $con = Conexion::cerrar();
    $stmt = NULL;
}

function pais()
{
    $conexion = Conexion::getConexion();
    $stmt = $conexion->prepare("select idpais,nombre,iniciales from pais order by nombre asc");
    $stmt->execute();
    $selec = '<option value="0">Seleccione un pais</option>';
    foreach ($stmt->fetchAll(PDO::FETCH_OBJ) as $pais) :
        $selec = $selec . '<option value="' . $pais->idpais . '">' . $pais->nombre . "-" . $pais->iniciales . ' </option>
';
    endforeach;
    echo $selec;
    $conexion = Conexion::cerrar();
    $stmt = null;
}

function selecEmpresa($tabla, $campo, $id,$tipoe)
{
    $con = Conexion::getConexion();
    $stmt = $con->prepare("SELECT * FROM $tabla WHERE Tipoe = :tipoe AND id_sucursal = :id_sucursal ORDER  BY $campo ASC");
    $stmt->bindParam(":tipoe",$tipoe);
    $stmt->bindParam(":id_sucursal",$_SESSION['idsucursal']);
    $stmt->execute();
    $selec = '';
    $selec = '<option value="0" selected>Seleccione una Opcion</option>';
    foreach ($stmt->fetchAll(PDO::FETCH_OBJ) as  $resp) {
        $selec = $selec . '<option value="' . $resp->$id . '">' . $resp->$campo . '</option>';
    }
    echo $selec;
    $con = Conexion::cerrar();
    $stmt = NULL;
}
function selectNomal($tabla,$campo,$id){
    $con = Conexion::getConexion();
    $stmt = $con->prepare("SELECT * FROM $tabla  ORDER  BY $campo ASC");
    $stmt->bindParam(":id_sucursal",$_SESSION['idsucursal']);
    $stmt->execute();
    $selec = '';
    $selec = '<option value="0" selected>Seleccione una Opcion</option>';
    foreach ($stmt->fetchAll(PDO::FETCH_OBJ) as  $resp) {
        $selec = $selec . '<option value="' . $resp->$id . '">' . $resp->$campo . '</option>';
    }
    echo $selec;
    $con = Conexion::cerrar();
    $stmt = NULL;
}
