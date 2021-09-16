<?php
session_start();
include_once "../config/Conexion.php";
class ciudad
{

    public function __construct()
    {
    }
    public function grabar($idpais, $nombre)
    {
        $con = Conexion::getConexion();
        try {
            $stmt = $con->prepare("INSERT INTO ciudad(id_pais,nombre)
            VALUES (:id_pais,:nombre)");
            $stmt->bindParam(":id_pais", $idpais);
            $stmt->bindParam(":nombre", $nombre);
            $stmt->execute();
            if ($stmt) {
                return $con->lastInsertId();
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }
    
    public function editar($idciudad, $nombre)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("UPDATE ciudad 
                    SET nombre=:nombre
                    WHERE id_ciudad=:id_ciudad");
            $rsp->bindParam(":nombre", $nombre);
            $rsp->bindParam(":id_ciudad", $idciudad);
            $rsp->execute();
            if ($rsp !== false) {
                return $idciudad;
            } else {
                return 0;
            }
        } catch (\Throwable $th) {
            return 0;
            //return $th->getMessage();
        }
    }
    public function mostrarCiudad($idciudad)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT c.nombre,
                                        c.id_ciudad
                                    FROM ciudad as c WHERE c.id_ciudad = :id_ciudad");
            $rsp->bindParam(":id_ciudad", $idciudad);
            $rsp->execute();
            $rsp = $rsp->fetch(PDO::FETCH_OBJ);
            if ($rsp) {
                return $rsp;
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }
}
