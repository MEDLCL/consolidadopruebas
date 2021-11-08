<?php
session_start();
include_once "../config/Conexion.php";
class movBancario
{

    public function __construct()
    {
    }

    public function grabar($idbanco, $idcuenta, $idtipo, $monto, $comision, $fecha_operacion, $no_operacion, $beneficiario, $observaciones)
    {
        $fecha_operacion  = date("Y-m-d", strtotime($fecha_operacion));
        $con = Conexion::getConexion();
        try {
            $stmt = $con->prepare("INSERT INTO movimientobancario(id_banco,id_cuenta,id_sucursal,id_usuario,id_tipo_operacion,monto,comision,fecha_operacion,no_operacion,beneficiario,observaciones)
            VALUES (:idbanco,:idcuenta,:id_sucursal,:id_usuario,:id_tipo_operacion,:monto,:comision,:fecha_operacion,:no_operacion,:beneficiario,:observaciones)");
            $stmt->bindParam(":idbanco", $idbanco);
            $stmt->bindParam(":idcuenta", $idcuenta);
            $stmt->bindParam(":id_sucursal", $_SESSION['idsucursal']);
            $stmt->bindParam(":id_usuario", $_SESSION['idusuario']);
            $stmt->bindParam(":id_tipo_operacion", $idtipo);
            $stmt->bindParam(":monto", $monto);
            $stmt->bindParam(":comision", $comision);
            $stmt->bindParam(":fecha_operacion", $fecha_operacion);
            $stmt->bindParam(":no_operacion", $no_operacion);
            $stmt->bindParam(":beneficiario", $beneficiario);
            $stmt->bindParam(":observaciones", $observaciones);
            $stmt->execute();
            if ($stmt) {
                $json = array();
                $json['idmovimiento'] = $con->lastInsertId();
                $json['mensaje'] = "Operacion Insertada con Exito";
                return $json;
            }
        } catch (\Throwable $th) {
            $json = array();
            $json['idmovimiento'] = 0;
            $json['mensaje'] = "Error al insertar el Movimiento " . $th->getMessage();
            return $json;
        }
    }
    public function editar($idmovbancario, $idbanco, $idcuenta, $idoperacion, $fecha_operacion, $beneficiario, $observaciones)
    {
        $fecha_operacion  = date("Y-m-d", strtotime($fecha_operacion));
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("UPDATE movimientobancario 
                    SET id_banco=:id_banco,
                        id_cuenta=:id_cuenta,
                        id_tipo_operacion= :idoperacion,
                        fecha_operacion = :fechaoperacion,
                        beneficiario = :beneficiario,
                        observaciones= :observaciones
                    WHERE id_movimiento=:id_movimiento");

            $rsp->bindParam(":id_banco", $idbanco);
            $rsp->bindParam(":id_cuenta", $idcuenta);
            $rsp->bindParam(":idoperacion", $idoperacion);
            $rsp->bindParam(":fechaoperacion", $fecha_operacion);
            $rsp->bindParam(":beneficiario", $beneficiario);
            $rsp->bindParam(":observaciones", $observaciones);
            $rsp->bindParam(":id_movimiento", $idmovbancario);
            $rsp->execute();
            if ($rsp !== false) {
                $json = array();
                $json['idcuenta'] = $idcuenta;
                $json['mensaje'] = "Movimiento Actualizado con exito";
                return $json;
            } else {
                $json = array();
                $json['idcuenta'] = 0;
                $json['mensaje'] = "Error al actualizar Movimiento ";
                return $json;
            }
        } catch (\Throwable $th) {
            $json = array();
            $json['idcuenta'] = 0;
            $json['mensaje'] = "Error al actualizar Movimiento " . $th->getMessage();
            return $json;
            //return $th->getMessage();
        }
    }
    //listar y mostrar mov bancario corregir

    public function listarMovimientos()
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT  MB.id_movimiento,
                                    MB.id_banco,
                                    MB.id_cuenta,
                                    MB.id_sucursal,
                                    MB.id_usuario,
                                    MB.id_tipo_operacion,
                                    T.nombre AS operacion,
                                    B.nombre as Banco,
                                    concat (M.signo,' ',CC.numero_cuenta ) AS Cuenta, 
                                    MB.monto,
                                    MB.comision,
                                    MB.fecha_operacion,
                                    MB.no_operacion,
                                    MB.beneficiario,
                                    MB.observaciones,
                                    estado
                                FROM 
                                    movimientobancario as MB INNER JOIN 
                                    banco AS B ON B.id_banco = MB.id_banco INNER JOIN
                                    cuentabancaria AS CC ON CC.idcuenta_bancaria = MB.id_cuenta INNER JOIN 
                                    moneda  AS M ON M.id_moneda = CC.id_moneda INNER JOIN 
                                    tipo_operacion_bancos AS T ON T.id_tipo_operacion = MB.id_tipo_operacion
                                WHERE MB.id_sucursal = :idsucursal    
                                    ");
            $rsp->bindParam(":idsucursal", $_SESSION['idsucursal']);
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
    public function mostarCuenta($idmovbancario)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT    MB.id_movimiento,
                                            MB.id_banco,
                                            MB.id_cuenta,
                                            MB.id_sucursal,
                                            MB.id_usuario,
                                            MB.id_tipo_operacion,
                                            MB.monto,
                                            MB.comision,
                                            date_format(MB.fecha_operacion,'%m/%d/%Y') as fecha_operacion,
                                            MB.no_operacion,
                                            MB.beneficiario,
                                            MB.observaciones,
                                            estado
                        FROM 
                                movimientobancario as MB 
                        WHERE MB.id_movimiento = :idmovimiento");
            $rsp->bindParam(":idmovimiento", $idmovbancario);
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
    public function anular($idmovbancario)
    {
        $estado = 0 ;
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("UPDATE movimientobancario 
                    SET estado = :estado
                        
                    WHERE id_movimiento=:id_movimiento");
            $rsp->bindParam(":estado", $estado);
            $rsp->bindParam(":id_movimiento", $idmovbancario);
            $rsp->execute();
            if ($rsp !== false) {
                $json = array();
                $json['idmovbancario'] = $idmovbancario;
                $json['mensaje'] = "Movimiento Anulado con exito";
                return $json;
            } else {
                $json = array();
                $json['idmovbancario'] = 0;
                $json['mensaje'] = "Error al anular Movimiento ";
                return $json;
            }
        } catch (\Throwable $th) {
            $json = array();
            $json['idmovbancario'] = 0;
            $json['mensaje'] = "Error al anular Movimiento " . $th->getMessage();
            return $json;
            //return $th->getMessage();
        }
    }
}
