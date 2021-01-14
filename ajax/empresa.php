<?php  
include_once "../config/funciones.php";

$idempresa = isset($_POST['idemprea'])?$idempresa = limpia($_POST['idempresa']): $idempresa =0;
$codigo = isset($_POST['codigo'])? $codigo=limpia($_POST['codigo']): $codigo= '' ;
$tipoE = isset($_POST[''])?$tipoE = limpia($_POST['']) : $tipoE = ''; 



switch ($_GET['op']) {
    case 'guardaryeditar':
        # code...
        break;
    
    default:
        # code...
        break;
}
?>