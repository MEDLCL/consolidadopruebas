<?php
session_start();
include_once "../config/Conexion.php";
class IngresoMaritimo
{
    public function __construct()
    {
    
    }

    public function listarEmbarqueTodos()
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("call prcListadoCreaMaritimo(:idsucursal);");
            $rsp->bindParam(":idsucursal", $_SESSION['idsucursal']);
            $rsp->execute();
            $rsp = $rsp->fetchAll(PDO::FETCH_OBJ);
            return $rsp;
        } catch (\Throwable $th) {
            return 0;
        }
    }
    public function listarEmbarqueAsignado()
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("call prcListadoCreaMaritimoAsignado(:idsucursal,:idusuario);");
            $rsp->bindParam(":idsucursal", $_SESSION['idsucursal']);
            $rsp->bindParam(":idusuario", $_SESSION['idusuario']);
            $rsp->execute();
            $rsp = $rsp->fetchAll(PDO::FETCH_OBJ);
            return $rsp;
        } catch (\Throwable $th) {
            return 0;
        }
    }

}
