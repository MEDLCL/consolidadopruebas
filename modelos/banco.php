<?php
session_start();
include_once "../config/Conexion.php";
class banco
{

    public function __construct()
    {
    }

    /*-- `id_banco` INT NOT NULL AUTO_INCREMENT,
  `id_sucursal` INT NULL,
  `id_usuario` INT NULL,
  `nombre` VARCHAR(75) NULL,
  `ejecutivo` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `extension` VARCHAR(5) NULL,
  `correo` VARCHAR(75) NULL,
  `observaciones` VARCHAR(250) NULL, -->*/
    public function grabar($idbanco, $nombre, $ejecutivo, $telefono, $extension, $correo, $observaciones)

    {
        $con = Conexion::getConexion();
        try {
            $stmt = $con->prepare("INSERT INTO banco(id_sucursal, id_usuario ,nombre,ejecutivo,telefono,extension,correo,observaciones)
            VALUES (:idsucursal,:idusuario,:nombre,:ejecutivo,:telefono,:extension,:correo,:observaciones)");
            $stmt->bindParam(":idsucursal", $_SESSION['idsucursal']);
            $stmt->bindParam(":idusuario",  $_SESSION['idusuario']);
            $stmt->bindParam(":nombre", $nombre);
            $stmt->bindParam(":ejecutivo", $ejecutivo);
            $stmt->bindParam(":telefono", $telefono);
            $stmt->bindParam(":extension", $extension);
            $stmt->bindParam(":correo", $correo);
            $stmt->bindParam(":observaciones", $observaciones);
            $stmt->execute();
            if ($stmt) {
                $json = array();
                $json['idbanco'] = $con->lastInsertId();
                return $json;
            }
        } catch (\Throwable $th) {
            $json = array();
            $json['idbanco'] = 0;
            return $json;
        }
    }
    public function editar($idbanco, $nombre, $ejecutivo, $telefono, $extension, $correo, $observaciones)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("UPDATE banco 
                    SET nombre=:nombre,
                        ejecutivo=:ejecutivo,
                        telefono= :telefono,
                        extension = :extension,
                        correo = :correo,
                        observaciones= :observaciones
                    WHERE id_banco=:idbanco");
            $rsp->bindParam(":nombre", $nombre);
            $rsp->bindParam(":ejecutivo", $ejecutivo);
            $rsp->bindParam(":telefono", $telefono);
            $rsp->bindParam(":extension", $extension);
            $rsp->bindParam(":correo", $correo);
            $rsp->bindParam(":observaciones", $observaciones);

            $rsp->bindParam(":idbanco", $idbanco);
            $rsp->execute();
            if ($rsp !== false) {
                $json = array();
                $json['idbanco'] = $idbanco;
                $json['mensaje'] = "Datos Actualizados con exito";
                return $json;
            } else {
                $json = array();
                $json['idbanco'] = 0;
                $json['mensaje'] = "A ocurrido un Error";
                return $json;
            }
        } catch (\Throwable $th) {
            $json = array();
                $json['idbanco'] = 0;
                $json['mensaje'] = "A ocurrido un Error".$th->getMessage();
                return $json;
            //return $th->getMessage();
        }
    }
    public function mostrarBanco($idbanco){
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT B.id_banco,
                                    B.nombre,
                                    B.ejecutivo,
                                    B.telefono,
                                    B.extension,
                                    B.correo,
                                    B.observaciones
                                FROM banco AS B 
                                WHERE id_banco = :idbanco and id_sucursal = :idsucursal");
            $rsp->bindParam(":idbanco",$idbanco); 
            $rsp->bindParam(":idsucursal",$_SESSION['idsucursal']);                   
            $rsp->execute();
            $rsp = $rsp->fetch(PDO::FETCH_OBJ);
            if ($rsp) {
                return $rsp;
            } else {
                return 0;
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }
}
