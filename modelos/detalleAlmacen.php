<?php
session_start();
include_once "../config/Conexion.php";

class detalleAlmacen
{

    public function __construct()
    {
    }
    public function grabar($idalmacen, $idcliente, $nohbl, $ubicacion, $peso, $volumen, $dut, $bultos, $embalajeD, $liberado, $resa, $dti, $ncancel, $norden, $mercaderia, $observaciones, $linea)
    {
        $fechaG = date("Y-m-d");
        $estado = 1;
        $con = Conexion::getConexion();
        try {
            $stmt = $con->prepare("INSERT INTO detalle_almacen(id_almacen, id_cliente,id_usuario,id_embalaje,peso,volumen,bultos, nohbl, estado, ubicacion, linea, resa, dti, no_cancel, no_orden, liberado, dut, mercaderia, observaciones, fecha_graba, fecha_modificacion, id_usuario_modifica)
                                VALUES (:idalmacen,:idcliente,:idusuario,:idembalaje,:peso,:volumen,:bultos,:nohbl,:estado,:ubicacion,:linea,:resa,:dti,:ncancel,:norden,:liberado,:dut,:mercaderia,:observaciones,:fechaG,:fechaM,:idusuarioM)");
            $stmt->bindParam(":idalmacen", $idalmacen);
            $stmt->bindParam(":idcliente", $idcliente);
            $stmt->bindParam(":idusuario", $_SESSION["idusuario"]);
            $stmt->bindParam(":idembalaje", $embalajeD);
            $stmt->bindParam(":peso", $peso);
            $stmt->bindParam(":volumen", $volumen);
            $stmt->bindParam(":bultos", $bultos);
            $stmt->bindParam(":nohbl", $nohbl);
            $stmt->bindParam(":peso", $peso);
            $stmt->bindParam(":volumen", $volumen);
            $stmt->bindParam(":bultos", $bultos);
            $stmt->bindParam(":estado", $estado);
            $stmt->bindParam(":ubicacion", $ubicacion);
            $stmt->bindParam(":linea", $linea);
            $stmt->bindParam(":resa", $resa);
            $stmt->bindParam(":dti", $dti);
            $stmt->bindParam(":ncancel", $ncancel);
            $stmt->bindParam(":norden", $norden);
            $stmt->bindParam(":liberado", $liberado);
            $stmt->bindParam(":dut", $dut);
            $stmt->bindParam(":mercaderia", $mercaderia);
            $stmt->bindParam(":observaciones", $observaciones);
            $stmt->bindParam(":fechaG", $fechaG);
            $stmt->bindParam(":fechaM", $fechaG);
            $stmt->bindParam(":idusuarioM", $_SESSION["idusuario"]);
            $stmt->execute();
            if ($stmt) {
                return $con->lastInsertId();
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }
    public function editarDAlmacen($iddetalleA, $idcliente, $nohbl, $ubicacion, $peso, $volumen, $dut, $bultos, $embalajeD, $liberado, $resa, $dti, $ncancel, $norden, $mercaderia, $observaciones, $linea)
    {
        $fechaM = date("Y-m-d");
       
        $con = Conexion::getConexion();
        try {
            $stmt = $con->prepare("UPDATE detalle_almacen 
                    SET id_cliente=:idcliente,
                        id_embalaje=:idembalaje,
                        peso=:peso,
                        volumen=:volumen,
                        bultos=:bultos,
                        nohbl=:nohbl,
                        ubicacion=:ubicacion,
                        linea=:linea,
                        resa=:resa,
                        dti=:dti,
                        no_cancel=:no_cancel,
                        no_orden=:no_orden,
                        liberado=:liberado,
                        dut=:dut,
                        mercaderia=:mercaderia,
                        observaciones=:observaciones,
                        fecha_modificacion=:fechaM,
                        id_usuario_modifica=:idusuarioM
                    WHERE id_detalle=:iddetallea");

    $stmt->bindParam(":idcliente", $idcliente);
    $stmt->bindParam(":idembalaje", $embalajeD);
    $stmt->bindParam(":peso",$peso );
    $stmt->bindParam(":volumen", $volumen);
    $stmt->bindParam(":bultos", $bultos);
    $stmt->bindParam(":nohbl", $nohbl);
    $stmt->bindParam(":ubicacion", $ubicacion);
    $stmt->bindParam(":linea", $linea);
    $stmt->bindParam(":resa", $resa);
    $stmt->bindParam(":dti", $dti);
    $stmt->bindParam(":no_cancel", $ncancel);
    $stmt->bindParam(":no_orden", $norden);
    $stmt->bindParam(":liberado", $liberado);
    $stmt->bindParam(":dut", $dut);
    $stmt->bindParam(":mercaderia", $mercaderia);
    $stmt->bindParam(":observaciones", $observaciones);
    $stmt->bindParam(":fechaM", $fechaM);
    $stmt->bindParam(":idusuarioM", $_SESSION["idusuario"]);
    $stmt->bindParam(":iddetallea", $iddetalleA);        
    $stmt->execute();
            if ($stmt !== false) {
                return $iddetalleA;
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
    public function muestraDAlmacen($iddetallea)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT DA.id_detalle, 
                                DA.id_almacen, 
                                DA.estado,
                                DA.id_cliente,  
                                DA.nohbl,
                                DA.peso, 
                                DA.volumen, 
                                DA.bultos,
                                DA.ubicacion, 
                                DA.id_embalaje, 
                                DA.dut,
                                DA.liberado,
                                DA.linea, 
                                DA.resa, 
                                DA.dti, 
                                DA.no_cancel, 
                                DA.no_orden, 
                                DA.mercaderia, 
                                DA.observaciones  
                            FROM detalle_almacen as DA
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
    public function anularDetalle($iddetalleA){
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("UPDATE detalle_almacen
                                SET estado = 0
                                WHERE id_detalle = :iddetalle ");
            $rsp->bindParam(":iddetalle",$iddetalleA);
            $rsp->execute();
            if ($rsp !== false) {
                return $iddetalleA;
            } else {
                return 0;
            }
        } catch (\Throwable $th) {
            return 0;
        }

    }
}
