<?php
session_start();
include_once "../config/Conexion.php";
class kardex
{

    public function __construct()
    {
    }
    public function grabar($codigoA,$idconsignado,$contenedor,$poliza,$referencia,$peso,$volumen,$bultos,$fechaI){
        $fechaG = date("Y-m-d");
        $fechaI = date("Y-m-d",strtotime($fechaI));
        $con = Conexion::getConexion();
        $stmt = $con->prepare("INSERT INTO almacen(id_usuario,id_sucursal,id_consignado,codigo,contenedor_placa,poliza,referencia,peso,volumen,bultos,fecha_almacen,fecha_graba,id_usuario_modifica,fecha_modifica)
                            VALUES (:idusuario,:idsucursal,:idconsignado,:codigo,:contenedor,:poliza,:referencia,:peso,:volumen,:bultos,:fechaI,:fechaG,:idusuarioM,:fechaM)");
        $stmt->bindParam(":idusuario",$_SESSION['idusuario']);                    
        $stmt->bindParam(":idsucursal",$_SESSION["idsucursal"]);
        $stmt->bindParam(":idconsignado",$idconsignado);
        $stmt->bindParam(":codigo",$codigoA);
        $stmt->bindParam(":contenedor",$contenedor);
        $stmt->bindParam(":poliza",$poliza);
        $stmt->bindParam(":referencia",$referencia);
        $stmt->bindParam(":peso",$peso);
        $stmt->bindParam(":volumen",$volumen);
        $stmt->bindParam(":bultos",$bultos);
        $stmt->bindParam(":fechaI",$fechaI);
        $stmt->bindParam(":fechaG",$fechaG);
        $stmt->bindParam(":idusuarioM",$_SESSION["idusuario"]);
        $stmt->bindParam(":fechaM",$fechaG);
        $stmt->execute();

        if ($stmt){
            return $con->lastInsertId();
        }
    }
    public function codigo()
    {
        $codigo = "";
        $mes = date("m");
        $annio = date("y");

        $con = Conexion::getConexion();

        $stm = $con->prepare("SELECT COUNT(contador)AS CNT FROM  correlativo_almacen 
                            WHERE annio = :annio AND mes = :mes AND id_sucursal= :idsucursal");
        $stm->bindParam(":annio", $annio);
        $stm->bindParam(":mes", $mes);
        $stm->bindParam(":idsucursal", $_SESSION["idsucursal"]);
        $stm->execute();
        $stm = $stm->fetch(PDO::FETCH_OBJ);
        
        if ($stm) {
            $cont = $stm->CNT+1;
            $stm = $con->prepare("INSERT INTO correlativo_almacen (annio,mes,id_sucursal,contador) 
            VALUES (:annio,:mes,:idsucursal,:contador)");
            $stm->bindParam(":annio", $annio);
            $stm->bindParam(":mes", $mes);
            $stm->bindParam(":idsucursal", $_SESSION['idsucursal']);
            $stm->bindParam(":contador",$cont);
            $stm->execute();
            if ($stm) {
                $idcont = $con->lastInsertId();
                $codigo = $mes . "." . $cont . "." . $annio;
            }
        }
        $con = Conexion::cerrar();
        return $codigo;
    }
}
