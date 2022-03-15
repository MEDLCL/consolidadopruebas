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
$idcontacto = isset($_POST['id_contacto'])?$idcontacto = $_POST['id_contacto']:$idcontacto = 0;

$celularesc=isset($_POST['celularesc']) ? $celularesc =  $_POST['celularesc'] : $celularesc = array();
$cumplec=isset($_POST['cumplec']) ? $cumplec =  $_POST['cumplec'] : $cumplec = array();
$medioComunicacionC=isset($_POST['medioComunicacionC']) ? $medioComunicacionC =  $_POST['medioComunicacionC'] : $medioComunicacionC = array();

$idpaisEmpresa = isset($_POST["paisEmpresa"])?$idpaisEmpresa= $_POST["paisEmpresa"]:$idpaisEmpresa =0;

$gironegocio = isset($_POST['giroNegocio']) ? $gironegocio = $_POST['giroNegocio'] : $gironegocio = 0;
$tamEmpresa = isset($_POST['tamanoEmpresa']) ? $tamEmpresa =  $_POST['tamanoEmpresa'] : $tamEmpresa = 0;
$tipoCarga = isset($_POST['tipoCargaEmpresa'])?$tipoCarga = $_POST['tipoCargaEmpresa']:$tipoCarga = 0;
$canalDis = isset($_POST["canalDistribucion"])?$canalDis= $_POST["canalDistribucion"]:$canalDis =0;

$representanteL = isset($_POST["representanteLegal"])?$representanteL= $_POST["representanteLegal"]:$representanteL ="";
$diasCredito = isset($_POST['diasCreditoTR']) ? $diasCredito = $_POST['diasCreditoTR'] : $diasCredito = 0;
$cuentaBan = isset($_POST['cuentaBancariaTR']) ? $cuentaBan =  $_POST['cuentaBancariaTR'] : $cuentaBan = "";
$paraCheque = isset($_POST['paraCheque'])?$paraCheque = $_POST['paraCheque']:$paraCheque = "";
$idmonedaPago = isset($_POST["monedaPago"])?$idmonedaPago= $_POST["monedaPago"]:$idmonedaPago =0;

$aniversarioCliente = isset($_POST["aniversarioCliente"])?$aniversarioCliente= $_POST["aniversarioCliente"]:$aniversarioCliente =date('Y-m-d');


$Nombre = isset($_POST['Nombre']) ? $Nombre = limpia($_POST['Nombre']) : $Nombre = "";
$Apellido = isset($_POST['Apellido']) ? $Apellido = limpia($_POST['Apellido']) : $Apellido = "";
$Correo = isset($_POST['Correo']) ? $Correo = limpia($_POST['Correo']) : $Correo = "";
$telefonoc = isset($_POST['telefonoc']) ? $telefonoc = $_POST['telefonoc'] : $telefonoc = "";
$puesto = isset($_POST['puesto']) ? $puesto =  limpia($_POST['puesto']) : $puesto = "";
$celularclie=isset($_POST['celularclie']) ? $celularclie =  $_POST['celularclie'] : $celularclie = "";
$cumpleContatoClie=isset($_POST['cumpleContatoClie']) ? $cumpleContatoClie =  $_POST['cumpleContatoClie'] : $cumpleContatoClie = "";
$medioComunicacionCli=isset($_POST['medioComunicacionCli']) ? $medioComunicacionCli =  $_POST['medioComunicacionCli'] : $medioComunicacionCli = 0;

$nombreSucursalM  = isset($_POST['nombreSucursalM']) ? $nombreSucursalM = $_POST['nombreSucursalM'] : $nombreSucursalM = array();
$id_sucursalCliente = isset($_POST['id_sucursalCliente']) ? $id_sucursalCliente = $_POST['id_sucursalCliente'] : $id_sucursalCliente = 0;
$nombreSucursal= isset($_POST['nombreSucursal']) ? $nombreSucursal = limpia($_POST['nombreSucursal']) : $nombreSucursal = "";

$res = 0;

