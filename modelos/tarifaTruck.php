<?php
session_start();
include_once "../config/Conexion.php";
class tarifaTruck
{

    public function __construct()
    {
    }

    public function grabar($origenTarifa, $destinoTarifa, $tipoUnidadTarifa, $pilotoTarifa, $numeroayudantes, $validezTarifaFlete, $tipoCargaTarifa, $tarifaVentaFlete, $tarifaCostoFlete, $monedaTarifaFlete, $idproyecto)
    {
        $validezTarifaFlete  = date("Y-m-d", strtotime($validezTarifaFlete));
        $fechamod = date("Y-m-d");
        $con = Conexion::getConexion();
        try {

            $stmt = $con->prepare("INSERT INTO tarifariotruck(id_sucursal,id_usuario,origen,destino,id_tipo_unidad,id_piloto,ayudantes,tarifa_venta,tarifa_costo,id_proyecto,id_moneda,validez,id_tipo_carga,fechamodifica)
                            VALUES (:idsucursal,:idusuario,:origen,:destino,:idtipounidad,:idpiloto,:ayudantes,:tarifaventa,:tarifacosto,:idproyecto,:idmoneda,:validez,:idtipocarga,:fechamodifica)");
            $stmt->bindParam(":idsucursal", $_SESSION['idsucursal']);
            $stmt->bindParam(":idusuario", $_SESSION['idusuario']);
            $stmt->bindParam(":origen", $origenTarifa);
            $stmt->bindParam(":destino", $destinoTarifa);
            $stmt->bindParam(":idtipounidad", $tipoUnidadTarifa);
            $stmt->bindParam(":idpiloto", $pilotoTarifa);
            $stmt->bindParam(":ayudantes", $numeroayudantes);
            $stmt->bindParam(":tarifaventa", $tarifaVentaFlete);
            $stmt->bindParam(":tarifacosto", $tarifaCostoFlete);
            $stmt->bindParam(":idproyecto", $idproyecto);
            $stmt->bindParam(":idmoneda", $monedaTarifaFlete);
            $stmt->bindParam(":validez", $validezTarifaFlete);
            $stmt->bindParam(":idtipocarga", $tipoCargaTarifa);
            $stmt->bindParam(":fechamodifica", $fechamod);
            $stmt->execute();
            if ($stmt) {
                $json = array();
                $json['id_tarifario_truck'] = $con->lastInsertId();
                $json['mensaje'] = "Tarifa ingresada con Exito";
                return $json;
            }
        } catch (\Throwable $th) {
            $json = array();
            $json['id_tarifario_truck'] = 0;
            $json['mensaje'] = "Error al ingresar tarifa" . $th->getMessage();
            return $json;
        }
    }
    public function editar($origenTarifa, $destinoTarifa, $tipoUnidadTarifa, $pilotoTarifa, $numeroayudantes, $validezTarifaFlete, $tipoCargaTarifa, $tarifaVentaFlete, $tarifaCostoFlete, $monedaTarifaFlete, $idtarifarioflete)
    {
        $validezTarifaFlete  = date("Y-m-d", strtotime($validezTarifaFlete));
        $fechamod = date("Y-m-d");
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("UPDATE tarifariotruck
                                    SET origen=:origen, 
                                    destino=:destino, 
                                    id_tipo_unidad=:tipounidad, 
                                    id_piloto=:piloto, 
                                    ayudantes=:ayudantes, 
                                    tarifa_venta=:venta, 
                                    tarifa_costo=:costo, 
                                    id_moneda=:moneda, 
                                    validez=:validez, 
                                    fechamodifica=:fechamod,
                                    id_tipo_carga=:tipocarga
                                WHERE id_tarifario_truck=:idtarifaflete");

            $rsp->bindParam(":origen", $origenTarifa);
            $rsp->bindParam(":destino", $destinoTarifa);
            $rsp->bindParam(":tipounidad", $tipoUnidadTarifa);
            $rsp->bindParam(":piloto", $pilotoTarifa);
            $rsp->bindParam(":ayudantes", $numeroayudantes);
            $rsp->bindParam(":venta", $tarifaVentaFlete);
            $rsp->bindParam(":costo", $tarifaCostoFlete);
            $rsp->bindParam(":moneda", $monedaTarifaFlete);
            $rsp->bindParam(":validez", $validezTarifaFlete);
            $rsp->bindParam(":fechamod", $fechamod);
            $rsp->bindParam(":tipocarga", $tipoCargaTarifa);
            $rsp->bindParam(":idtarifaflete", $idtarifarioflete);

            $rsp->execute();
            if ($rsp !== false) {
                $json = array();
                $json['id_tarifario_truck'] = $idtarifarioflete;
                $json['mensaje'] = "Tarifa Actualizada con exito";
                return $json;
            } else {
                $json = array();
                $json['id_tarifario_truck'] = 0;
                $json['mensaje'] = "Error al actualizar Tarifa ";
                return $json;
            }
        } catch (\Throwable $th) {
            $json = array();
            $json['id_tarifario_truck'] = 0;
            $json['mensaje'] = "Error al actualizar Tarifa " . $th->getMessage();
            return $json;
            //return $th->getMessage();
        }
    }
    //listar y mostrar mov bancario corregir

    public function listarTarifaFlete($idtarifaflete)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT id_tarifario_truck, 
                                        origen, 
                                        destino, 
                                        id_tipo_unidad, 
                                        id_tipo_carga, 
                                        id_piloto, 
                                        ayudantes, 
                                        tarifa_venta, 
                                        tarifa_costo, 
                                        id_proyecto, 
                                        id_moneda, 
                                        date_format(validez,'%m/%d/%Y')as validez,
                                        id_sucursal, 
                                        id_usuario, 
                                        fechagraba, 
                                        fechamodifica
                                    FROM tarifariotruck
                                    WHERE id_tarifario_truck = :idtarifaflete");
            $rsp->bindParam(":idtarifaflete", $idtarifaflete);
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
    public function listarTarifasFlete($idproyecto)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT T.id_tarifario_truck, 
                                    T.origen, 
                                    T.destino, 
                                    TU.nombre  as unidad, 
                                    tce.nombre as tipocarga, 
                                    s2.nombre  as piloto, 
                                    T.ayudantes, 
                                    T.tarifa_venta, 
                                    T.tarifa_costo, 
                                    T.id_proyecto, 
                                    m2.signo as moneda, 
                                    date_format(T.validez,'%m/%d/%Y')as validez,
                                    T.id_sucursal, 
                                    T.id_usuario, 
                                    T.fechagraba, 
                                    T.fechamodifica
                                FROM almadisa.tarifariotruck as T inner join 
                                    tipo_unidades_truc as TU on TU.idtipo_unidades = T.id_tipo_unidad inner join 
                                    tipo_carga_empresa as tce on id_tipo_carga_empresa  = T.id_tipo_carga inner join 
                                    sino as s2 on s2.id_sino  = T.id_piloto inner join 
                                    moneda as m2 on m2.id_moneda  = T.id_moneda 
                                where T.id_proyecto = :idproyecto");
            $rsp->bindParam(":idproyecto", $idproyecto);
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

    //servcios tarifas
    public function grabarServicioTarifa($idproyecto,$idservicio,$idmonedaservicio,$origenservicio,$destinoservicio,$tarifaventa,$tarifacosto,$validezServicio){
        $fechamod = date("Y-m-d");
        $validezServicio  = date("Y-m-d", strtotime($validezServicio));
        $con = Conexion::getConexion();
        try {
            $stmt = $con->prepare("INSERT INTO tarifa_servicio(id_sucursal,id_usuario,id_proyecto,id_servicio,id_moneda,origen,destino,tarifa_venta,tarifa_costo,validez,fechamodifica)
                            VALUES (:idsucursal,:idusuario,:idproyecto,:idservicio,:idmoneda,:origen,:destino,:tarifaventa,:tarifacosto,:validez,:fechamodifica)");
            $stmt->bindParam(":idsucursal", $_SESSION['idsucursal']);
            $stmt->bindParam(":idusuario", $_SESSION['idusuario']);
            $stmt->bindParam(":idproyecto", $idproyecto);
            $stmt->bindParam(":idservicio", $idservicio);
            $stmt->bindParam(":idmoneda", $idmonedaservicio);
            $stmt->bindParam(":origen", $origenservicio);
            $stmt->bindParam(":destino", $destinoservicio);
            $stmt->bindParam(":tarifaventa", $tarifaventa);
            $stmt->bindParam(":tarifacosto", $tarifacosto);
            $stmt->bindParam(":validez", $validezServicio);
            $stmt->bindParam(":fechamodifica", $fechamod);
            $stmt->execute();
            if ($stmt) {
                $json = array();
                $json['idtarifaservicio'] = $con->lastInsertId();
                $json['mensaje'] = "Tarifa ingresada con Exito";
                return $json;
            }
        } catch (\Throwable $th) {
            $json = array();
            $json['idtarifaservicio'] = 0;
            $json['mensaje'] = "Error al ingresar Tarifa" . $th->getMessage();
            return $json;
        }
    }

    public function editarServicioTarifa($idtarifaservicio,$idservicio,$idmonedaservicio,$origenservicio,$destinoservicio,$tarifaventa,$tarifacosto,$validezServicio){
        $fechamod = date("Y-m-d");
        $validezServicio  = date("Y-m-d", strtotime($validezServicio));
        $con = Conexion::getConexion();
        try {

            $rsp = $con->prepare("UPDATE tarifa_servicio
                                    SET id_servicio=:idservicio, 
                                        id_moneda=:idmoneda, 
                                        origen=:origen, 
                                        destino=:destino, 
                                        tarifa_venta=:venta, 
                                        tarifa_costo=:costo, 
                                        validez=:validez,  
                                        fechamodifica=:fechamod
                                WHERE id_tarifa_servicio=:idtarifaservicio");

            $rsp->bindParam(":idservicio", $idservicio);
            $rsp->bindParam(":idmoneda", $idmonedaservicio);
            $rsp->bindParam(":origen", $origenservicio);
            $rsp->bindParam(":destino", $destinoservicio);
            $rsp->bindParam(":venta", $tarifaventa);
            $rsp->bindParam(":costo", $tarifacosto);
            $rsp->bindParam(":validez", $validezServicio);
            $rsp->bindParam(":fechamod", $fechamod);
            $rsp->bindParam(":idtarifaservicio", $idtarifaservicio);

            $rsp->execute();
            if ($rsp !== false) {
                $json = array();
                $json['idtarifaservicio'] = $idtarifaservicio;
                $json['mensaje'] = "Tarifa Actualizada con exito";
                return $json;
            } else {
                $json = array();
                $json['idtarifaservicio'] = 0;
                $json['mensaje'] = "Error al actualizar Tarifa ";
                return $json;
            }
        } catch (\Throwable $th) {
            $json = array();
            $json['idtarifaservicio'] = 0;
            $json['mensaje'] = "Error al actualizar Tarifa " . $th->getMessage();
            return $json;
            //return $th->getMessage();
        }
    }
    public function listarServicioFlete($idtarifaservicio)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT id_tarifa_servicio, 
                                        id_sucursal, 
                                        id_usuario, 
                                        id_proyecto, 
                                        id_servicio, 
                                        id_moneda, 
                                        origen, 
                                        destino, 
                                        tarifa_venta, 
                                        tarifa_costo, 
                                        date_format(validez,'%m/%d/%Y')as validez,
                                        fechagraba, 
                                        fechamodifica
                                    FROM tarifa_servicio
                                WHERE id_tarifa_servicio = :idtarifaservicio");
            $rsp->bindParam(":idtarifaservicio", $idtarifaservicio);
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
    public function listarServiciosFlete($idproyecto)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT TS.id_tarifa_servicio, 
                                    TS.id_sucursal, 
                                    TS.id_usuario, 
                                    TS.id_proyecto, 
                                    c.nombre AS servicio, 
                                    m.signo AS moneda, 
                                    TS.origen, 
                                    TS.destino, 
                                    TS.tarifa_venta,
                                    TS.tarifa_costo, 
                                    date_format(TS.validez,'%m/%d/%Y')as validez,
                                    TS.fechagraba, 
                                    TS.fechamodifica
                                FROM tarifa_servicio AS TS INNER JOIN  
                                        catalogo c  ON c.id_catalogo  = TS.id_servicio INNER JOIN 
                                        moneda m  ON m.id_moneda  = TS.id_moneda 
                                WHERE  TS.id_proyecto = :idproyecto");
            $rsp->bindParam(":idproyecto", $idproyecto);
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
}
