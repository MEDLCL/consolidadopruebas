<?php
session_start();
include_once "../config/Conexion.php";
class cuentaBanco
{

    public function __construct()
    {
    }

    public function grabar($idbanco, $nombre, $numerocuenta, $idmoneda)

    {
        $con = Conexion::getConexion();
        try {

            $stmt = $con->prepare("INSERT INTO cuentabancaria(id_banco,nombre,numero_cuenta,id_moneda)
            VALUES (:idbanco,:nombre,:numero,:idmoneda)");
            $stmt->bindParam(":idbanco", $idbanco);
            $stmt->bindParam(":nombre", $nombre);
            $stmt->bindParam(":numero", $numerocuenta);
            $stmt->bindParam(":idmoneda", $idmoneda);

            $stmt->execute();
            if ($stmt) {
                $json = array();
                $json['idcuenta'] = $con->lastInsertId();
                $json['mensaje'] = "Cuenta Insertada con Exito";
                return $json;
            }
        } catch (\Throwable $th) {
            $json = array();
            $json['idcuenta'] = 0;
            $json['mensaje'] = "Error al insertar la cuenta " . $th->getMessage();
            return $json;
        }
    }
    public function editar($idcuenta, $nombre, $numerocuenta, $idmoneda)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("UPDATE cuentabancaria 
                    SET nombre=:nombre,
                        numero_cuenta=:numero,
                        id_moneda= :idmoneda
                    WHERE idcuenta_bancaria=:idcuenta");
            $rsp->bindParam(":nombre", $nombre);
            $rsp->bindParam(":numero", $numerocuenta);
            $rsp->bindParam(":idmoneda", $idmoneda);
            $rsp->bindParam(":idcuenta", $idcuenta);
            $rsp->execute();
            if ($rsp !== false) {
                $json = array();
                $json['idcuenta'] = $idcuenta;
                $json['mensaje'] = "Cuenta Actualizada con exito";
                return $json;
            } else {
                $json = array();
                $json['idcuenta'] = 0;
                $json['mensaje'] = "Error al actualizar cuenta ";
                return $json;
            }
        } catch (\Throwable $th) {
            $json = array();
            $json['idcuenta'] = 0;
            $json['mensaje'] = "Error al actualizar cuenta " . $th->getMessage();
            return $json;
            //return $th->getMessage();
        }
    }
    public function listarCuentas($idbanco)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT C.idcuenta_bancaria,
                                    C.nombre,
                                    C.numero_cuenta,
                                    M.signo
                                FROM cuentabancaria AS C INNER JOIN 
                                moneda AS M ON M.id_moneda = C.id_moneda
                                WHERE id_banco = :idbanco");
            $rsp->bindParam(":idbanco",$idbanco);                    
            $rsp->execute();
            $rsp = $rsp->fetchAll(PDO::FETCH_OBJ);
            if ($rsp) {
                return $rsp;
            } else {
                return array();
            }
        } catch (\Throwable $th) {
            return array();
        }
    }
    public function mostarCuenta($idcuenta)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT C.idcuenta_bancaria,
                                    C.nombre,
                                    C.numero_cuenta,
                                    M.signo,
                                    M.id_moneda
                                FROM cuentabancaria AS C INNER JOIN 
                                moneda AS M ON M.id_moneda = C.id_moneda
                                WHERE idcuenta_bancaria =:idcuenta ");
            $rsp->bindParam(":idcuenta", $idcuenta);
            $rsp->execute();
            $rsp = $rsp->fetch(PDO::FETCH_OBJ);
            if ($rsp) {
                return $rsp;
            } else {
                return array();
            }
        } catch (\Throwable $th) {
            return array();
        }   
    }
}
