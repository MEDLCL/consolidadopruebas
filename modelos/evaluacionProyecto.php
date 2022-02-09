<?php
session_start();
include_once "../config/Conexion.php";
class evaluacionProyecto
{

    public function __construct()
    {
    }

    public function grabar()
    {
        $con = Conexion::getConexion();
        $cant = 0;
        try {

            $con->beginTransaction();
            $rsp = $con->prepare("SELECT MAX(correlativo)as Cant FROM correlativo_proyecto WHERE id_sucursal = :idsucursal");
            $rsp->bindParam(":idsucursal", $_SESSION['idsucursal']);
            $rsp->execute();
            $rsp = $rsp->fetch(PDO::FETCH_OBJ);

            $cant = $rsp->Cant;
            $cant = $cant + 1;
            $estado = 1;

            $stmt = $con->prepare("INSERT INTO correlativo_proyecto(id_sucursal,correlativo)
            VALUES (:idsucursal,:correlativo)");

            $stmt->bindParam(":idsucursal", $_SESSION['idsucursal']);
            $stmt->bindParam(":correlativo", $cant);
            $stmt->execute();

            $stmt = $con->prepare("INSERT INTO evaluacion_proyecto(id_sucursal,codigo,estado)
            VALUES (:idsucursal,:codigo,:estado)");
            $stmt->bindParam(":idsucursal", $_SESSION['idsucursal']);
            $stmt->bindParam(":codigo", $cant);
            $stmt->bindParam(":estado", $estado);
            $stmt->execute();

            if ($stmt) {
                $json = array();
                $json['id_evaluacion_proyecto'] = $con->lastInsertId();
                $json['codigo'] = $cant;
                $json['mensaje'] = "Operacion Insertada con Exito";
            }
            $con->commit();
            return $json;
        } catch (\Throwable $th) {
            $json = array();
            $json['id_evaluacion_proyecto'] = 0;
            $json['mensaje'] = "Error al insertar el Movimiento " . $th->getMessage();
            return $json;
        }
    }
    public function editar($idproyecto, $codigoProyecto, $idcliente, $fechaInicio, $fechaFinal, $tipocargaProyecto, $fianzaProyecto, $pesopromedio, $unidadMedida, $piesCubico, $mercaderia, $permisos, $entregasPromedio, $kilometrosPromedio, $frecuenciaViajes, $seCargaPro, $seDescargaPro, $manejoEfectivoPro)
    {
        $fechamod = date("Y-m-d");
        $codigo = "CT" . $idcliente . "P" . $codigoProyecto;
        $fechaInicio = date("Y-m-d", strtotime($fechaInicio));
        $fechaFinal = date("Y-m-d", strtotime($fechaFinal));

        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("UPDATE evaluacion_proyecto 
                                    SET id_cliente =:idcliente,
                                        codigo=:codigo,
                                        fechainicio=:fechainicio,
                                        fechafinal=:fechafinal,
                                        id_tipo_carga=:idtipocarga,
                                        id_fianza=:idfianza,
                                        peso=:peso,
                                        id_unidad_media=:idunidadmedia,
                                        pies_cubicos=:piescubicos,
                                        descripcion_mercaderia=:mercaderia,
                                        permisos=:permisos,
                                        entregas=:entregas,
                                        recorrido=:recorrido,
                                        frecuencua=:frecuencua,
                                        id_sercarga=:idsercarga,
                                        id_serdescarga=:idserdescarga,
                                        id_efectivo=:idefectivo,
                                        fechamodifica:= fechamodifica
                                WHERE id_evaluacion_proyecto=:idproyecto");

            $rsp->bindParam(":idcliente", $idcliente);
            $rsp->bindParam(":codigo", $codigo);
            $rsp->bindParam(":fechainicio", $fechaInicio);
            $rsp->bindParam(":fechafinal", $fechaFinal);
            $rsp->bindParam(":idtipocarga", $tipocargaProyecto);
            $rsp->bindParam(":idfianza", $fianzaProyecto);
            $rsp->bindParam(":peso", $pesopromedio);
            $rsp->bindParam(":idunidadmedia", $unidadMedida);
            $rsp->bindParam(":piescubicos", $piesCubico);
            $rsp->bindParam(":mercaderia", $mercaderia);
            $rsp->bindParam(":permisos", $permisos);

            $rsp->bindParam(":entregas", $entregasPromedio);
            $rsp->bindParam(":recorrido", $kilometrosPromedio);
            $rsp->bindParam(":frecuencua", $frecuenciaViajes);
            $rsp->bindParam(":idsercarga", $seCargaPro);
            $rsp->bindParam(":idserdescarga", $seDescargaPro);
            $rsp->bindParam(":idefectivo", $manejoEfectivoPro);
            $rsp->bindParam(":fechamodifica", $fechamod);

            $rsp->bindParam(":idproyecto", $idproyecto);
            $rsp->execute();
            if ($rsp !== false) {
                $json = array();
                $json['id_evaluacion_proyecto'] = $idproyecto;
                $json['mensaje'] = "Evaluacion ingresada con exito";
                return $json;
            } else {
                $json = array();
                $json['id_evaluacion_proyecto'] = 0;
                $json['mensaje'] = "Error encontrado";
                return $json;
            }
        } catch (\Throwable $th) {
            $json = array();
            $json['id_evaluacion_proyecto'] = 0;
            $json['mensaje'] = "Error encontrado " . $th->getMessage();
            return $json;
            //return $th->getMessage();
        }
    }

    public function listarProyectos()
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT PR.id_evaluacion_proyecto as idproyecto, 
                                    PR.id_sucursal, 
                                    PR.codigo, 
                                    PR.id_cliente,
                                    date_format(PR.fechainicio,'%m/%d/%Y')as fechainicio,
                                    date_format(PR.fechafinal,'%m/%d/%Y')as fechafinal,
                                    PR.id_tipo_carga, 
                                    PR.id_fianza, 
                                    PR.peso, 
                                    PR.id_unidad_media, 
                                    PR.pies_cubicos, 
                                    PR.descripcion_mercaderia, 
                                    PR.permisos, 
                                    PR.entregas, 
                                    PR.recorrido, 
                                    PR.frecuencua, 
                                    PR.id_sercarga, 
                                    PR.id_serdescarga, 
                                    PR.id_efectivo,
                                    e.Razons as cliente,
                                    F.nombre  as Fianza,
                                    tce.nombre as tipocarga,
                                    um.nombre as Unidad,
                                    SC.nombre  as secarga,
                                    SC.nombre  as sedescarga,
                                    SC.nombre as efectivo
                                FROM evaluacion_proyecto as PR inner join 
                                        empresas e  on e.id_empresa = Pr.id_cliente inner join 
                                        tipo_carga_empresa tce on id_tipo_carga_empresa = Pr.id_tipo_carga inner join 
                                        sino F on F.id_sino  = PR.id_fianza inner join 
                                        unidad_medida um on id_unidad_medida  = PR.id_unidad_media left join 
                                        sino SC on SC.id_sino  = PR.id_sercarga left join 
                                        sino SD on SD.id_sino  = PR.id_serdescarga left  join 
                                        sino as ME on ME.id_sino  = PR.id_efectivo 
                                    where PR.estado = 1;");
            $rsp->execute();
            $rsp = $rsp->fetchALL(PDO::FETCH_OBJ);
            if ($rsp) {
                return $rsp;
            } else {
                return array();
            }
        } catch (\Throwable $th) {
            return array();
        }
    }
public function listarProyecto($idproyecto){
    $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT PR.id_evaluacion_proyecto as idproyecto, 
                                    PR.id_sucursal, 
                                    PR.codigo, 
                                    PR.id_cliente,
                                    date_format(PR.fechainicio,'%m/%d/%Y')as fechainicio,
                                    date_format(PR.fechafinal,'%m/%d/%Y')as fechafinal,
                                    PR.id_tipo_carga, 
                                    PR.id_fianza, 
                                    PR.peso, 
                                    PR.id_unidad_media, 
                                    PR.pies_cubicos, 
                                    PR.descripcion_mercaderia, 
                                    PR.permisos, 
                                    PR.entregas, 
                                    PR.recorrido, 
                                    PR.frecuencua, 
                                    PR.id_sercarga, 
                                    PR.id_serdescarga, 
                                    PR.id_efectivo
                                FROM evaluacion_proyecto as PR
                                    where PR.id_evaluacion_proyecto = :idproyecto");
            $rsp->bindParam(":idproyecto",$idproyecto);
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
    public function grabarUnidades($idproyecto, $cantUnidad, $tipoUnida, $tipoEquipo, $temperatura, $caracEquipo, $seguridad, $marchamo, $gps, $lugarCargaPro, $lugarDescargaPro, $canalDistribucionPro)
    {
        $con = Conexion::getConexion();

        try {

            $con->beginTransaction();

            $stmt = $con->prepare("INSERT INTO asigna_unidad_proyecto(id_proyecto,cantidad_unidad,id_tipo_unidad,id_tipo_equipo,temperatura,especificacion,id_seguridad,id_marchamo,id_gps,lugar_carga,lugar_descarga,id_canal_distribucion)
            VALUES (:idproyecto,:cantidadunidad,:idtipounidad,:idtipoequipo,:temperatura,:especificacion,:idseguridad,:idmarchamo,:idgps,:lugarcarga,:lugardescarga,:idcanaldistribucion)");
            $stmt->bindParam(":idproyecto", $idproyecto);
            $stmt->bindParam(":cantidadunidad", $cantUnidad);
            $stmt->bindParam(":idtipounidad", $tipoUnida);
            $stmt->bindParam(":idtipoequipo", $tipoEquipo);
            $stmt->bindParam(":temperatura", $temperatura);
            $stmt->bindParam(":especificacion", $caracEquipo);

            $stmt->bindParam(":idseguridad", $seguridad);

            $stmt->bindParam(":idmarchamo", $marchamo);

            $stmt->bindParam(":idgps", $gps);

            $stmt->bindParam(":lugarcarga", $lugarCargaPro);
            $stmt->bindParam(":lugardescarga", $lugarDescargaPro);
            $stmt->bindParam(":idcanaldistribucion", $canalDistribucionPro);

            $stmt->execute();

            if ($stmt) {
                $json = array();
                $json['idunidadasingada'] = $con->lastInsertId();
                $json['mensaje'] = "Operacion Insertada con Exito";
            }
            $con->commit();
            return $json;
        } catch (\Throwable $th) {
            $json = array();
            $json['idunidadasingada'] = 0;
            $json['mensaje'] = "Error al insertar el Unidad " . $th->getMessage();
            return $json;
        }
    }
    function editarUnidad($idtipounidadtransporte, $cantUnidad, $tipoUnida, $tipoEquipo, $temperatura, $caracEquipo, $seguridad, $marchamo, $gps, $lugarCargaPro, $lugarDescargaPro, $canalDistribucionPro)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("UPDATE asigna_unidad_proyecto 
                                    SET 
                                        id_tipo_unidad=:tipounidad,
                                        id_tipo_equipo=:tipoequipo,
                                        cantidad_unidad= :cantunidad,
                                        temperatura=:temperatura,
                                        especificacion=:especificacion,
                                        id_seguridad=:seguridad,
                                        id_marchamo=:marchamo,
                                        id_gps=:gps,
                                        lugar_carga=:lugarcarga,
                                        lugar_descarga=:lugardescarga,
                                        id_canal_distribucion=:canaldistribucion
                    WHERE id_asigna_unidad=:idasignaunidad");

            $rsp->bindParam(":tipounidad", $tipoUnida);
            $rsp->bindParam(":tipoequipo", $tipoEquipo);
            $rsp->bindParam(":cantunidad", $cantUnidad);
            $rsp->bindParam(":temperatura", $temperatura);
            $rsp->bindParam(":especificacion", $caracEquipo);
            $rsp->bindParam(":seguridad", $seguridad);
            $rsp->bindParam(":marchamo", $marchamo);
            $rsp->bindParam(":gps", $gps);
            $rsp->bindParam(":lugarcarga", $lugarCargaPro);
            $rsp->bindParam(":lugardescarga", $lugarDescargaPro);
            $rsp->bindParam(":canaldistribucion", $canalDistribucionPro);
            $rsp->bindParam(":idasignaunidad", $idtipounidadtransporte);

            $rsp->execute();
            if ($rsp !== false) {
                $json = array();
                $json['idunidadasingada'] = $idtipounidadtransporte;
                $json['mensaje'] = "Unidad Actualizado con exito";
                return $json;
            } else {
                $json = array();
                $json['idunidadasingada'] = 0;
                $json['mensaje'] = "Error al actualizar Unidad ";
                return $json;
            }
        } catch (\Throwable $th) {
            $json = array();
            $json['idcuenta'] = 0;
            $json['mensaje'] = "Error al actualizar Unidad " . $th->getMessage();
            return $json;
            //return $th->getMessage();
        }
    }
    //listar y mostrar mov bancario corregir

    public function listaUnidad($iasinaunidad)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT  AU.id_asigna_unidad,
                                        AU.id_proyecto,
                                        AU.id_tipo_unidad,
                                        AU.id_tipo_equipo,
                                        AU.cantidad_unidad,
                                        AU.temperatura,
                                        AU.especificacion,
                                        AU.id_seguridad,
                                        AU.id_marchamo,
                                        AU.id_gps,
                                        AU.lugar_carga,
                                        AU.lugar_descarga,
                                        AU.id_canal_distribucion
                                    FROM 
                                        asigna_unidad_proyecto as AU
                                    WHERE AU.id_asigna_unidad = :idasigna");
            $rsp->bindParam(":idasigna", $iasinaunidad);
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
    public function listarUnidades($idproyecto)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT  AU.id_asigna_unidad,
                                        AU.id_proyecto,
                                        TU.nombre as unidad,
                                        TE.nombre as Equipo,
                                        AU.cantidad_unidad,
                                        AU.temperatura,
                                        AU.especificacion,
                                        S.nombre as seguridad,
                                        M.nombre as marchamo,
                                        G.nombre as gps,
                                        AU.lugar_carga,
                                        AU.lugar_descarga,
                                        CD.nombre as canal_distrbucion
                                    FROM asigna_unidad_proyecto as AU inner join 
                                        tipo_unidades_truc as TU on TU.idtipo_unidades = AU.id_tipo_unidad inner join 
                                        tipo_equipo_truc  as TE on TE.idtipo_equipo_truc = AU.id_tipo_equipo inner join 
                                        sino  as S on S.id_sino = AU.id_seguridad inner join 
                                        sino as M on M.id_sino = AU.id_marchamo inner join 
                                        sino as G on G.id_sino = AU.id_gps inner join 
                                        canal_distribucion as CD on CD.id_canal_distribucion = AU.id_canal_distribucion
                                    WHERE AU.id_proyecto = :idproyecto");
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
    //tarifas target
    public function grabarTarifaTarget($idproyecto, $tipounidadTarget, $fianzaTarget, $lugarCargaTarget, $lugardescargaTarget)
    {
        $con = Conexion::getConexion();

        try {

            $con->beginTransaction();

            $stmt = $con->prepare("INSERT INTO tarifa_target_proyecto(id_proyecto,id_tipo_unidad,id_fianza,lugar_carga,lugar_descarga)
            VALUES (:idproyecto,:idtipounidad,:id_fianza,:lugarcarga,:lugardescarga)");
            $stmt->bindParam(":idproyecto", $idproyecto);
            $stmt->bindParam(":idtipounidad", $tipounidadTarget);
            $stmt->bindParam(":id_fianza", $fianzaTarget);
            $stmt->bindParam(":lugarcarga", $lugarCargaTarget);
            $stmt->bindParam(":lugardescarga", $lugardescargaTarget);

            $stmt->execute();

            if ($stmt) {
                $json = array();
                $json['idtarifa_target'] = $con->lastInsertId();
                $json['mensaje'] = "Tarifa Insertada con Exito";
            }
            $con->commit();
            return $json;
        } catch (\Throwable $th) {
            $json = array();
            $json['idtarifa_target'] = 0;
            $json['mensaje'] = "Error al insertar el Tarifa " . $th->getMessage();
            return $json;
        }
    }
    public function editarTarifaTarget($idtarifa_target, $tipounidadTarget, $fianzaTarget, $lugarCargaTarget, $lugardescargaTarget)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("UPDATE tarifa_target_proyecto 
                                    SET 
                                        id_tipo_unidad=:tipounidad,
                                        id_fianza=:idfianza,
                                        lugar_carga= :lugarcarga,
                                        lugar_descarga=:lugardescarga
                    WHERE idtarifa_target=:idtarifatarget");

            $rsp->bindParam(":tipounidad", $tipounidadTarget);
            $rsp->bindParam(":idfianza", $fianzaTarget);
            $rsp->bindParam(":lugarcarga", $lugarCargaTarget);
            $rsp->bindParam(":lugardescarga", $lugardescargaTarget);
            $rsp->bindParam(":idtarifatarget", $idtarifa_target);
            $rsp->execute();
            if ($rsp !== false) {
                $json = array();
                $json['idtarifa_target'] = $idtarifa_target;
                $json['mensaje'] = "Tarifa Actualizado con exito";
                return $json;
            } else {
                $json = array();
                $json['idtarifa_target'] = 0;
                $json['mensaje'] = "Error al actualizar Tarifa ";
                return $json;
            }
        } catch (\Throwable $th) {
            $json = array();
            $json['idtarifa_target'] = 0;
            $json['mensaje'] = "Error al actualizar Tarifa " . $th->getMessage();
            return $json;
            //return $th->getMessage();
        }
    }
    public function listarTarifaTarget($idtarifa)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT  TT.idtarifa_target,
                                    TT.id_tipo_unidad,
                                    TT.id_proyecto,
                                    TT.id_fianza,
                                    TT.lugar_carga,
                                    TT.lugar_descarga
                                FROM tarifa_target_proyecto as TT
                                WHERE TT.idtarifa_target  = :idtarifatarget");
            $rsp->bindParam(":idtarifatarget", $idtarifa);
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

    public function listarTarifasTarget($idproyecto)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT  TT.idtarifa_target,
                                    TU.nombre as unidad,
                                    TT.id_proyecto,
                                    F.nombre as fianza,
                                    TT.lugar_carga,
                                    TT.lugar_descarga
                                FROM tarifa_target_proyecto as TT INNER JOIN  
                                        tipo_unidades_truc as TU on TU.idtipo_unidades = TT.id_tipo_unidad INNER JOIN 
                                        sino as F on F.id_sino = TT.id_fianza
                                WHERE TT.id_proyecto = :idproyecto");
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

    public function grabaServicoTarget($idproyecto, $idservicio, $lugarcargaservicio, $lugardescargarservicio)
    {
        $con = Conexion::getConexion();
        try {
            $con->beginTransaction();
            $stmt = $con->prepare("INSERT INTO servicio_target(id_proyecto,id_servicio,lugar_carga,lugar_descarga)
            VALUES (:idproyecto,:idservicio,:lugarcarga,:lugardescarga)");
            $stmt->bindParam(":idproyecto", $idproyecto);
            $stmt->bindParam(":idservicio", $idservicio);
            $stmt->bindParam(":lugarcarga", $lugarcargaservicio);
            $stmt->bindParam(":lugardescarga", $lugardescargarservicio);

            $stmt->execute();
            if ($stmt) {
                $json = array();
                $json['id_servicio_target'] = $con->lastInsertId();
                $json['mensaje'] = "Servicio Insertado con Exito";
            }
            $con->commit();
            return $json;
        } catch (\Throwable $th) {
            $json = array();
            $json['id_servicio_target'] = 0;
            $json['mensaje'] = "Error al insertar el Servicio " . $th->getMessage();
            return $json;
        }
    }

    public function editaServicioTarget($idserviciotarget, $idservicio, $lugarcargaservicio, $lugardescargarservicio)
    {
        $con = Conexion::getConexion();
        try {

            $rsp = $con->prepare("UPDATE servicio_target 
                                    SET 
                                        id_servicio=:idservicio,
                                        lugar_carga=:lugarcarga,
                                        lugar_descarga= :lugardescarga,
                    WHERE id_servicio_target=:idserviciotarget");

            $rsp->bindParam(":idservicio", $idservicio);
            $rsp->bindParam(":lugarcarga", $lugarcargaservicio);
            $rsp->bindParam(":lugardescarga", $lugardescargarservicio);
            $rsp->bindParam(":idserviciotarget", $idserviciotarget);
            $rsp->execute();
            if ($rsp !== false) {
                $json = array();
                $json['id_servicio_target'] = $idserviciotarget;
                $json['mensaje'] = "Servicio Actualizado con exito";
                return $json;
            } else {
                $json = array();
                $json['id_servicio_target'] = 0;
                $json['mensaje'] = "Error al actualizar Servicio ";
                return $json;
            }
        } catch (\Throwable $th) {
            $json = array();
            $json['id_servicio_target'] = 0;
            $json['mensaje'] = "Error al actualizar Servicio " . $th->getMessage();
            return $json;
            //return $th->getMessage();
        }
    }
    public function listarServicioTarget($idserviciotarget)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT id_servicio_target
                                    id_servicio
                                    id_proyecto
                                    lugar_carga
                                    lugar_descarga    
                                FROM servicio_target WHERE id_servicio_target=:idserviciotarget");
            $rsp->bindParam(":idserviciotarget", $idserviciotarget);
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
    public function listarServiciosTarget($idproyecto)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT ST.id_servicio_target,
                                    C.nombre as servicio,
                                    ST.id_proyecto,
                                    ST.lugar_carga,
                                    ST.lugar_descarga  
                                FROM servicio_target as ST INNER JOIN 
                                    catalogo as C on C.id_catalogo = ST.id_servicio
                                WHERE ST.id_proyecto=:idproyecto");
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
