<?php
session_start();
include_once "../config/Conexion.php";
class barco
{

    public function __construct()
    {
    }
    public function grabar($nombre, $bandera)
    {
        $con = Conexion::getConexion();
        try {
            $stmt = $con->prepare("INSERT INTO barco(nombre,bandera)
            VALUES (:nombre,:bandera)");
            $stmt->bindParam(":nombre", $nombre);
            $stmt->bindParam(":bandera", $bandera);
            $stmt->execute();
            if ($stmt) {
                return $con->lastInsertId();
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }
    public function editar($idbarco, $nombre, $bandera)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("UPDATE barco 
                    SET nombre=:nombre,
                        bandera=:bandera
                    WHERE id_barco=:idbarco");
            $rsp->bindParam(":nombre", $nombre);
            $rsp->bindParam(":bandera", $bandera);
            $rsp->bindParam(":idbarco", $idbarco);
            $rsp->execute();
            if ($rsp !== false) {
                return $idbarco;
            } else {
                return 0;
            }
        } catch (\Throwable $th) {
            return 0;
            //return $th->getMessage();
        }
    }
    public function mostarBarco($idbarco)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT b.nombre,
                                        b.bandera,
                                        b.id_barco
                                    FROM barco as b WHERE b.id_barco = :idbarco");
            $rsp->bindParam(":idbarco", $idbarco);
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