switch ($_GET['op']) {
    case 'guardaryeditar':
        if ($idempresa == 0) {
            $verifica = $empresa->verificaempresa($razons, $nombrec);
            if ($verifica == 2) {
                echo $verifica;
            } else if ($verifica == 3) {
                $codigo =$empresa->codigo($tipoE); 
                $res = $empresa->grabar($codigo, $tipoE, $razons, $nombrec, $nit, $telefono, $dire, $comision, $cbmtarifa, $nombresc, $apellidos, $correosc, $telefonosc, $puestosc,$idpaisEmpresa,$gironegocio,$tipoCarga,$tamEmpresa,$canalDis,$representanteL,$diasCredito,$cuentaBan,$paraCheque,$idmonedaPago,$aniversarioCliente,$celularesc,$cumplec,$medioComunicacionC,$nombreSucursalM);
                echo $res;

            } else {
                echo 0;
            }
        } else {
            //actualizacion de empresas
            $verifica = $empresa->verificaempresaU($razons, $nombrec, $idempresa);
            if ($verifica == 2) {
                echo $verifica;
            } else if ($verifica == 3) {
                $res = $empresa->editarE($idempresa, $codigo, $tipoE, $razons, $nombrec, $nit, $telefono, $dire, $comision, $cbmtarifa, $nombresc, $apellidos, $correosc, $telefonosc, $puestosc,$idpaisEmpresa,$gironegocio,$tipoCarga,$tamEmpresa,$canalDis,$aniversarioCliente);
                echo $res;
            }
        }
        break;
    case 'mostrare':
        $res = $empresa->buscaEmpresa($idempresa);
        echo json_encode($res);
        break;
    case 'grabaContacto':
        if ($idcontacto ==0 || $idcontacto ==""){
            $res = $empresa->grabarContacto($idempresa,$Nombre,$Apellido,$Correo,$telefonoc,$puesto,$celularclie,$cumpleContatoClie,$medioComunicacionCli);
        }else{
            $res = $empresa->editarContacto($idcontacto,$Nombre,$Apellido,$Correo,$telefonoc,$puesto,$celularclie,$cumpleContatoClie,$medioComunicacionCli);
        }
        echo json_encode($res);
        break;
    case 'grabaSucursal':
        if ($id_sucursalCliente ==0 || $id_sucursalCliente ==""){
            $res = $empresa->grabaSucursal($idempresa,$nombreSucursal);
        }else{
            $res = $empresa->editarSucursal($id_sucursalCliente,$nombreSucursal);
        }
        echo json_encode($res);
        break;
    case 'listare':
        $res = $empresa->listar();
        $data = array();
        foreach ($res as $reg) {
            $data[] = array(
                "0" => '<button data-toggle="modal" data-target="#modalempresa" class="btn btn-warning btn-sm" onclick="mostrarempresa(' . $reg->id_empresa . ')"><i class="fa fa-pencil" ></i></button>',
                "1" => $reg->codigo,
                "2"=> $reg->pais,
                "3" => $reg->Razons,
                "4" => $reg->Nombrec,
                "5" => $reg->identificacion,
                "6" => $reg->telefono,
                "7" => $reg->direccion
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
        $res = $empresa->listarcontacto($idempresa);
        $acciones = "";
        mb_internal_encoding('UTF-8');
        //se declara un array para almacenar todo el query
        $data = array();
        foreach ($res as $reg) {
            $acciones ="<button type= 'button' class='btn btn-warning btn-sm' onclick='mostratContacto(".$reg->id_contacto .")' ><i class='fa fa-pencil'></i></button>". 
            " <button type= 'button' class='btn btn-danger btn-sm' onclick='eliminarfila(". $reg->id_contacto .")' ><i class='fa fa-close'></i></button>";
            $data[] = array(
                "0" => $acciones,
                "1" => $reg->nombre,
                "2" => $reg->apellido ,
                "3" => $reg->correo,
                "4" => $reg->telefono,
                "5" => $reg->celular ,
                "6" => $reg->puesto ,
                "7" => $reg->cumpleanios,
                "8" => $reg->omunicacion 
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
        case 'listarSucursal':
            $res = $empresa->listarSucursales($idempresa);
            $acciones = "";
            mb_internal_encoding('UTF-8');
            //se declara un array para almacenar todo el query
            $data = array();
            foreach ($res as $reg) {
                $acciones ="<button type= 'button' class='btn btn-warning btn-sm' onclick='mostrarSucursal(".$reg->id_sucursal_empresa .")' ><i class='fa fa-pencil'></i></button>". 
                " <button type= 'button' class='btn btn-danger btn-sm' onclick='eliminarSucursal(". $reg->id_sucursal_empresa .")' ><i class='fa fa-close'></i></button>";
                $data[] = array(
                    "0" => $acciones,
                    "1" => $reg->nombre,
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
    case 'mostrarContacto':
        $res = $empresa->mostrarContacto($idcontacto);
        echo json_encode($res);
        break;
    case 'mostrarSucursal':
            $res = $empresa->mostrarSucursal($id_sucursalCliente);
            echo json_encode($res);
            break;   
    case 'eliminaC':
        $res = $empresa->eliminarContacto($idcontacto,$idempresa);
        echo $res?1:0; 
        break;
    default:
        # code...
        break;
}
