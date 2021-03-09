<?php
include_once "../config/Conexion.php";
class kardex {

    public function __construct()
    {
    }

    public function codigo(){
        $codigo= "";
        $mes = "";
        $annio = "";
        $con = Conexion::getConexion();
        $stm = $con->prepare("SELECT * FROM correlativo_almacen WHERE annio = :annio, and mes = :mes");
        
        return $codigo;
    }
}

?>