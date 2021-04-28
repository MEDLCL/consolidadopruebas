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

            $stmt = $con->prepare("UPDATE detalle_almacen 
                    SET id_catalogo=:idcliente,
                        minimo=:idembalaje,
                        tarifa=:peso,
                        porcentaje=:volumen,
                        por_peso=:bultos,
                        por_volumen=:nohbl,
                        por_dia=:ubicacion
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
    public function listar($idalmacen)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT DA.id_detalle, 
                                        DA.id_almacen, 
                                        DA.estado,
                                        CL.Razons as cliente,  
                                        DA.nohbl,
                                        DA.peso, 
                                        DA.volumen, 
                                        DA.bultos,
                                        DA.ubicacion, 
                                        E.nombre as empaque, 
                                        DA.dut,
                                        DA.liberado,
                                        DA.linea, 
                                        DA.resa, 
                                        DA.dti, 
                                        DA.no_cancel, 
                                        DA.no_orden, 
                                        DA.mercaderia, 
                                        DA.observaciones
                                    FROM detalle_almacen AS DA INNER JOIN  
                                    empaque AS E ON E.id_empaque = DA.id_embalaje INNER JOIN 
                                    empresas AS CL ON CL.id_empresa = DA.id_cliente 
                                WHERE id_almacen = :idalmacen");
            $rsp->bindParam(":idalmacen", $idalmacen);
            $rsp->execute();
            $rsp = $rsp->fetchAll(PDO::FETCH_OBJ);
            return $rsp;
            $con = Conexion::cerrar();
        } catch (\Throwable $th) {
            //throw $th;
        }
    }
    public function MostrarNuevoCalculo($iddetallea)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT 
                                    DA.id_detalle, 
                                    DA.id_cliente,  
                                    DA.peso, 
                                    DA.volumen, 
                                    DA.bultos,
                                    DA.dut,
                                    DA.liberado,
                                    A.poliza,
                                    A.cant_clientes,
                                    DATE_FORMAT(A.fecha_almacen, '%m/%d/%Y') as fechaI
                            FROM detalle_almacen as DA INNER JOIN 
                                almacen as A ON A.id_almacen = DA.id_almacen
                        where DA.id_detalle = :id_detalle");
            $rsp->bindParam(":id_detalle", $iddetallea);
            $rsp->execute();
            $rsp = $rsp->fetch(PDO::FETCH_OBJ);
            if ($rsp) {
                return $rsp;
            }
        } catch (\Throwable $th) {
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
            }
            else {
                return $rsp = array();
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }
}
