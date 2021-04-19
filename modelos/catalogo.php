<?php
session_start();
include_once "../config/Conexion.php";
class catalogo
{

    public function __construct()
    {
    }
    public function grabar($nombreDescripcion, $nombreDescripcionIngles, $codigo)
    {

        $fechaG = date("Y-m-d");
        $con = Conexion::getConexion();
        try {
            $stmt = $con->prepare("INSERT INTO catalogo(id_usuario,id_sucursal,nombre,nombre_ingles,codigo,fecha_graba)
            VALUES (:idusuario,:idsucursal,:nombre,:traduccion,:codigo,:fecha)");
            $stmt->bindParam(":idusuario", $_SESSION['idusuario']);
            $stmt->bindParam(":idsucursal", $_SESSION["idsucursal"]);
            $stmt->bindParam(":nombre", $nombreDescripcion);
            $stmt->bindParam(":traduccion", $nombreDescripcionIngles);
            $stmt->bindParam(":codigo", $codigo);
            $stmt->bindParam(":fecha", $fechaG);
            $stmt->execute();

            if ($stmt) {
                return $con->lastInsertId();
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }
    public function editar($idcatalogo, $nombreDescripcion, $nombreDescripcionIngles,$codigo)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("UPDATE catalogo 
                    SET nombre=:nombre,
                        nombre_ingles=:traduccion,
                        codigo=:codigo 
                    WHERE id_catalogo=:idcatalogo");
            $rsp->bindParam(":nombre", $nombreDescripcion);
            $rsp->bindParam(":traduccion", $nombreDescripcionIngles);
            $rsp->bindParam(":codigo", $codigo);
            $rsp->bindParam(":idcatalogo", $idcatalogo);
            $rsp->execute();
            if ($rsp !== false) {
                return $idcatalogo;
            } else {
                return 0;
            }
        } catch (\Throwable $th) {
            return 0;
            //return $th->getMessage();
        }
    }
    public function mostrarCatalogo($idcatalogo)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT C.id_catalogo, 
                                        C.id_usuario,
                                        C.id_sucursal, 
                                        C.nombre, 
                                        C.nombre_ingles,
                                        IFNULL(C.codigo,'') as codigo, 
                                        C.fecha_graba 
                                    FROM catalogo as C WHERE C.id_catalogo = :idcatalogo");
            $rsp->bindParam(":idcatalogo", $idcatalogo);
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
