<?php
session_start();
include_once "../config/Conexion.php";
class plantillaA
{

    public function __construct()
    {
    }
    public function grabar($nombreP,$tarifaM,$diasL,$omitirD,$moneda)
    {
    
        $fechaG = date("Y-m-d");
        $con = Conexion::getConexion();
        try {
            $stmt = $con->prepare("INSERT INTO plantilla_calculoa(id_usuario,id_sucursal,nombre,tarifa_minima,dias_libres,omitir_almacenaje,moneda,fecha_grabacion)
            VALUES (:idusuario,:idsucursal,:nombre,:tarifa,:dlibres,:omitir,:moneda,:fecha)");
            $stmt->bindParam(":idusuario", $_SESSION['idusuario']);
            $stmt->bindParam(":idsucursal", $_SESSION["idsucursal"]);
            $stmt->bindParam(":nombre", $nombreP);
            $stmt->bindParam(":tarifa", $tarifaM);
            $stmt->bindParam(":dlibres", $diasL);
            $stmt->bindParam(":omitir", $omitirD);
            $stmt->bindParam(":moneda", $moneda);
            $stmt->bindParam(":fecha", $fechaG);
            $stmt->execute();

            if ($stmt) {
                return $con->lastInsertId();
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }
    public function editar($idplantilla, $nombreP,$tarifaM,$diasL,$omitirD,$moneda)
    {   
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("UPDATE plantilla_calculoa 
                    SET nombre=:nombre,
                        tarifa_minima=:tarifa,
                        dias_libres=:dlibres,
                        omitir_almacenaje=:omitir,
                        moneda =:moneda 
                    WHERE id_plantilla=:idplantilla");
            $rsp->bindParam(":nombre", $nombreP);
            $rsp->bindParam(":tarifa",$tarifaM);
            $rsp->bindParam(":dlibres",$diasL);
            $rsp->bindParam(":omitir",$omitirD);
            $rsp->bindParam(":moneda",$moneda);
            $rsp->bindParam(":idplantilla",$idplantilla);
            $rsp->execute();
            if ($rsp !== false){
                return $idplantilla;
            }else{
                return 0;
            }
            
        } catch (\Throwable $th) {
            return 0;
            //return $th->getMessage();
        }
    }
    public function mostrarPlantilla($idplantilla){
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT P.id_plantilla, 
                                        P.nombre, 
                                        P.tarifa_minima, 
                                        P.dias_libres, 
                                        P.omitir_almacenaje, 
                                        P.moneda,
                                        ifnull(M.signo,'')as signo
                                        FROM plantilla_calculoa  as P left join
                                            moneda as  M on M.id_moneda = P.moneda
                                    WHERE P.id_plantilla = :idplantilla 
                                            and P.id_sucursal = :idsucursal");
            $rsp->bindParam(":idplantilla",$idplantilla);
            $rsp->bindParam(":idsucursal",$_SESSION['idsucursal']);
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