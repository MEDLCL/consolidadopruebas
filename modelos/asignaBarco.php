<?php
session_start();
include_once "../config/Conexion.php";
class asignaBarco
{

    public function __construct()
    {
    }
    
    public function grabarBarco($idembarque,$idbarco,$viaje,$etd,$eta,$ceta,$etaNav,$completo,$piloto,$descarga,$liberado,$devuelto)
    {
        $etd= date("Y-m-d", strtotime($etd));
        $eta = date("Y-m-d", strtotime($eta));

        $con = Conexion::getConexion();
        try {
            $stmt = $con->prepare("UPDATE embarque_maritimo
                                    SET id_barco_llegada= :idbarco,
                                    viaje_llegada = :viaje,
                                    etd_op = :etd,
                                    eta_op = :eta
                                WHERE id_embarque_maritimo = :idembarque");
            $stmt->bindParam(":idbarco",$idbarco);
            $stmt->bindParam(":viaje",  $viaje);
            $stmt->bindParam(":etd", $etd);
            $stmt->bindParam(":eta", $eta);
            $stmt->bindParam(":idembarque", $idembarque);
            $stmt->execute();
            
            if ($ceta!= ""){
                $ceta = date("Y-m-d", strtotime($ceta));
                $stmt = $con->prepare("UPDATE embarque_maritimo 
                                        SET ceta_op = :ceta
                                        WHERE id_embarque_maritimo = :idembarque");
                $stmt->bindParam(":ceta",$ceta); 
                $stmt->bindParam(":idembarque",$idembarque); 
                $stmt->execute();                       
            }
            if ($etaNav!= ""){
                $etaNav = date("Y-m-d", strtotime($etaNav));
                $stmt = $con->prepare("UPDATE embarque_maritimo 
                                        SET eta_naviera_op = :etanav
                                        WHERE id_embarque_maritimo = :idembarque");
                $stmt->bindParam(":etanav",$etaNav); 
                $stmt->bindParam(":idembarque",$idembarque); 
                $stmt->execute();  
            }
            if ($completo!=""){
                $completo = date("Y-m-d", strtotime($completo));
                $stmt = $con->prepare("UPDATE embarque_maritimo 
                                        SET completo_op = :completo
                                        WHERE id_embarque_maritimo = :idembarque");
                $stmt->bindParam(":completo",$completo); 
                $stmt->bindParam(":idembarque",$idembarque); 
                $stmt->execute();  
            }
            if ($piloto!= ""){
                $piloto = date("Y-m-d", strtotime($piloto));
                $stmt = $con->prepare("UPDATE embarque_maritimo 
                                        SET piloto_op = :piloto
                                        WHERE id_embarque_maritimo = :idembarque");
                $stmt->bindParam(":piloto",$piloto); 
                $stmt->bindParam(":idembarque",$idembarque); 
                $stmt->execute();  
            }
            if($descarga!= ""){
                $descarga = date("Y-m-d", strtotime($descarga));
                $stmt = $con->prepare("UPDATE embarque_maritimo 
                                        SET descarga_op = :descarga
                                        WHERE id_embarque_maritimo = :idembarque");
                $stmt->bindParam(":descarga",$descarga); 
                $stmt->bindParam(":idembarque",$idembarque); 
                $stmt->execute();  
            }
            if ($liberado !=""){
                $liberado = date("Y-m-d", strtotime($liberado));
                $stmt = $con->prepare("UPDATE embarque_maritimo 
                                        SET liberado_op = :liberado
                                        WHERE id_embarque_maritimo = :idembarque");
                $stmt->bindParam(":liberado",$liberado); 
                $stmt->bindParam(":idembarque",$idembarque); 
                $stmt->execute();  
            }
            if ($devuelto!= ""){
                $devuelto = date("Y-m-d", strtotime($devuelto));
                $stmt = $con->prepare("UPDATE embarque_maritimo 
                                        SET devuelto_op = :devuelto
                                        WHERE id_embarque_maritimo = :idembarque");
                $stmt->bindParam(":devuelto",$devuelto); 
                $stmt->bindParam(":idembarque",$idembarque); 
                $stmt->execute();  
            }

            if ($stmt) {
                $json = array();
                $json['idembarque'] = $idembarque;
                $json['mensaje'] = "Barco y Fechas Ingresadas con exito";
                return $json;
            }
        } catch (\Throwable $th) {
            $json = array();
            $json['idembarque'] = 0;
            $json['mensaje'] = "No se pudo Ingresar Barco y Fechas";
            return $json;
        }
    }
}
