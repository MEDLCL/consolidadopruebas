<?php
include_once "../config/funciones.php";
include_once "../modelos/ingresoMaritimo.php";

$ingresoMaritimo = new IngresoMaritimo();

$idembarque = isset($_POST['idembarquemaritimo']) ? $idembarque = limpia($_POST['idembarquemaritimo']) : $idembarque = 0;

switch ($_GET['op']) {

    case 'listarEmbarqueOP':
        if ($_SESSION['puesto'] == 'Gerente' || $_SESSION['puesto'] == 'Coordinador' ||$_SESSION['puesto'] =='Programador'){
            $res = $ingresoMaritimo->listarEmbarqueTodos(); 
        }else{
            $res = $ingresoMaritimo->listarEmbarqueAsignado();
        }

        $data = array();
        foreach ($res as $reg) {
            $data[] = array(
                "0" => '<button class="btn btn-warning btn-sm" onclick="mostrarEmbarque(' . $reg->id_embarque_maritimo . ')"><i class="fa fa-pencil" ></i></button>' 
                .' <button class="btn btn-danger btn-sm" onclick="anularEmbarque(' . $reg->id_embarque_maritimo . ')"><i class="fa fa-trash" ></i></button>',               
                "1" => $reg->fechaingreso,
                "2" => $reg->codigo,
                "3" => $reg->consecutivo,
                "4" => $reg->tipocarga,
                "5" => $reg->tiposervicio,
                "6" => $reg->courier,
                "7" => $reg->barco,
                "8" => $reg->viaje,
                "9" => $reg->cant_clientes,
                "10" => $reg->agente,
                "11" => $reg->Naviera,
                "12" => $reg->origen,
                "13" => $reg->destino,
                "14" => $reg->usuarioA,
                "15" => $reg->observaciones
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

/* 

 */