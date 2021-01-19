<?php
include_once "../config/funciones.php";
include_once "../modelos/empresa.php";
$empresa = new Empresa();

$idempresa = isset($_POST['idemprea']) ? $idempresa = limpia($_POST['idempresa']) : $idempresa = 0;
$codigo = isset($_POST['codigo']) ? $codigo = limpia($_POST['codigo']) : $codigo = '';
$tipoE = isset($_POST['tipoE']) ? $tipoE = limpia($_POST['tipoE']) : $tipoE = '';

$razons = isset($_POST['Razons']) ? $razons = limpia($_POST['Razons']) : $razons = '';
$nombrec = isset($_POST['Nombrec']) ? $nombrec = limpia($_POST['Nombrec']) : $nombrec = '';
$nit = isset($_POST['identificacion']) ? $nit = limpia($_POST['identificacion']) : $nit = '';
$telefono = isset($_POST['telefono']) ? $telefono = limpia($_POST['telefono']) : $telefono = '';
$dire = isset($_POST['direccion']) ? $dire = limpia($_POST['direccion']) : $dire = '';
$comision = isset($_POST['comision']) ? $comision = limpia($_POST['comision']) : $comision = 0;
$cbmtarifa = isset($_POST['cbmtarifa']) ? $cbmtarifa = limpia($_POST['cbmtarifa']) : $cbmtarifa = '';

switch ($_GET['op']) {
    case 'guardaryeditar':
        if ($idempresa == 0) {
            $res = $empresa->grabar($codigo, $tipoE, $razons, $nombrec, $nit, $telefono, $dire, $comision, $cbmtarifa, $_POST['nombresc'], $_POST['apellidosc'], $_POST['correosc'], $_POST['telefonosc'], $_POST['puestosc']);
        }
        break;
    case 'buscae':
        $res = $empresa->buscaEmpresa($idempresa);
        echo json_encode($res);
        break;

    case 'listare':
        $res = $empresa->listar();
        $data = array();
        foreach ($res as $reg) {
            $data[] = array(
                "0" => '<button class="btn btn-warning" onclick="mostrarempresa(' . $reg->id_empresa . ')"><i class="fa fa-pencil"></i></button>',
                "1"=>$reg->codigo,
                "2" => $reg->Razons,
                "3" => $reg->Nombrec,
                "4" => $reg->identificacion,
                "5" => $reg->telefono,
                "6" => $reg->direccion,
                "7" => $reg->porcentaje_comision,
                "8" => $reg->tipo_comision,
                "9" => "",//$reg->nombre,
                "10" => "",//$reg->apellido,
                "11" => "",//$reg->correo,
                "12" => "",///$reg->tel,
                "13" => "",//$reg->puesto
                /* 
                   <th>Pais</th>
                   <th>Direccion</th>
                   <th>%Comision</th>
                   <th>Tipo Comision</th>
                   <th>Nombre</th>
                   <th>Apellido</th>
                   <th>Correo</th>
                   <th>Tel</th>
                   <th>Fax</th>
                   <th>Puesto</th> */
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

    default:
        # code...
        break;
}
