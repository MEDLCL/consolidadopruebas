<?php
session_start();
include_once "../config/Conexion.php";

class detallePlantilla
{

    public function __construct()
    {
    }
    public function grabar($idplantilla, $idcatalogo, $idmoneda, $minimo, $tarifa, $porcentaje, $porpeso, $porvolumen, $pordia)
    {
        //$fechaG = date("Y-m-d");
        //$estado = 1;
        $con = Conexion::getConexion();
        // `tarifa`, ``, ``, ``
        try {
            $stmt = $con->prepare("INSERT INTO detalle_plantillaa(id_plantilla, id_catalogo,id_sucursal,id_usuario,id_moneda,minimo,tarifa,porcentaje,por_peso,por_volumen,por_dia)
                                VALUES (:idplantilla,:idcatalogo,:idsucursal,:idusuario,:idmoneda,:minimo,:tarifa,:porcentaje,:porpeso,:porvolumen,:pordia)");
            $stmt->bindParam(":idplantilla", $idplantilla);
            $stmt->bindParam(":idcatalogo", $idcatalogo);
            $stmt->bindParam(":idsucursal", $_SESSION["idsucursal"]);
            $stmt->bindParam(":idusuario", $_SESSION["idusuario"]);
            $stmt->bindParam(":idmoneda", $idmoneda);
            $stmt->bindParam(":minimo", $minimo);
            $stmt->bindParam(":tarifa", $tarifa);
            $stmt->bindParam(":porcentaje", $porcentaje);
            $stmt->bindParam(":porpeso", $porpeso);
            $stmt->bindParam(":porvolumen", $porvolumen);
            $stmt->bindParam(":pordia", $pordia);
            $stmt->execute();
            if ($stmt) {
                return $con->lastInsertId();
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }
    public function editarDetalle($iddetalle, $idcatalogo, $minimo, $tarifa, $porcentaje, $porpeso, $porvolumen, $pordia)
    {
        $con = Conexion::getConexion();
        try {

            $stmt = $con->prepare("UPDATE detalle_plantillaa 
                    SET id_catalogo=:idcatalogo,
                        minimo=:minimo,
                        tarifa=:tarifa,
                        porcentaje=:porcentaje,
                        por_peso=:porpeso,
                        por_volumen=:porvolumen,
                        por_dia=:pordia
                    WHERE id_detalle=:id_detalle");
            $stmt->bindParam(":idcatalogo", $idcatalogo);
            $stmt->bindParam(":minimo", $minimo);
            $stmt->bindParam(":tarifa", $tarifa);
            $stmt->bindParam(":porcentaje", $porcentaje);
            $stmt->bindParam(":porpeso", $porpeso);
            $stmt->bindParam(":porvolumen", $porvolumen);
            $stmt->bindParam(":pordia", $pordia);
            $stmt->bindParam(":id_detalle", $iddetalle);
            $stmt->execute();
            if ($stmt !== false) {
                return $iddetalle;
            } else {
                return 0;
            }
        } catch (\Throwable $th) {
            // echo $th->getMessage();
            return 0;
        }
    }

    public function listarDetallePlantilla($idplantilla)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT DP.id_detalle, 
                                        DP.id_catalogo,
                                        DP.minimo,
                                        DP.tarifa,
                                        DP.porcentaje,
                                        DP.por_peso,
                                        DP.por_volumen,
                                        DP.por_dia,
                                        C.nombre
                                    FROM plantilla_calculoa AS P INNER JOIN 
                                        detalle_plantillaa AS DP ON DP.id_plantilla = P.id_plantilla INNER JOIN 
			                            catalogo AS C ON C.id_catalogo = DP.id_catalogo
                                    WHERE P.id_plantilla =:idplantilla");
            $rsp->bindParam(":idplantilla", $idplantilla);
            $rsp->execute();
            $rsp = $rsp->fetchAll(PDO::FETCH_OBJ);
            if ($rsp) {
                return $rsp;
            } else {
                return $rsp = array();
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }
    public function mostrarDetalleP($iddetalle)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT DP.id_detalle, 
                                        DP.id_catalogo,
                                        DP.minimo,
                                        DP.tarifa,
                                        DP.porcentaje,
                                        DP.por_peso,
                                        DP.por_volumen,
                                        DP.por_dia
                                    FROM detalle_plantillaa AS DP 
                                    WHERE DP.id_detalle =:iddetalle ");
            $rsp->bindParam(":iddetalle", $iddetalle);
            $rsp->execute();
            $rsp = $rsp->fetch(PDO::FETCH_OBJ);
            if ($rsp) {
                return $rsp;
            } else {
                return $rsp = array();
            }
        } catch (\Throwable $th) {
            return 0;
        }  
    }
}
