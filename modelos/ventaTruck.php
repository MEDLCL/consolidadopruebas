<?php
//session_start();
include_once "../config/Conexion.php";
class ventaTruck
{

    public function __construct()
    {
    }

    public function grabar($codigoProyectoVenta, $id_tipoventa, $id_cliente, $id_proyecto, $id_embarcador, $id_notificar, $id_agente, $observaciones, $grabaC, $idcatalogos, $tarifaVentaS, $tarifaCostoS, $cantidadS, $profitS, $monedasS, $origenesS, $destinosS, $grabaF, $origenesF, $destinosF, $tarifaVentaIF, $tarifaCostoIF, $unidadesF, $totalVentaF, $totalCostoF, $profitF, $horaP, $monedasF, $codigosPVenta, $descripcionPVenta, $volumenPVenta, $pesoPVenta, $bultosPVenta, $pesoBultoPVenta, $diaslibres, $fechap, $tiposcarga,$tiposunidades)
    {
        $tipoventa = '';
        if ($id_tipoventa == 1) {
            $tipoventa = 'NA';
        } else {
            $tipoventa = 'IN';
        }
        $codigo = "" . $_SESSION['CodigoArea'] . "." . $codigoProyectoVenta . "." . $_SESSION['idusuario'] . "." . date('Y') . "." . $tipoventa;
        $idventa = 0;
        $json = array();
        $fechamod = date("Y-m-d");
        $con = Conexion::getConexion();
        try {
            $con->beginTransaction();
            $stmt = $con->prepare("INSERT INTO venta_truck(id_tipoventa,id_cliente,id_proyecto,id_sucursal,id_usuario,id_usuario_modifica,codigo,fecha_modifica,id_embarcador,id_notificar,id_agente,observaciones)
                            VALUES (:idtipoventa,:idcliente,:idproyecto,:idsucursal,:idusuario,:idusuariomodifica,:codigo,:fechamodifica,:idembarcador,:idnotificar,:idagente,:observaciones)");
            $stmt->bindParam(":idtipoventa", $id_tipoventa);
            $stmt->bindParam(":idcliente", $id_cliente);
            $stmt->bindParam(":idproyecto", $id_proyecto);
            $stmt->bindParam(":idsucursal", $_SESSION['idsucursal']);
            $stmt->bindParam(":idusuario", $_SESSION['idusuario']);
            $stmt->bindParam(":idusuariomodifica", $_SESSION['idusuario']);
            $stmt->bindParam(":codigo", $codigo);
            $stmt->bindParam(":fechamodifica", $fechamod);
            $stmt->bindParam(":idembarcador", $id_embarcador);
            $stmt->bindParam(":idnotificar", $id_notificar);
            $stmt->bindParam(":idagente", $id_agente);
            $stmt->bindParam(":observaciones", $observaciones);
            $stmt->execute();

            if ($stmt) {
                $idventa = $con->lastInsertId();
                $contadorS = 0;
                $profitservicio = 0;
                $comisionservicio = 0;

                //servicios adicionales venta 
                if (count($grabaC) > 0) {
                    $rspt = $con->prepare("INSERT INTO servicio_adicionales_venta_truck(id_venta_truck,id_catalogo,tarifa_venta,tarifa_costo,cantidad,profit,id_moneda,origen,destino,comision)
                                            VALUES (:idventatruck,:idcatalogo,:tarifaventa,:tarifacosto,:cantidad,:profit,:idmoneda,:origen,:destino,:comision)");
                    while ($contadorS < count($grabaC)) {
                        $profitservicio = ($tarifaVentaS[$contadorS] * $cantidadS[$contadorS]) - ($tarifaCostoS[$contadorS] * $cantidadS[$contadorS]);
                        $comisionservicio = $profitservicio * .10;
                        $profitservicio = $profitservicio - $comisionservicio;

                        $rspt->bindParam(":idventatruck", $idventa);
                        $rspt->bindParam(":idcatalogo", $idcatalogos[$contadorS]);
                        $rspt->bindParam(":tarifaventa", $tarifaVentaS[$contadorS]);
                        $rspt->bindParam(":tarifacosto", $tarifaCostoS[$contadorS]);
                        $rspt->bindParam(":cantidad", $cantidadS[$contadorS]);
                        $rspt->bindParam(":profit", $profitservicio);
                        $rspt->bindParam(":idmoneda", $monedasS[$contadorS]);
                        $rspt->bindParam(":origen", $origenesS[$contadorS]);
                        $rspt->bindParam(":destino", $destinosS[$contadorS]);
                        $rspt->bindParam(":comision",$comisionservicio );
                        $rspt->execute();
                        $contadorS++;
                    }
                }
                //servicio de flete venta 
                $contadorF = 0;
                $profitFlete = 0;
                $ventatotal = 0;
                $costototal = 0;
                $comiflete = 0;

                if (count($grabaF) > 0) {
                    $rspt = $con->prepare("INSERT INTO servicio_flete_venta_truck(id_venta,origen,destino,tarifa_venta,tarifa_costo,unidades,total_venta,total_costo,profit,hora_posicionamiento,id_moneda,comision,dias_libres,fecha_posicion,id_tipo_carga,id_tipo_unidad)
                                            VALUES (:idventa,:origen,:destino,:tarifaventa,:tarifacosto,:unidades,:totalventa,:totalcosto,:profit,:horaposicionamiento,:idmoneda,:comision,:diaslibres,:fechaposicion,:idtipocarga,:idtipounidad)");
                    while ($contadorF < count($grabaF)) {
                        $ventatotal = ($tarifaVentaIF[$contadorF] * $unidadesF[$contadorF]);
                        $costototal = ($tarifaCostoIF[$contadorF] * $unidadesF[$contadorF]);
                        $profitFlete = $ventatotal - $costototal;
                        $comiflete = $profitFlete * .10;
                        $profitFlete = $profitFlete - $comiflete;

                        $rspt->bindParam(":idventa", $idventa);
                        $rspt->bindParam(":origen", $origenesF[$contadorF]);
                        $rspt->bindParam(":destino", $destinosF[$contadorF]);
                        $rspt->bindParam(":tarifaventa", $tarifaVentaIF[$contadorF]);
                        $rspt->bindParam(":tarifacosto", $tarifaCostoIF[$contadorF]);
                        $rspt->bindParam(":unidades", $unidadesF[$contadorF]);
                        $rspt->bindParam(":totalventa", $ventatotal);
                        $rspt->bindParam(":totalcosto", $costototal);
                        $rspt->bindParam(":profit", $profitFlete);
                        $rspt->bindParam(":horaposicionamiento", $horaP[$contadorF]);
                        $rspt->bindParam(":idmoneda", $monedasF[$contadorF]);
                        $rspt->bindParam(":comision", $comiflete);
                        $rspt->bindParam(":diaslibres", $diaslibres[$contadorF]);
                        $rspt->bindParam(":fechaposicion", $fechap[$contadorF]);
                        $rspt->bindParam(":idtipocarga", $tiposcarga[$contadorF]);
                        $rspt->bindParam(":idtipounidad", $tiposunidades[$contadorF]);
                        
                        $rspt->execute();
                        $contadorF++;
                    }
                }
                //productos de la venta internacional
                /*    $contadorP = 0;
                if (count($codigosPVenta) > 0) {
                    $rspt = $con->prepare("INSERT INTO productos_venta_truck(id_venta_truck,codigo_producto,descripcion,volumen,peso,bultos,peso_bultos)
                                            VALUES (:idventatruck,:codigoproducto,:descripcion,:volumen,:peso,:bultos,:pesobultos)");
                    while ($contadorP < count($codigosPVenta)) {
                        $rspt->bindParam(":idventatruck", $idventa);
                        $rspt->bindParam(":codigoproducto", $codigosPVenta[$contadorP]);
                        $rspt->bindParam(":descripcion", $descripcionPVenta[$contadorP]);
                        $rspt->bindParam(":volumen", $volumenPVenta[$contadorP]);
                        $rspt->bindParam(":peso", $pesoPVenta[$contadorP]);
                        $rspt->bindParam(":bultos", $bultosPVenta[$contadorP]);
                        $rspt->bindParam(":pesobultos", $pesoBultoPVenta[$contadorP]);
                        $rspt->execute();
                        $contadorP++;
                    }
                } */
            }
            $con->commit();
            $json['idVentaTruck'] = $idventa;
            $json['mensaje'] = "Venta ingresada con Exito";
            $json['codigoventa']= $codigo;
            return $json;
        } catch (\Throwable $th) {
            $con->rollBack();
            $json = array();
            $json['idVentaTruck'] = 0;
            $json['mensaje'] = "Error al ingresar Venta" . $th->getMessage();
            return $json;
        }
    }

    public function editar($idventa, $observacionesVenta, $embarcadorVenta, $notificaraVenta, $agenteVenta, $idProductos, $codigosPVenta, $descripcionPVenta, $volumenPVenta, $pesoPVenta, $bultosPVenta, $pesoBultoPVenta)
    {
        //$validezTarifaFlete  = date("Y-m-d", strtotime($validezTarifaFlete));
        $fechamod = date("Y-m-d");
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("UPDATE venta_truck
                                    SET id_usuario_modifica=:idusuariomod, 
                                    fecha_modifica=:fechamodifica, 
                                    observaciones=:observaciones,
                                    id_embarcador=:idembarcador,
                                    id_notificar=:idnotificar,
                                    id_agente=:idagente 
                                WHERE id_venta_truck=:idventatruck");

            $rsp->bindParam(":idusuariomod", $_SESSION['idusuario']);
            $rsp->bindParam(":fechamodifica", $fechamod);
            $rsp->bindParam(":observaciones", $observacionesVenta);
            $rsp->bindParam(":idembarcador", $embarcadorVenta);
            $rsp->bindParam(":idnotificar", $notificaraVenta);
            $rsp->bindParam(":idagente", $agenteVenta);
            $rsp->bindParam("idventatruck", $idventa);
            $rsp->execute();

            /*       if ($rsp !== false) {
                $contadorI = 0;
                if (count($idProductos) > 0) {
                
                    while ($contadorI < count($idProductos)) {
                        if ($idProductos[$contadorI] == 0) {
                            $rspt = $con->prepare("INSERT INTO productos_venta_truck(id_venta_truck,codigo_producto,descripcion,volumen,peso,bultos,peso_bultos)
                            VALUES (:idventatruck,:codigoproducto,:descripcion,:volumen,:peso,:bultos,:pesobultos)");
                            
                            $rspt->bindParam(":idventatruck", $idventa);
                            $rspt->bindParam(":codigoproducto", $codigosPVenta[$contadorI]);
                            $rspt->bindParam(":descripcion", $descripcionPVenta[$contadorI]);
                            $rspt->bindParam(":volumen", $volumenPVenta[$contadorI]);
                            $rspt->bindParam(":peso", $pesoPVenta[$contadorI]);
                            $rspt->bindParam(":bultos", $bultosPVenta[$contadorI]);
                            $rspt->bindParam(":pesobultos", $pesoBultoPVenta[$contadorI]);
                            $rspt->execute();
                        }
                        $contadorI++;
                    }
                }
                $contadorU = 0;
                if (count($idProductos) > 0) {
                
                    while ($contadorU < count($idProductos)) {
                        if ($idProductos[$contadorU] > 0) {
                            $rspt = $con->prepare("UPDATE productos_venta_truck
                                                    SET codigo_producto=:codigoproducto, 
                                                        descripcion=:descripcion, 
                                                        volumen=:volumen, 
                                                        peso=:peso, 
                                                        bultos=:bultos, 
                                                        peso_bultos=:pesobultos
                                                WHERE id_producto=:idproducto");
                            $rspt->bindParam(":codigoproducto", $codigosPVenta[$contadorU]);
                            $rspt->bindParam(":descripcion", $descripcionPVenta[$contadorU]);
                            $rspt->bindParam(":volumen", $volumenPVenta[$contadorU]);
                            $rspt->bindParam(":peso", $pesoPVenta[$contadorU]);
                            $rspt->bindParam(":bultos", $bultosPVenta[$contadorU]);
                            $rspt->bindParam(":pesobultos", $pesoBultoPVenta[$contadorU]);
                            $rspt->bindParam(":idproducto", $idProductos[$contadorU]);
                            $rspt->execute();
                        }
                        $contadorU++;
                    }
                }             
            }  */
            $json = array();
            $json['idVentaTruck'] = $idventa;
            $json['mensaje'] = "Venta  Actualizad con exito";
            return $json;
        } catch (\Throwable $th) {
            $json = array();
            $json['idVentaTruck'] = 0;
            $json['mensaje'] = "Error al actualizar Tarifa " . $th->getMessage();
            return $json;
            //return $th->getMessage();
        }
    }
    //
    public function anulaVenta($idventa)
    {
        //
        $estado = false;
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("UPDATE venta_truck
                                    SET estado =:estado
                            WHERE id_venta_truck=:idventatruck");

            $rsp->bindParam(":estado", $estado);
            $rsp->bindParam(":idventatruck", $idventa);
            $rsp->execute();
            if ($rsp !== false) {
                $json = array();
                $json['idVentaTruck'] = $idventa;
                $json['mensaje'] = "Venta Anulada con exito";
                return $json;
            }
        } catch (\Throwable $th) {
            $json = array();
            $json['idVentaTruck'] = 0;
            $json['mensaje'] = "Error al Anular Venta" . $th->getMessage();
            return $json;
            //return $th->getMessage();
        }
    }
    public function anulaServicioAdicional($idservicioA)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("DELETE FROM servicio_adicionales_venta_truck
                                    WHERE id_servicio_adicional=:idservicioadicional");
            $rsp->bindParam(":idservicioadicional", $idservicioA);
            $rsp->execute();
            if ($rsp !== false) {
                $json = array();
                $json['idservicioA'] = $idservicioA;
                $json['mensaje'] = "Servicio Anulado con exito";
                return $json;
            }
        } catch (\Throwable $th) {
            $json = array();
            $json['idservicioA'] = 0;
            $json['mensaje'] = "Error al Anular Servicio" . $th->getMessage();
            return $json;
            //return $th->getMessage();
        }
    }


    public function listarVentas()
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT vt.codigo,
                                    e.Razons as cliente,
                                    vt.botas ,
                                    vt.chaleco ,
                                    vt.lentes ,
                                    vt.guantes ,
                                    vt.mascarilla ,
                                    vt.careta ,
                                    vt.otros ,
                                    vt.observaciones,
                                    IFNULL((SELECT e2.Razons FROM empresas e2 WHERE e2.id_empresa = vt.id_embarcador),'') as Embarcador,
                                    IFNULL((SELECT e2.Razons FROM empresas e2 WHERE e2.id_empresa = vt.id_notificar),'') as notificara,
                                    IFNULL((SELECT e2.Razons FROM empresas e2 WHERE e2.id_empresa = vt.id_agente),'') as agente,
                                    vt.id_venta_truck,
                                    ep.codigo  as proyecto
                                FROM venta_truck vt inner join 
                                    tipo_venta_truck tvt on tvt.id_tipo_venta = vt.id_tipoventa inner join 
                                    empresas e on e.id_empresa  = vt.id_cliente inner join 
                                    evaluacion_proyecto ep on ep.id_evaluacion_proyecto = vt.id_proyecto 
                                WHERE vt.id_usuario  = :idusuario AND vt.estado = 1");
            $rsp->bindParam(":idusuario", $_SESSION['idusuario']);
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
    public function listarVenta($idventa)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT vt.id_venta_truck, 
                                    vt.id_tipoventa, 
                                    vt.id_cliente, 
                                    vt.id_proyecto, 
                                    vt.id_sucursal, 
                                    vt.id_usuario, 
                                    vt.id_usuario_modifica, 
                                    vt.codigo, 
                                    vt.fecha_graba, 
                                    vt.fecha_modifica, 
                                    vt.id_embarcador, 
                                    vt.id_notificar, 
                                    vt.id_agente, 
                                    vt.observaciones, 
                                    vt.estado,
                                    e.Razons as cliente,
                                    tvt.nombre as tipoventa
                                FROM venta_truck as vt INNER JOIN
                                    empresas e on e.id_empresa  = vt.id_cliente INNER JOIN
                                    tipo_venta_truck tvt on tvt.id_tipo_venta = vt.id_tipoventa
                                WHERE id_venta_truck=:idventa");
            $rsp->bindParam(":idventa", $idventa);
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

    public function grabarServicio($idventa, $idcatalogo, $servicioTarifaVenta, $servicioTarifaCosto, $servicioCantidadVenta, $servicioMonedaVenta, $servicioOrigenVenta, $servicioDestinoVenta)
    {

        $profit = ($servicioTarifaVenta * $servicioCantidadVenta) - ($servicioTarifaCosto * $servicioCantidadVenta);
        $comision = $profit * .10;
        $profit = $profit - $comision;

        $con = Conexion::getConexion();
        try {
            $stmt = $con->prepare("INSERT INTO servicio_adicionales_venta_truck(id_venta_truck,id_catalogo,tarifa_venta,tarifa_costo,cantidad,profit,id_moneda,origen,destino,comision)
                                VALUES (:idventatruck,:idcatalogo,:tarifaventa,:tarifacosto,:cantidad,:profit,:idmoneda,:origen,:destino,:comision)");
            $stmt->bindParam(":idventatruck", $idventa);
            $stmt->bindParam(":idcatalogo", $idcatalogo);
            $stmt->bindParam(":tarifaventa", $servicioTarifaVenta);
            $stmt->bindParam(":tarifacosto", $servicioTarifaCosto);
            $stmt->bindParam(":cantidad", $servicioCantidadVenta);
            $stmt->bindParam(":profit", $profit);
            $stmt->bindParam(":idmoneda", $servicioMonedaVenta);
            $stmt->bindParam(":origen", $servicioOrigenVenta);
            $stmt->bindParam(":destino", $servicioDestinoVenta);
            $stmt->bindParam(":comision", $comision);
            $stmt->execute();
            if ($stmt) {
                $json = array();
                $json['id_servicio_adicional'] = $con->lastInsertId();
                $json['mensaje'] = "Servicio ingresado con exito";
                return $json;
            }
        } catch (\Throwable $th) {
            $json = array();
            $json['id_servicio_adicional'] = 0;
            $json['mensaje'] = "Error al ingresar Servicio";
            return $json;
        }
    }
    public function editarServicio($idservicioA, $idcatalogo, $servicioTarifaVenta, $servicioTarifaCosto, $servicioCantidadVenta, $servicioMonedaVenta, $servicioOrigenVenta, $servicioDestinoVenta)
    {
        $profit = ($servicioTarifaVenta * $servicioCantidadVenta) - ($servicioTarifaCosto * $servicioCantidadVenta);
        $comision = $profit * .10;
        $profit = $profit - $comision;
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("UPDATE servicio_adicionales_venta_truck
                                SET id_catalogo=:idcatalogo, 
                                    tarifa_venta=:tarifaventa, 
                                    tarifa_costo=:tarifacosto, 
                                    cantidad=:cantidad, 
                                    profit=:profit, 
                                    id_moneda=:idmoneda, 
                                    origen=:origen, 
                                    destino=:destino,
                                    comision=:comision
                            WHERE id_servicio_adicional=:idservicio");

            $rsp->bindParam(":idcatalogo", $idcatalogo);
            $rsp->bindParam(":tarifaventa", $servicioTarifaVenta);
            $rsp->bindParam(":tarifacosto", $servicioTarifaCosto);
            $rsp->bindParam(":cantidad", $servicioCantidadVenta);
            $rsp->bindParam(":profit", $profit);
            $rsp->bindParam(":idmoneda", $servicioMonedaVenta);
            $rsp->bindParam(":origen", $servicioOrigenVenta);
            $rsp->bindParam(":destino", $servicioDestinoVenta);
            $rsp->bindParam(":comision", $comision);
            $rsp->bindParam(":idservicio", $idservicioA);
            $rsp->execute();
            if ($rsp !== false) {
                $json = array();
                $json['id_servicio_adicional'] = $idservicioA;
                $json['mensaje'] = "Servicio  Actualizado con exito";
                return $json;
            } else {
                $json = array();
                $json['id_servicio_adicional'] = 0;
                $json['mensaje'] = "Error al actualizar Servicio";
                return $json;
            }
        } catch (\Throwable $th) {
            $json = array();
            $json['id_servicio_adicional'] = 0;
            $json['mensaje'] = "Error al actualizar Servicio" . $th->getMessage();
            return $json;
            //return $th->getMessage();
        }
    }
    public function listarServiciosAdicionales($idventa)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT SA.id_servicio_adicional, 
                                        SA.id_venta_truck, 
                                        SA.id_catalogo, 
                                        SA.tarifa_venta, 
                                        SA.tarifa_costo, 
                                        SA.cantidad, 
                                        SA.profit, 
                                        SA.id_moneda, 
                                        SA.origen, 
                                        SA.destino,
                                        c.nombre as descripcion,
                                        m.signo,
                                        SA.comision 
                                    FROM servicio_adicionales_venta_truck as SA inner join 
                                        catalogo c on c.id_catalogo = SA.id_catalogo inner join 
                                        moneda m  on m.id_moneda  = SA.id_moneda 
                                    WHERE SA.id_venta_truck=:idventa");
            $rsp->bindParam(":idventa", $idventa);
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

    public function listarServicioAdiconal($idservicio)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT id_servicio_adicional, 
                                        id_venta_truck, 
                                        id_catalogo, 
                                        tarifa_venta, 
                                        tarifa_costo, 
                                        cantidad, 
                                        profit, 
                                        id_moneda, 
                                        origen, 
                                        destino,
                                        comision
                                    FROM servicio_adicionales_venta_truck
                                    WHERE id_servicio_adicional = :idservicio");
            $rsp->bindParam(":idservicio", $idservicio);
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
    public function grabarFlete($idventa, $tarifaVentaFleteMV, $tarifaCostoFleteMV, $monedaFleteMV, $unidadesFleteMV, $horaFleteMV, $fechaPosFleteMV, $diaslibreFleteMV, $tipocargaFleteMV, $origenFleteMV, $desitinoFleteMV,$tipounidadFleteVenta)
    {

        $con = Conexion::getConexion();
        try {
            $rspt = $con->prepare("INSERT INTO servicio_flete_venta_truck(id_venta,origen,destino,tarifa_venta,tarifa_costo,unidades,total_venta,total_costo,profit,hora_posicionamiento,id_moneda,comision,dias_libres,fecha_posicion,id_tipo_carga,id_tipo_unidad)
        VALUES (:idventa,:origen,:destino,:tarifaventa,:tarifacosto,:unidades,:totalventa,:totalcosto,:profit,:horaposicionamiento,:idmoneda,:comision,:diaslibres,:fechaposicion,:idtipocarga,:id_tipo_unidad)");

            $ventatotal = ($tarifaVentaFleteMV * $unidadesFleteMV);
            $costototal = ($tarifaCostoFleteMV * $unidadesFleteMV);
            $profitFlete = $ventatotal - $costototal;
            $comiflete = $profitFlete * .10;
            $profitFlete = $profitFlete - $comiflete;

            $rspt->bindParam(":idventa", $idventa);
            $rspt->bindParam(":origen", $origenFleteMV);
            $rspt->bindParam(":destino", $desitinoFleteMV);
            $rspt->bindParam(":tarifaventa", $tarifaVentaFleteMV);
            $rspt->bindParam(":tarifacosto", $tarifaCostoFleteMV);
            $rspt->bindParam(":unidades", $unidadesFleteMV);
            $rspt->bindParam(":totalventa", $ventatotal);
            $rspt->bindParam(":totalcosto", $costototal);
            $rspt->bindParam(":profit", $profitFlete);
            $rspt->bindParam(":horaposicionamiento", $horaFleteMV);
            $rspt->bindParam(":idmoneda", $monedaFleteMV);
            $rspt->bindParam(":comision", $comiflete);
            $rspt->bindParam(":diaslibres", $diaslibreFleteMV);
            $rspt->bindParam(":fechaposicion", $fechaPosFleteMV);
            $rspt->bindParam(":idtipocarga", $tipocargaFleteMV);
            $rspt->bindParam(":id_tipo_unidad", $tipounidadFleteVenta);
            $rspt->execute();
            if ($rspt) {
                $json = array();
                $json['id_servicio_flete'] = $con->lastInsertId();
                $json['mensaje'] = "Flete ingresado con exito";
                return $json;
            }
        } catch (\Throwable $th) {
            $json = array();
            $json['id_servicio_flete'] = 0;
            $json['mensaje'] = "Error al ingresar Flete";
            return $json;
        }
    }

//terminar para actualizar
    public function editarFlete($idfleteadicionalm, $tarifaVentaFleteMV, $tarifaCostoFleteMV, $monedaFleteMV, $unidadesFleteMV, $horaFleteMV, $fechaPosFleteMV, $diaslibreFleteMV, $tipocargaFleteMV, $origenFleteMV, $desitinoFleteMV,$tipounidadFleteVenta)
    {
        $ventatotal = ($tarifaVentaFleteMV * $unidadesFleteMV);
        $costototal = ($tarifaCostoFleteMV * $unidadesFleteMV);
        $profitFlete = $ventatotal - $costototal;
        $comiflete = $profitFlete * .10;
        $profitFlete = $profitFlete - $comiflete;
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("UPDATE servicio_flete_venta_truck
                                SET origen=:origen, 
                                    destino=:destino, 
                                    tarifa_venta=:tarifaventa, 
                                    tarifa_costo=:tarifacosto, 
                                    unidades=:unidades, 
                                    total_venta=:totalventa, 
                                    total_costo=:totalcosto, 
                                    profit=:profit, 
                                    hora_posicionamiento=:horaposicionamiento, 
                                    id_moneda=:idmoneda, 
                                    comision=:comision, 
                                    dias_libres=:diaslibres, 
                                    fecha_posicion=:fechaposicion,   
                                    id_tipo_carga=:idtipocarga,
                                    id_tipo_unidad=:id_tipo_unidad
                                WHERE id_servicio_flete=:id_servicio_flete;");

            $rsp->bindParam(":origen", $origenFleteMV);
            $rsp->bindParam(":destino", $desitinoFleteMV);
            $rsp->bindParam(":tarifaventa", $tarifaVentaFleteMV);
            $rsp->bindParam(":tarifacosto", $tarifaCostoFleteMV);
            $rsp->bindParam(":unidades", $unidadesFleteMV);
            $rsp->bindParam(":totalventa", $ventatotal);
            $rsp->bindParam(":totalcosto", $costototal);
            $rsp->bindParam(":profit", $profitFlete);
            $rsp->bindParam(":horaposicionamiento", $horaFleteMV);
            $rsp->bindParam(":idmoneda", $monedaFleteMV);
            $rsp->bindParam(":comision", $comiflete);
            $rsp->bindParam(":diaslibres", $diaslibreFleteMV);
            $rsp->bindParam(":fechaposicion", $fechaPosFleteMV);
            $rsp->bindParam(":idtipocarga", $tipocargaFleteMV);
            $rsp->bindParam(":id_servicio_flete", $idfleteadicionalm);
            $rsp->bindParam(":id_tipo_unidad", $tipounidadFleteVenta);
            $rsp->execute();
            
            if ($rsp !== false) {
                $json = array();
                $json['id_servicio_flete'] = $idfleteadicionalm;
                $json['mensaje'] = "Flete  Actualizado con exito";
                return $json;
            }
        } catch (\Throwable $th) {
            $json = array();
            $json['id_servicio_flete'] = 0;
            $json['mensaje'] = "Error al actualizar Flete" . $th->getMessage();
            return $json;
            //return $th->getMessage();
        }
    }
    public function listarFletes($idventa)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT FV.id_servicio_flete, 
                                    FV.id_venta, 
                                    FV.origen, 
                                    FV.destino, 
                                    FV.tarifa_venta, 
                                    FV.tarifa_costo, 
                                    FV.unidades, 
                                    FV.total_venta, 
                                    FV.total_costo, 
                                    FV.profit, 
                                    FV.hora_posicionamiento, 
                                    FV.id_moneda,
                                    m2.signo,
                                    FV.comision,
                                    CASE WHEN fecha_posicion = '0000-00-00' THEN '' ELSE IFNULL( date_format(fecha_posicion,'%Y-%m-%d'),'') END AS fecha_posicion,
                                    FV.dias_libres,
                                    FV.id_tipo_carga,
                                    TC.nombre as tipocarga,
                                    FV.id_tipo_unidad,
                                    TU.nombre as tipounidad
                                FROM servicio_flete_venta_truck  FV INNER JOIN 
                                    moneda m2 on m2.id_moneda  = FV.id_moneda left join 
                                    tipo_carga_empresa as TC on TC.id_tipo_carga_empresa=FV.id_tipo_carga left join
                                    tipo_unidades_truc as TU on TU.idtipo_unidades =  FV.id_tipo_unidad
                                WHERE id_venta= :idventa ");
            $rsp->bindParam(":idventa", $idventa);
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
    public function listarFlete($idfleteadicionalm)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT FV.id_servicio_flete, 
                                    FV.id_venta, 
                                    FV.origen, 
                                    FV.destino, 
                                    FV.tarifa_venta, 
                                    FV.tarifa_costo, 
                                    FV.unidades, 
                                    FV.total_venta, 
                                    FV.total_costo, 
                                    FV.profit, 
                                    FV.hora_posicionamiento, 
                                    FV.id_moneda,
                                    m2.signo,
                                    FV.comision,
                                    CASE WHEN fecha_posicion = '0000-00-00' THEN '' ELSE IFNULL( date_format(fecha_posicion,'%Y-%m-%d'),'') END AS fecha_posicion,
                                    FV.dias_libres,
                                    FV.id_tipo_carga,
                                    TC.nombre as tipocarga,
                                    FV.id_tipo_unidad,
                                    TU.nombre as tipounidad
                                FROM servicio_flete_venta_truck  FV INNER JOIN 
                                    moneda m2 on m2.id_moneda  = FV.id_moneda left join 
                                    tipo_carga_empresa as TC on TC.id_tipo_carga_empresa=FV.id_tipo_carga left join
                                    tipo_unidades_truc as TU on TU.idtipo_unidades =  FV.id_tipo_unidad
                                WHERE id_servicio_flete= :id_servicio_flete ");
            $rsp->bindParam(":id_servicio_flete", $idfleteadicionalm);
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
public function  anularFlete($idfleteadicionalm){
    $con = Conexion::getConexion();
    try {
        $rsp = $con->prepare("DELETE FROM servicio_flete_venta_truck
                                WHERE id_servicio_flete=:idflete");
        $rsp->bindParam(":idflete", $idfleteadicionalm);
        $rsp->execute();
        if ($rsp !== false) {
            $json = array();
            $json['id_servicio_flete'] = $idfleteadicionalm;
            $json['mensaje'] = "Flete Anulado con exito";
            return $json;
        }
    } catch (\Throwable $th) {
        $json = array();
        $json['id_servicio_flete'] = 0;
        $json['mensaje'] = "Error al Anular Flete" . $th->getMessage();
        return $json;
        //return $th->getMessage();
    }
}
    public function listarProductos($idventa)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT id_producto, 
                                        codigo_producto, 
                                        descripcion, 
                                        volumen, 
                                        peso, 
                                        bultos, 
                                        peso_bultos, 
                                        id_venta_truck
                                    FROM productos_venta_truck
                                    WHERE id_venta_truck=:idventa");
            $rsp->bindParam(":idventa", $idventa);
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
