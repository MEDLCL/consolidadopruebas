<?php
include_once "../config/funciones.php";
include_once "../modelos/empresa.php";
$empresa = new Empresa();

$idempresa = isset($_POST['idempresa']) ? $idempresa = limpia($_POST['idempresa']) : $idempresa = 0;
$codigo = isset($_POST['codigo']) ? $codigo = limpia($_POST['codigo']) : $codigo = '';
$tipoE = isset($_POST['tipoE']) ? $tipoE = limpia($_POST['tipoE']) : $tipoE = '';

$razons = isset($_POST['Razons']) ? $razons = limpia($_POST['Razons']) : $razons = '';
$nombrec = isset($_POST['Nombrec']) ? $nombrec = limpia($_POST['Nombrec']) : $nombrec = '';
$nit = isset($_POST['identificacion']) ? $nit = limpia($_POST['identificacion']) : $nit = '';
$telefono = isset($_POST['telefono']) ? $telefono = limpia($_POST['telefono']) : $telefono = '';
$dire = isset($_POST['direccion']) ? $dire = limpia($_POST['direccion']) : $dire = '';
$comision = isset($_POST['comision']) ? $comision = limpia($_POST['comision']) : $comision = 0;
$cbmtarifa = isset($_POST['cbmtarifa']) ? $cbmtarifa = limpia($_POST['cbmtarifa']) : $cbmtarifa = '';
$nombresc = isset($_POST['nombresc']) ? $usariosc = $_POST['nombresc'] : $usariosc = array();
$apellidos = isset($_POST['apellidosc']) ? $apellidos = $_POST['apellidosc'] : $apellidos = array();
$correosc = isset($_POST['correosc']) ? $correosc = $_POST['correosc'] : $correosc = array();
$telefonosc = isset($_POST['telefonosc']) ? $telefonosc = $_POST['telefonosc'] : $telefonosc = array();
$puestosc = isset($_POST['puestosc']) ? $puestosc =  $_POST['puestosc'] : $puestosc = array();

switch ($_GET['op']) {
    case 'guardaryeditar':
        if ($idempresa == 0) {
            $verifica = $empresa->verificaempresa($razons, $nombrec);
            if ($verifica == 2) {
                echo $verifica;
            } else if ($verifica == 3) {
                $codigo = $empresa->codigo($tipoE);
                echo   $res = $empresa->grabar($codigo, $tipoE, $razons, $nombrec, $nit, $telefono, $dire, $comision, $cbmtarifa, $nombresc, $apellidos, $correosc, $telefonosc, $puestosc);
            } else {
                echo 0;
            }
        } else {
            //actualizacion de empresas
            $verifica = $empresa->verificaempresaU($razons, $nombrec, $idempresa);
            if ($verifica == 2) {
                echo $verifica;
            } else if ($verifica == 3) {
                echo $res = $empresa->editarE($idempresa, $codigo, $tipoE, $razons, $nombrec, $nit, $telefono, $dire, $comision, $cbmtarifa, $nombresc, $apellidos, $correosc, $telefonosc, $puestosc);
            }
        }
        break;
    case 'mostrare':
        $res = $empresa->buscaEmpresa($idempresa);
        echo json_encode($res);
        break;

    case 'listare':
        $res = $empresa->listar();
        $data = array();
        foreach ($res as $reg) {
            $data[] = array(
                "0" => '<button data-toggle="modal" data-target="#modalempresa" class="btn btn-warning" onclick="mostrarempresa(' . $reg->id_empresa . ')"><i class="fa fa-pencil" ></i></button>',
                "1" => $reg->codigo,
                "2" => $reg->Razons,
                "3" => $reg->Nombrec,
                "4" => $reg->identificacion,
                "5" => $reg->telefono,
                "6" => $reg->direccion,
                "7" => $reg->porcentaje_comision,
                "8" => $reg->tipo_comision,
                "9" => $reg->nombre,
                "10" => $reg->apellido,
                "11" => $reg->correo,
                "12" => $reg->tel,
                "13" => $reg->puesto
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
