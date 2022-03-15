<?php
session_start();
include_once "../config/Conexion.php";
class evaluacionProyecto
{

    public function __construct()
    {
    }

    public function grabar($descripcionPro, $idcliente, $fechaInicio, $fechaFinal, $tipocargaProyecto, $fianzaProyecto, $pesopromedio, $unidadMedida, $piesCubico, $mercaderia, $permisos, $entregasPromedio, $kilometrosPromedio, $frecuenciaViajes, $seCargaPro, $seDescargaPro, $manejoEfectivoPro, $cantUnidadM, $tipoUnidaM, $tipoEquipoM, $temperaturaM, $caracEquipoM, $seguridadM, $marchamoM, $gpsM, $lugarCargaProM, $lugarDescargaProM, $canalDistribucionProM, $diaslibres, $comentarioOP, $tipounidadTargetM, $fianzaTargetM, $lugarCargaTargetM, $lugardescargaTargetM, $tarifaVentaFleteProyectoM, $tarifaCostoFleteProyectoM, $monedaTargetProyectoM, $idserviciotargetM, $tarifaVentaServicioTM, $tarifaCostoServicioTM, $idmonedaServicioTM, $lugarCargaTargetServiciosM, $lugarDescargaTargetServiciosM, $botas, $chaleco, $lentes, $guantes, $mascarilla, $careta, $otros, $archivos)
    {
        $con = Conexion::getConexion();
        $cant = 0;
        $idevaluacion = 0;
        try {

            $con->beginTransaction();
            $rsp = $con->prepare("SELECT MAX(correlativo)as Cant FROM correlativo_proyecto WHERE id_sucursal = :idsucursal");
            $rsp->bindParam(":idsucursal", $_SESSION['idsucursal']);
            $rsp->execute();
            $rsp = $rsp->fetch(PDO::FETCH_OBJ);

            $cant = $rsp->Cant;
            $cant = $cant + 1;
            $estado = 1;
            $contadorUni = 0;
            $contadorFle = 0;
            $contadorServicioT = 0;

            $stmt = $con->prepare("INSERT INTO correlativo_proyecto(id_sucursal,correlativo)
            VALUES (:idsucursal,:correlativo)");

            $stmt->bindParam(":idsucursal", $_SESSION['idsucursal']);
            $stmt->bindParam(":correlativo", $cant);
            $stmt->execute();
            $codigo = "CT" . $idcliente . "P" . $cant;
            $fechaInicio = date("Y-m-d", strtotime($fechaInicio));
            $fechaFinal = date("Y-m-d", strtotime($fechaFinal));

            $stmt = $con->prepare("INSERT INTO evaluacion_proyecto(id_sucursal,codigo,estado,id_cliente,fechainicio,fechafinal,id_tipo_carga,id_fianza,peso,id_unidad_media,pies_cubicos,descripcion_mercaderia,permisos,entregas,recorrido,frecuencua,id_sercarga,id_serdescarga,id_efectivo,descripcionProyecto,dias_libres,comentario_operacion,botas,chaleco,lentes,guantes,mascarilla,careta,otros)
            VALUES (:idsucursal,:codigo,:estado,:idcliente,:fechainicio,:fechafinal,:idtipocarga,:idfianza,:peso,:idunidadmedia,:piescubicos,:descripcionmercaderia,:permisos,:entregas,:recorrido,:frecuencua,:id_sercarga,:idserdescarga,:idefectivo,:descripcionProyecto,:diaslibres,:comentariooperacion,:botas,:chaleco,:lentes,:guantes,:mascarilla,:careta,:otros)");
            $stmt->bindParam(":idsucursal", $_SESSION['idsucursal']);
            $stmt->bindParam(":codigo", $codigo);
            $stmt->bindParam(":estado", $estado);
            $stmt->bindParam(":idcliente", $idcliente);
            $stmt->bindParam(":fechainicio", $fechaInicio);
            $stmt->bindParam(":fechafinal", $fechaFinal);
            $stmt->bindParam(":idtipocarga", $tipocargaProyecto);
            $stmt->bindParam(":idfianza", $fianzaProyecto);
            $stmt->bindParam(":peso", $pesopromedio);
            $stmt->bindParam(":idunidadmedia", $unidadMedida);
            $stmt->bindParam(":piescubicos", $piesCubico);
            $stmt->bindParam(":descripcionmercaderia", $mercaderia);
            $stmt->bindParam(":permisos", $permisos);
            $stmt->bindParam(":entregas", $entregasPromedio);
            $stmt->bindParam(":recorrido", $kilometrosPromedio);
            $stmt->bindParam(":frecuencua", $frecuenciaViajes);
            $stmt->bindParam(":id_sercarga", $seCargaPro);
            $stmt->bindParam(":idserdescarga", $seDescargaPro);
            $stmt->bindParam(":idefectivo", $manejoEfectivoPro);
            $stmt->bindParam(":descripcionProyecto", $descripcionPro);
            $stmt->bindParam(":diaslibres", $diaslibres);
            $stmt->bindParam(":comentariooperacion", $comentarioOP);
            $stmt->bindParam(":botas", $botas);
            $stmt->bindParam(":chaleco", $chaleco);
            $stmt->bindParam(":lentes", $lentes);
            $stmt->bindParam(":guantes", $guantes);
            $stmt->bindParam(":mascarilla", $mascarilla);
            $stmt->bindParam(":careta", $careta);
            $stmt->bindParam(":otros", $otros);
            $stmt->execute();

            if ($stmt) {
                $idevaluacion = $con->lastInsertId();
                if (count($cantUnidadM) > 0) {
                    $stmt = $con->prepare("INSERT INTO asigna_unidad_proyecto(id_proyecto,cantidad_unidad,id_tipo_unidad,id_tipo_equipo,temperatura,especificacion,id_seguridad,id_marchamo,id_gps,lugar_carga,lugar_descarga,id_canal_distribucion)
                            VALUES (:idproyecto,:cantidadunidad,:idtipounidad,:idtipoequipo,:temperatura,:especificacion,:idseguridad,:idmarchamo,:idgps,:lugarcarga,:lugardescarga,:idcanaldistribucion)");
                    while ($contadorUni < count($cantUnidadM)) {
                        $stmt->bindParam(":idproyecto", $idevaluacion);
                        $stmt->bindParam(":cantidadunidad", $cantUnidadM[$contadorUni]);
                        $stmt->bindParam(":idtipounidad", $tipoUnidaM[$contadorUni]);
                        $stmt->bindParam(":idtipoequipo", $tipoEquipoM[$contadorUni]);
                        $stmt->bindParam(":temperatura", $temperaturaM[$contadorUni]);
                        $stmt->bindParam(":especificacion", $caracEquipoM[$contadorUni]);
                        $stmt->bindParam(":idseguridad", $seguridadM[$contadorUni]);
                        $stmt->bindParam(":idmarchamo", $marchamoM[$contadorUni]);
                        $stmt->bindParam(":idgps", $gpsM[$contadorUni]);
                        $stmt->bindParam(":lugarcarga", $lugarCargaProM[$contadorUni]);
                        $stmt->bindParam(":lugardescarga", $lugarDescargaProM[$contadorUni]);
                        $stmt->bindParam(":idcanaldistribucion", $canalDistribucionProM[$contadorUni]);
                        $stmt->execute();
                        $contadorUni++;
                    }
                }
                if (count($tipounidadTargetM) > 0) {
                    $stmt = $con->prepare("INSERT INTO tarifa_target_proyecto(id_proyecto,id_tipo_unidad,id_fianza,lugar_carga,lugar_descarga,tarifa_venta,tarifa_costo,id_moneda)
                    VALUES (:idproyecto,:idtipounidad,:id_fianza,:lugarcarga,:lugardescarga,:tarifaventa,:tarifacosto,:idmoneda)");

                    while ($contadorFle < count($tipounidadTargetM)) {
                        $stmt->bindParam(":idproyecto", $idevaluacion);
                        $stmt->bindParam(":idtipounidad", $tipounidadTargetM[$contadorFle]);
                        $stmt->bindParam(":id_fianza", $fianzaTargetM[$contadorFle]);
                        $stmt->bindParam(":lugarcarga", $lugarCargaTargetM[$contadorFle]);
                        $stmt->bindParam(":lugardescarga", $lugardescargaTargetM[$contadorFle]);
                        $stmt->bindParam(":tarifaventa", $tarifaVentaFleteProyectoM[$contadorFle]);
                        $stmt->bindParam(":tarifacosto", $tarifaCostoFleteProyectoM[$contadorFle]);
                        $stmt->bindParam(":idmoneda", $monedaTargetProyectoM[$contadorFle]);
                        $stmt->execute();
                        $contadorFle++;
                    }
                }
                if (count($idserviciotargetM) > 0) {
                    $stmt = $con->prepare("INSERT INTO servicio_target(id_proyecto,id_servicio,lugar_carga,lugar_descarga,tarifa_venta,tarifa_costo,id_moneda)
                            VALUES (:idproyecto,:idservicio,:lugarcarga,:lugardescarga,:tarifaventa,:tarifacosto,:idmoneda)");
                    while ($contadorServicioT < count($idserviciotargetM)) {
                        $stmt->bindParam(":idproyecto", $idevaluacion);
                        $stmt->bindParam(":idservicio", $idserviciotargetM[$contadorServicioT]);
                        $stmt->bindParam(":lugarcarga", $lugarCargaTargetServiciosM[$contadorServicioT]);
                        $stmt->bindParam(":lugardescarga", $lugarDescargaTargetServiciosM[$contadorServicioT]);
                        $stmt->bindParam(":tarifaventa", $tarifaVentaServicioTM[$contadorServicioT]);
                        $stmt->bindParam(":tarifacosto", $tarifaCostoServicioTM[$contadorServicioT]);
                        $stmt->bindParam(":idmoneda", $idmonedaServicioTM[$contadorServicioT]);
                        $stmt->execute();
                        $contadorServicioT++;
                    }
                }
                $this->archivosProyecto($codigo, $archivos, $idevaluacion);
            }
            $con->commit();
            $json = array();
            $json['id_evaluacion_proyecto'] = $idevaluacion;
            $json['codigo'] = $codigo;
            $json['mensaje'] = "Proyecto Insertado con Exito";
            return $json;
        } catch (\Throwable $th) {
            $json = array();
            $json['id_evaluacion_proyecto'] = 0;
            $json['mensaje'] = "Error al insertar el Proyecto " . $th->getMessage();
            return $json;
        }
    }

    public function editar($descripcionPro, $idproyecto, $codigoProyecto, $idcliente, $fechaInicio, $fechaFinal, $tipocargaProyecto, $fianzaProyecto, $pesopromedio, $unidadMedida, $piesCubico, $mercaderia, $permisos, $entregasPromedio, $kilometrosPromedio, $frecuenciaViajes, $seCargaPro, $seDescargaPro, $manejoEfectivoPro, $diaslibres, $comentarioOP, $botasVenta, $chalecoVenta, $lentesVenta, $guantesVenta, $mascarillaVenta, $caretaVenta, $otrosVenta, $archivos)
    {
        $fechamod = date("Y-m-d");
        //$codigo = "CT" . $idcliente . "P" . $codigoProyecto;
        $fechaInicio = date("Y-m-d", strtotime($fechaInicio));
        $fechaFinal = date("Y-m-d", strtotime($fechaFinal));

        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("UPDATE evaluacion_proyecto 
                                    SET id_cliente =:idcliente,
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
                                        fechamodifica=:fechamodifica,
                                        descripcionProyecto=:descripcionProyecto,
                                        dias_libres=:diaslibres,
                                        comentario_operacion=:comentariooperacion,
                                        botas=:botas, 
                                        chaleco=:chaleco,
                                        lentes=:lentes,
                                        guantes=:guantes,
                                        mascarilla=:mascarilla,
                                        careta=:careta,
                                        otros=:otros
                                    WHERE id_evaluacion_proyecto=:idproyecto");

            $rsp->bindParam(":idcliente", $idcliente);
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
            $rsp->bindParam(":descripcionProyecto", $descripcionPro);
            $rsp->bindParam(":diaslibres", $diaslibres);
            $rsp->bindParam(":comentariooperacion", $comentarioOP);
            $rsp->bindParam(":botas", $botasVenta);
            $rsp->bindParam(":chaleco", $chalecoVenta);
            $rsp->bindParam(":lentes", $lentesVenta);
            $rsp->bindParam(":guantes", $guantesVenta);
            $rsp->bindParam(":mascarilla", $mascarillaVenta);
            $rsp->bindParam(":careta", $caretaVenta);
            $rsp->bindParam(":otros", $otrosVenta);
            $rsp->bindParam(":idproyecto", $idproyecto);
            $rsp->execute();
            if ($rsp !== false) {
                $this->archivosProyecto($codigoProyecto, $archivos, $idproyecto);
                $json = array();
                $json['id_evaluacion_proyecto'] = $idproyecto;
                $json['mensaje'] = "Proyecto Actualizado con exito";
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

    public function archivosProyecto($codigo, $archivos, $idproyecto)
    {
        $con = Conexion::getConexion();
        $dirsucursal = '../' . $_SESSION['codigoS'];
        $anio = date("Y");
        try {
            $diranio = $dirsucursal . '/' . $anio;
            if (!file_exists($dirsucursal)) {
                mkdir($dirsucursal, 0777);
            }

            if (!file_exists($diranio)) {
                mkdir($diranio, 0777);
            }

            $proyectos = $diranio . '/EvaluacionProyecto';

            if (!file_exists($proyectos)) {
                mkdir($proyectos, 0777);
            }
            $codigoCarpeta = $proyectos . '/' . $codigo;

            if (!file_exists($codigoCarpeta)) {
                mkdir($codigoCarpeta, 0777);
            }

            foreach ($archivos['tmp_name'] as $key => $tmp_name) {
                //Validamos que el archivo exista
                if ($archivos["name"][$key]) {
                    $filename = $archivos["name"][$key]; //Obtenemos el nombre original del archivo
                    $source = $archivos["tmp_name"][$key]; //Obtenemos un nombre temporal del archivo

                    $dir = opendir($codigoCarpeta); //Abrimos el directorio de destino
                    $target_path = $codigoCarpeta . '/' . $filename; //Indicamos la ruta de destino, así como el nombre del archivo

                    //Movemos y validamos que el archivo se haya cargado correctamente
                    //El primer campo es el origen y el segundo el destino
                    if (move_uploaded_file($source, $target_path)) {
                        //archivo movido al directorio indicado
                        $rsp = $con->prepare("SELECT nombre_archivo  FROM archivos_evalua_proyecto WHERE  id_proyecto = :idproyecto AND nombre_archivo =:nombrea ");
                        $rsp->bindParam(":idproyecto", $idproyecto);
                        $rsp->bindParam(":nombrea", $filename);

                        $rsp->execute();
                        $rsp = $rsp->fetch(PDO::FETCH_OBJ);

                        if ($rsp) {
                        } else {
                            $rspt = $con->prepare("INSERT INTO archivos_evalua_proyecto(id_proyecto,nombre_archivo,ubicacion)
                            VALUES (:idproyecto,:nombrearchivo,:ubicacion)");
                            $rspt->bindParam(":idproyecto", $idproyecto);
                            $rspt->bindParam(":nombrearchivo", $filename);
                            $rspt->bindParam(":ubicacion", $codigoCarpeta);
                            $rspt->execute();
                        }
                    } else {
                    }
                    closedir($dir);
                }
            }
            return "1";
        } catch (\Throwable $th) {
            if (file_exists($codigoCarpeta)) {
                unlink($codigoCarpeta);
            }
            return "Error encontrado " . $th->getMessage();;
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
                                    SC.nombre as efectivo,
                                    PR.descripcionProyecto,
                                    PR.dias_libres,
                                    PR.comentario_operacion
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
    public function listarProyecto($idproyecto)
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
                                    PR.descripcionProyecto,
                                    PR.dias_libres,
                                    PR.comentario_operacion,
                                    IFNULL(botas,0) as botas, 
                                    IFNULL(chaleco,0)as chaleco, 
                                    IFNULL(lentes,0)as lentes, 
                                    IFNULL(guantes,0)as guantes, 
                                    IFNULL(mascarilla,0)as mascarilla, 
                                    IFNULL(careta,0) as careta, 
                                    IFNULL(otros,'') as otros,
                                    e.Razons as cliente,
                                    tce.nombre as tipocarga,
                                    F.nombre  as Fianza,
                                    um.nombre as Unidad,
                                    SC.nombre  as secarga,
                                    SC.nombre  as sedescarga,
                                    SC.nombre as efectivo
                                FROM evaluacion_proyecto as PR inner join 
                                    empresas e  on e.id_empresa = PR.id_cliente inner join 
                                        tipo_carga_empresa tce on id_tipo_carga_empresa = Pr.id_tipo_carga inner join 
                                        sino F on F.id_sino  = PR.id_fianza inner join 
                                        unidad_medida um on id_unidad_medida  = PR.id_unidad_media left join 
                                        sino SC on SC.id_sino  = PR.id_sercarga left join 
                                        sino SD on SD.id_sino  = PR.id_serdescarga left  join 
                                        sino as ME on ME.id_sino  = PR.id_efectivo 
                                    where PR.id_evaluacion_proyecto = :idproyecto ");
            $rsp->bindParam(":idproyecto", $idproyecto);
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
    public function grabarTarifaTarget($idproyecto, $tipounidadTarget, $fianzaTarget, $lugarCargaTarget, $lugardescargaTarget, $tarifaVentaFlete, $tarifaCostoFlete, $monedaFleteTarget)
    {
        $con = Conexion::getConexion();

        try {

            $con->beginTransaction();

            $stmt = $con->prepare("INSERT INTO tarifa_target_proyecto(id_proyecto,id_tipo_unidad,id_fianza,lugar_carga,lugar_descarga,tarifa_venta,tarifa_costo,id_moneda)
            VALUES (:idproyecto,:idtipounidad,:id_fianza,:lugarcarga,:lugardescarga,:tarifaventa,:tarifacosto,:idmoneda)");
            $stmt->bindParam(":idproyecto", $idproyecto);
            $stmt->bindParam(":idtipounidad", $tipounidadTarget);
            $stmt->bindParam(":id_fianza", $fianzaTarget);
            $stmt->bindParam(":lugarcarga", $lugarCargaTarget);
            $stmt->bindParam(":lugardescarga", $lugardescargaTarget);
            $stmt->bindParam(":tarifaventa", $tarifaVentaFlete);
            $stmt->bindParam(":tarifacosto", $tarifaCostoFlete);
            $stmt->bindParam(":idmoneda", $monedaFleteTarget);
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
    public function editarTarifaTarget($idtarifa_target, $tipounidadTarget, $fianzaTarget, $lugarCargaTarget, $lugardescargaTarget, $tarifaVentaFlete, $tarifaCostoFlete, $monedaFleteTarget)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("UPDATE tarifa_target_proyecto 
                                    SET 
                                        id_tipo_unidad=:tipounidad,
                                        id_fianza=:idfianza,
                                        lugar_carga= :lugarcarga,
                                        lugar_descarga=:lugardescarga,
                                        tarifa_venta=:venta,
                                        tarifa_costo=:costo,
                                        id_moneda=:moneda

                    WHERE idtarifa_target=:idtarifatarget");

            $rsp->bindParam(":tipounidad", $tipounidadTarget);
            $rsp->bindParam(":idfianza", $fianzaTarget);
            $rsp->bindParam(":lugarcarga", $lugarCargaTarget);
            $rsp->bindParam(":lugardescarga", $lugardescargaTarget);
            $rsp->bindParam(":idtarifatarget", $idtarifa_target);
            $rsp->bindParam(":venta", $tarifaVentaFlete);
            $rsp->bindParam(":costo", $tarifaCostoFlete);
            $rsp->bindParam(":moneda", $monedaFleteTarget);

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
                                    TT.lugar_descarga,
                                    TT.tarifa_venta as venta,
                                    TT.tarifa_costo as costo,
                                    TT.id_moneda,
                                    m.signo
                                FROM tarifa_target_proyecto AS TT LEFT JOIN
                                    moneda  AS m on m.id_moneda = TT.id_moneda
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
                                    TT.lugar_descarga,
                                    TT.tarifa_venta as venta,
                                    TT.tarifa_costo as costo,
                                    m.signo
                                FROM tarifa_target_proyecto as TT INNER JOIN  
                                        tipo_unidades_truc as TU on TU.idtipo_unidades = TT.id_tipo_unidad INNER JOIN 
                                        sino as F on F.id_sino = TT.id_fianza LEFT JOIN
                                        moneda as m on m.id_moneda = TT.id_moneda
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

    public function grabaServicoTarget($idproyecto, $idservicio, $lugarcargaservicio, $lugardescargarservicio, $tarifaVentaServicioT, $tarifaCostoServicioT, $idmonedaServicioT)
    {
        $con = Conexion::getConexion();
        try {
            $con->beginTransaction();
            $stmt = $con->prepare("INSERT INTO servicio_target(id_proyecto,id_servicio,lugar_carga,lugar_descarga,tarifa_venta,tarifa_costo,id_moneda)
            VALUES (:idproyecto,:idservicio,:lugarcarga,:lugardescarga,:tarifaventa,:tarifacosto,:idmoneda)");
            $stmt->bindParam(":idproyecto", $idproyecto);
            $stmt->bindParam(":idservicio", $idservicio);
            $stmt->bindParam(":lugarcarga", $lugarcargaservicio);
            $stmt->bindParam(":lugardescarga", $lugardescargarservicio);
            $stmt->bindParam(":tarifaventa", $tarifaVentaServicioT);
            $stmt->bindParam(":tarifacosto", $tarifaCostoServicioT);
            $stmt->bindParam(":idmoneda", $idmonedaServicioT);
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

    public function editaServicioTarget($idserviciotarget, $idservicio, $lugarcargaservicio, $lugardescargarservicio, $tarifaVentaServicioT, $tarifaCostoServicioT, $idmonedaServicioT)
    {
        $con = Conexion::getConexion();
        try {

            $rsp = $con->prepare("UPDATE servicio_target 
                                    SET 
                                        id_servicio=:idservicio,
                                        lugar_carga=:lugarcarga,
                                        lugar_descarga= :lugardescarga,
                                        tarifa_venta=:venta,
                                        tarifa_costo=:costo,
                                        id_moneda=:moneda
                    WHERE id_servicio_target=:idserviciotarget");

            $rsp->bindParam(":idservicio", $idservicio);
            $rsp->bindParam(":lugarcarga", $lugarcargaservicio);
            $rsp->bindParam(":lugardescarga", $lugardescargarservicio);
            $rsp->bindParam(":venta", $tarifaVentaServicioT);
            $rsp->bindParam(":costo", $tarifaCostoServicioT);
            $rsp->bindParam(":moneda", $idmonedaServicioT);
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
            $rsp = $con->prepare("SELECT ST.id_servicio_target,
                                    ST.id_servicio,
                                    ST.id_proyecto,
                                    ST.lugar_carga,
                                    ST.lugar_descarga,
                                    ST.tarifa_venta as venta,
                                    ST.tarifa_costo as costo,
                                    ST.id_moneda,
                                    m.signo   
                                FROM servicio_target ST LEFT JOIN
                                    moneda as m ON m.id_moneda = ST.id_moneda
                                WHERE id_servicio_target=:idserviciotarget");
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
                                    ST.lugar_descarga,
                                    ifnull(ST.tarifa_venta,0) as venta,
                                    ifnull(ST.tarifa_costo,0) as costo,
                                    ST.id_moneda,
                                    ifnull(m.signo,'') as signo   
                                FROM servicio_target as ST INNER JOIN 
                                    catalogo as C on C.id_catalogo = ST.id_servicio  LEFT JOIN
                                    moneda as m ON m.id_moneda = ST.id_moneda
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

    public function listarArchivos($idproyecto)
    {
        try {
            $con = Conexion::getConexion();
            $rspt = $con->prepare("SELECT id_archivo, 
                                        id_proyecto, 
                                        nombre_archivo, 
                                        ubicacion
                                    FROM archivos_evalua_proyecto
                                WHERE id_proyecto =:idproyecto");
            $rspt->bindParam(":idproyecto", $idproyecto);
            $rspt->execute();
            $rspt = $rspt->fetchAll(PDO::FETCH_OBJ);
            if ($rspt) {
                return $rspt;
            } else {
                return array();
            }
        } catch (\Throwable $th) {
            return array();
        }
    }
}
