<?php
session_start();
include_once "../config/Conexion.php";
class creaMaritimo
{

    public function __construct()
    {
    }
    public function grabar($cantClie, $idtipocarga, $idtiposervicio, $idcourier, $idbarco, $idagente, $idnavage, $viaje, $idpaisorigen, $idorigen, $idpaisdestino, $iddestino, $idusuarioA, $observaciones, $fechai, $contenedoresM, $tiposDoc, $ventasM, $clientesM, $orinales, $copias, $obserM, $numeroM)
    {
        $fechai = date("Y-m-d", strtotime($fechai));

        $con = Conexion::getConexion();
        $anio = date("Y", strtotime($fechai)); //date_format($fechai, "Y");
        $anio2 = date("y", strtotime($fechai)); //date_format($fechai, "y");
        $fechamodi = date("Y-m-d");
        $mes = date("m", strtotime($fechai)); //date($fechai, "m");
        $codigoEmbarque = '';
        $consecutivo = '';
        $codigoA = '';
        $cant = 0;
        $cntConsecutivo = 0;
        $inicialPaisD = '';
        $tipoEmbarque = 'M';
        $idembarque = 0;
        try {
            $con->beginTransaction();
            //traendo el contador del agente
            $rsp = $con->prepare("SELECT MAX(correlativo)as Cant FROM correlativoAgente WHERE  id_sucursal = :idsucursal AND id_agente = :idagente AND anio = :anio");
            $rsp->bindParam(":idsucursal", $_SESSION["idsucursal"]);
            $rsp->bindParam(":idagente", $idagente);
            $rsp->bindParam(":anio", $anio);
            $rsp->execute();
            $rsp = $rsp->fetch(PDO::FETCH_OBJ);

            $cant = $rsp->Cant;
            $cant = $cant + 1;

            //traendo el codigo del agente
            $rsp = $con->prepare("SELECT codigo  FROM empresas WHERE  id_empresa = :idempresa");
            $rsp->bindParam(":idempresa", $idagente);
            $rsp->execute();
            $rsp = $rsp->fetch(PDO::FETCH_OBJ);

            $codigoA = $rsp->codigo;

            //traendo consecutivo 
            $rsp = $con->prepare("SELECT MAX(contador) as contador  
                                        FROM consecutivos 
                                    WHERE  id_sucursal = :idsucursal AND mes = :mes 
                                            AND  anio = :anio");

            $rsp->bindParam(":idsucursal", $_SESSION["idsucursal"]);
            $rsp->bindParam(":mes", $mes);
            $rsp->bindParam(":anio", $anio);
            $rsp->execute();
            $rsp = $rsp->fetch(PDO::FETCH_OBJ);
            $cntConsecutivo = $rsp->contador;

            $cntConsecutivo = $cntConsecutivo + 1;
            $consecutivo = $mes . '.' . $cntConsecutivo . '.' . $anio2;
            //traendo iniciales pais destino 

            $rsp = $con->prepare("SELECT iniciales  FROM pais WHERE  idpais = :idpais");
            $rsp->bindParam(":idpais", $idpaisdestino);
            $rsp->execute();
            $rsp = $rsp->fetch(PDO::FETCH_OBJ);

            $inicialPaisD = $rsp->iniciales;

            $codigoEmbarque = $_SESSION["CodigoArea"] . '.' . $codigoA . '.' . $cant . '.' . $anio2 . '.' . $inicialPaisD;

            $rspt = $con->prepare("INSERT INTO embarque_maritimo (id_usuario,id_sucursal,id_tipo_carga,id_tipo_servicio,id_courier,id_barco,id_agente,id_nav_age,id_pais_origen,id_origen,id_pais_destino,id_destino,id_usuario_asignado,viaje,observaciones,fecha_modificacion,codigo,consecutivo,cant_clientes)
                            values(:idusuario,:idsucursal,:idtipocarga,:idtiposervicio,:idcourier,:idbarco,:idagente,:idnavage,:idpaisorigen,:idorigen,:idpaisdestino,:iddestino,:idusuarioasignado,:viaje,:observaciones,:fechamodificacion,:codigo,:consecutivo,:cantclientes)");
            $rspt->bindParam(":idusuario", $_SESSION['idusuario']);
            $rspt->bindParam(":idsucursal", $_SESSION['idsucursal']);
            $rspt->bindParam(":idtipocarga", $idtipocarga);
            $rspt->bindParam(":idtiposervicio", $idtiposervicio);
            $rspt->bindParam(":idcourier", $idcourier);
            $rspt->bindParam(":idbarco", $idbarco);
            $rspt->bindParam(":idagente", $idagente);
            $rspt->bindParam(":idnavage", $idnavage);
            $rspt->bindParam(":idpaisorigen", $idpaisorigen);
            $rspt->bindParam(":idorigen", $idorigen);
            $rspt->bindParam(":idpaisdestino", $idpaisdestino);
            $rspt->bindParam(":iddestino", $iddestino);
            $rspt->bindParam(":idusuarioasignado", $idusuarioA);
            $rspt->bindParam(":viaje", $viaje);
            $rspt->bindParam(":observaciones", $observaciones);
            $rspt->bindParam(":fechamodificacion", $fechamodi);
            $rspt->bindParam(":codigo", $codigoEmbarque);
            $rspt->bindParam(":consecutivo", $consecutivo);
            $rspt->bindParam(":cantclientes", $cantClie);
            $rspt->execute();

            if ($rspt) {
                $idembarque = $con->lastInsertId();
                $cont = 0;
                if (count($contenedoresM) > 0) {
                    $rspt = $con->prepare("INSERT INTO contenedor(numero,id_embarque)
                                            VALUES (:numero,:idembarque)");
                    // $contador = count($contenedoresM);
                    //echo $contador;
                    while ($cont < count($contenedoresM)) {
                        $rspt->bindParam(":numero", $contenedoresM[$cont]);
                        $rspt->bindParam(":idembarque", $idembarque);
                        $rspt->execute();
                        $cont++;
                    }
                }
                // tipos de documento ````
                if (count($tiposDoc) > 0) {
                    $contdoc = 0;
                    $rspt = $con->prepare("INSERT INTO documentos_embarque(numero,id_embarque,tipo_embarque,id_venta,cliente,original,copia,observaciones)
                    VALUES (:numero,:idembarque,:tipoE,:id_venta,:cliente,:original,:copia,:observaciones)");

                    while ($contdoc < count($tiposDoc)) {
                        $rspt->bindParam(":numero", $numeroM[$contdoc]);
                        $rspt->bindParam(":idembarque", $idembarque);
                        $rspt->bindParam(":tipoE", $tipoEmbarque);
                        $rspt->bindParam(":id_venta", $ventasM[$contdoc]);
                        $rspt->bindParam(":cliente", $clientesM[$contdoc]);

                        $rspt->bindParam(":original", $orinales[$contdoc]);
                        $rspt->bindParam(":copia", $copias[$contdoc]);
                        $rspt->bindParam(":observaciones", $obserM[$contdoc]);
                        $rspt->execute();
                        $contdoc++;
                    }
                }
                //numero de master bl
                if (count($tiposDoc) > 0) {
                    $contmbl = 0;
                    $rspt = $con->prepare("INSERT INTO masterbl(nombl,id_embarque)
                    VALUES (:numero,:idembarque)");

                    while ($contmbl < count($tiposDoc)) {
                        if ($tiposDoc[$contmbl] == 'MBL') {
                            $rspt->bindParam(":numero", $tiposDoc[$contmbl]);
                            $rspt->bindParam(":idembarque", $idembarque);
                            $rspt->execute();
                        }
                        $contmbl++;
                    }
                }
                //numeros de hbl 
                if (count($tiposDoc) > 0) {
                    $conthbl = 0;
                    $rspt = $con->prepare("INSERT INTO housebl(nohbl,id_embarque,id_venta,cliente)
                    VALUES (:numero,:idembarque,:idventa,:cliente)");

                    while ($conthbl < count($tiposDoc)) {
                        if ($tiposDoc[$conthbl] == 'HBL') {
                            $rspt->bindParam(":numero", $tiposDoc[$conthbl]);
                            $rspt->bindParam(":idembarque", $idembarque);
                            $rspt->bindParam(":idventa", $ventasM[$conthbl]);
                            $rspt->bindParam(":cliente", $clientesM[$conthbl]);
                            $rspt->execute();
                        }
                        $conthbl++;
                    }
                }

                //contador codigo embarque
                $rspt = $con->prepare("INSERT INTO correlativoagente(id_sucursal,id_agente,correlativo,anio)
                                        VALUES (:idsucursal,:idagente,:correlativo,:anio)");

                $rspt->bindParam(":idsucursal", $_SESSION["idsucursal"]);
                $rspt->bindParam(":idagente", $idagente);
                $rspt->bindParam(":correlativo", $cant);
                $rspt->bindParam(":correlativo", $cant);
                $rspt->bindParam(":anio", $anio);
                $rspt->execute();

                // consecutivos codigo embarque `id_sucursal````anio``contador`
                $rspt = $con->prepare("INSERT INTO consecutivos(id_sucursal,mes,anio,contador)
                                VALUES (:idsucursal,:mes,:anio,:contador)");
                $rspt->bindParam(":idsucursal", $_SESSION["idsucursal"]);
                $rspt->bindParam(":mes", $mes);
                $rspt->bindParam(":anio", $anio);
                $rspt->bindParam(":contador", $cntConsecutivo);
                $rspt->execute();


                // subir los archivos y crear el embarque 
            }
            $con->commit();
            //$con = Conexion::cerrar();
            $json = array();
            $json['idembarque'] = $idembarque;
            $json['codigo'] = $codigoEmbarque;
            $json['consecutivo'] = $consecutivo;
            return $json;
        } catch (\Throwable $th) {
            $con->rollBack();
            //$con = Conexion::cerrar();
            $json = array();
            $json['idembarque'] = 0;
        }
    }

    public function editarE($idembarque, $idtipocarga, $idbarco, $viaje,$idnavage,$idusuarioA)
    {
        //``````````
        $con = Conexion::getConexion();
        try {
            $con->beginTransaction();
            $rspt = $con->prepare("UPDATE embarque_maritimo SET
                                    id_tipo_carga=:id_tipo_carga,
                                    id_barco=:id_barco,
                                    id_nav_age=:id_nav_age,
                                    viaje=:viaje,
                                    telefono=:telefono
                                    WHERE id_embarque_maritimo = :id_embarque_maritimo");
            $rspt->bindParam(":id_tipo_carga", $idtipocarga);
            $rspt->bindParam(":id_barco", $idbarco);
            $rspt->bindParam(":id_nav_age", $idnavage);
            $rspt->bindParam(":viaje", $viaje);
            $rspt->bindParam(":id_usuario_asignado", $idusuarioA);
            $rspt->bindParam(":id_embarque_maritimo", $idembarque);
            $rspt->execute();
            $con->commit();
            //$con = Conexion::cerrar();
            $json = array();
            $json['idembarque'] = $idembarque;
            return $json;
        } catch (\Throwable $th) {
            $con->rollBack();
            //$con = Conexion::cerrar();
            $json = array();
            $json['idembarque'] = 0;
            return $json;
        }
    }

    public function buscaEmbarque($idembarque)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT  EM.id_embarque_maritimo as idembarque,
                                        EM.id_tipo_carga,
                                        EM.id_tipo_servicio,
                                        EM.id_courier,
                                        EM.id_barco,
                                        EM.id_agente,
                                        EM.id_nav_age,
                                        EM.id_pais_origen,
                                        EM.id_origen,
                                        EM.id_pais_destino,
                                        EM.id_destino,
                                        EM.id_usuario_asignado,
                                        EM.codigo,
                                        EM.consecutivo,
                                        EM.viaje,
                                        EM.observaciones,
                                        date_format(EM.fecha_ingreso,'%m/%d/%Y') as fechaingreso,
                                        EM.cant_clientes
                                    FROM embarque_maritimo as EM
                                        WHERE  id_embarque_maritimo = :idembarque");
            $rsp->bindParam(":idembarque", $idembarque);
            $rsp->execute();
            $rsp = $rsp->fetch(PDO::FETCH_OBJ);
            return $rsp;
        } catch (\Throwable $th) {
            return 0;
        }
    }

    public function listarEmbarque()
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("call prcListadoCreaMaritimo(:idsucursal);");
            $rsp->bindParam(":idsucursal", $_SESSION['idsucursal']);
            $rsp->execute();
            $rsp = $rsp->fetchAll(PDO::FETCH_OBJ);
            return $rsp;
        } catch (\Throwable $th) {
            return 0;
        }
    }
    //pendiente 
    public function listarCNTR($idempresa)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT * FROM contactos_e WHERE id_empresa= :idempresa");
            $rsp->bindParam(":idempresa", $idempresa);
            $rsp->execute();
            $rsp = $rsp->fetchAll(PDO::FETCH_OBJ);
            if ($rsp) {
                return $rsp;
            } else {
                return array();
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }
    //pendiente 
    public  function listarDocumentos($idembarque)
    {
        try {
            $con = Conexion::getConexion();
            $rspt = $con->prepare("DELETE FROM contactos_e WHERE id_contacto = :idcontacto");
            $rspt->bindParam(":idcontacto", $idcontacto);
            $rspt->execute();
            if ($rspt->rowCount() > 0) {
                return 1;
            } else {
                return 1;
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }
}
