<?php
session_start();
include_once "../config/Conexion.php";

class calculoAlmacen
{

    public function __construct()
    {
    }
    public function grabarCalculo($idcliente, $idplantilla, $iddetalleAlmacen, $direccion, $nit, $totaldias, $diasAlma, $diasl, $del, $al, $dut, $polizaSalida, $ordenSalida, $tipoCambio, $cifDolares, $cif, $impuesto, $baseSeguro, $bultosRetirados, $peso, $volumen, $cntClientes, $cntCuadrilla, $descuentoP, $descuentoValor, $financiacionV, $financiacionP, $aplicaF, $subtotal, $iva, $exentoIva, $total, $isr, $alcaldia, $iddetalle, $valor, $descuentos, $ivas, $signo, $valorSumar, $ocultar, $prorratear)
    {

        $del = date("Y-m-d", strtotime($del));
        $al = date("Y-m-d", strtotime($al));

        $con = Conexion::getConexion();
        try {
            $con->beginTransaction();
            $rspt = $con->prepare("INSERT INTO calculo_almacen (id_usuario, id_cliente, id_plantilla, id_detalle_almacen, direccion, identificacion, total_dias, dias_almacen, dias_libres, del, al, dut, poliza_salida, orden_salida, tipo_cambio, cif_dolares, cif,impuesto, base_seguro, bultos_retirados, peso, volumen, cnt_clientes, cnt_cuadrilla, id_descuento, descuento_valor, financiacion_valor, financiacion_porcentaje, aplica_financiacion, subtotal, iva, exento_iva, total,isr,alcaldia)
                            values(:id_usuario,:id_cliente,:id_plantilla,:id_detalle_almacen,:direccion,:identificacion,:total_dias,:dias_almacen,:dias_libres,:del,:al,:dut,:poliza_salida,:orden_salida,:tipo_cambio,:cif_dolares,:cif,:impuesto,:base_seguro,:bultos_retirados,:peso,:volumen,:cnt_clientes,:cnt_cuadrilla,:id_descuento,:descuento_valor,:financiacion_valor,:financiacion_porcentaje,:aplica_financiacion,:subtotal,:iva,:exento_iva,:total,:isr,:alcaldia)");
            $rspt->bindParam(":id_usuario", $_SESSION["idusuario"]);
            $rspt->bindParam(":id_cliente", $idcliente);
            $rspt->bindParam(":id_plantilla", $idplantilla);
            $rspt->bindParam(":id_detalle_almacen", $iddetalleAlmacen);
            $rspt->bindParam(":direccion", $direccion);
            $rspt->bindParam(":identificacion", $nit);
            $rspt->bindParam(":total_dias", $totaldias);
            $rspt->bindParam(":dias_almacen", $diasAlma);
            $rspt->bindParam(":dias_libres", $diasl);
            $rspt->bindParam(":del", $del);
            $rspt->bindParam(":al", $al);
            $rspt->bindParam(":dut", $dut);
            $rspt->bindParam(":poliza_salida", $polizaSalida);
            $rspt->bindParam(":orden_salida", $ordenSalida);
            $rspt->bindParam(":tipo_cambio", $tipoCambio);
            $rspt->bindParam(":cif_dolares", $cifDolares);
            $rspt->bindParam(":cif", $cif);
            $rspt->bindParam(":impuesto", $impuesto);
            $rspt->bindParam(":base_seguro", $baseSeguro);
            $rspt->bindParam(":bultos_retirados", $bultosRetirados);
            $rspt->bindParam(":peso", $peso);
            $rspt->bindParam(":volumen", $volumen);
            $rspt->bindParam(":cnt_clientes", $cntClientes);
            $rspt->bindParam(":cnt_cuadrilla", $cntCuadrilla);
            $rspt->bindParam(":id_descuento", $descuentoP);
            $rspt->bindParam(":descuento_valor", $descuentoValor);
            $rspt->bindParam(":financiacion_valor", $financiacionV);
            $rspt->bindParam(":financiacion_porcentaje", $financiacionP);
            $rspt->bindParam(":aplica_financiacion", $aplicaF);
            $rspt->bindParam(":subtotal", $subtotal);
            $rspt->bindParam(":iva", $iva);
            $rspt->bindParam(":exento_iva", $exentoIva);
            $rspt->bindParam(":total", $total);
            $rspt->bindParam(":isr", $isr);
            $rspt->bindParam(":alcaldia", $alcaldia);
            $rspt->execute();

            if ($rspt) {
                $id_calculo =   $con->lastInsertId();
                $cont = 0;
                $ocultarchk = 0;
                $prorratearchk =0;
                //```````````````descuento```
                if (count($iddetalle) > 0) {
                    $rspt = $con->prepare("INSERT INTO detalle_calculo(id_calculo,id_detalle_plantilla,signo,valor,otro_valor,ocultar,prorratear,descuento,iva)
                        VALUES (:id_calculo,:id_detalle_plantilla,:signo,:valor,:otro_valor,:ocultar,:prorratear,:descuento,:iva)");
                    // $contador = count($iddetalle);
                    //echo $contador;
                    while ($cont < count($iddetalle)) {
                        if (in_array($iddetalle[$cont], $ocultar)) {
                            $ocultarchk = 1;
                        } else {
                            $ocultarchk =0;
                        }
            
                        if (in_array($iddetalle[$cont], $prorratear)) {
                            $prorratearchk = 1;
                        } else {
                            $prorratearchk = 0;
                        }
                        $rspt->bindParam(":id_calculo", $id_calculo);
                        $rspt->bindParam(":id_detalle_plantilla", $iddetalle[$cont]);
                        $rspt->bindParam(":signo", $signo[$cont]);
                        $rspt->bindParam(":valor", $valor[$cont]);
                        $rspt->bindParam(":otro_valor", $valorSumar[$cont]);
                        $rspt->bindParam(":ocultar", $ocultarchk/* $ocultar[$cont] */);
                        $rspt->bindParam(":prorratear", $prorratearchk /* $prorratear[$cont] */);
                        $rspt->bindParam(":descuento", $descuentos[$cont]);
                        $rspt->bindParam(":iva", $ivas[$cont]);
                        $rspt->execute();
                        $cont++;
                    }
                }
            }
            $con->commit();
            //$con = Conexion::cerrar();
            return 1;
        } catch (\Throwable $th) {
            $con->rollBack();
            //$con = Conexion::cerrar();
            return 0;
        }
    }
    function llenacntCalculos($iddetalleA)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT CA.id_calculo  
                                    FROM  calculo_almacen AS CA 
                                    WHERE id_detalle_almacen= :iddetalleA");
            $rsp->bindParam(":iddetalleA", $iddetalleA);
            $rsp->execute();
            $rsp = $rsp->fetchAll(PDO::FETCH_OBJ);
            if ($rsp) {
                return $rsp;
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }
    function buscaCalculoid($id_calculo){
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT id_calculo, 
                                        id_usuario,
                                        id_cliente,
                                        id_plantilla,
                                        id_detalle_almacen,
                                        direccion,
                                        identificacion,
                                        total_dias,
                                        dias_almacen,
                                        dias_libres,
                                        DATE_FORMAT(del, '%m/%d/%Y') as del,
                                        DATE_FORMAT(al, '%m/%d/%Y') as al,
                                        dut,
                                        poliza_salida,
                                        orden_salida,
                                        tipo_cambio,
                                        cif_dolares,
                                        cif,
                                        impuesto,
                                        base_seguro,
                                        bultos_retirados,
                                        peso,
                                        volumen,
                                        cnt_clientes,
                                        cnt_cuadrilla,
                                        id_descuento,
                                        descuento_valor,
                                        financiacion_valor,
                                        financiacion_porcentaje,
                                        aplica_financiacion,
                                        subtotal,
                                        iva,
                                        exento_iva,
                                        total,
                                        isr,
                                        alcaldia
                                    FROM calculo_almacen 
                                WHERE id_calculo= :id_calculo");
            $rsp->bindParam(":id_calculo",$id_calculo);
            $rsp->execute();
            $rsp = $rsp->fetch(PDO::FETCH_OBJ);
            if ($rsp){
                return $rsp;
            }
            else {
                $json = array();
                $json['id_calculo'] = 0;
                return $json;
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }
    public function buscaDetalleCalculo($idcalculo){
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT DCA.id_detalle_plantilla,
                                        DCA.signo,
                                        DCA.valor,
                                        DCA.otro_valor,
                                        DCA.ocultar,
                                        DCA.prorratear,
                                        DCA.descuento,
                                        DCA.iva,
                                        CAT.nombre 
                                    FROM  calculo_almacen AS CA INNER JOIN  
                                        detalle_calculo AS DCA ON DCA.id_calculo = CA.id_calculo INNER JOIN 
                                        detalle_plantillaa AS DTP ON DTP.id_detalle = DCA.id_detalle_plantilla INNER JOIN 
                                        catalogo  as CAT  ON CAT.id_catalogo = DTP.id_catalogo
                                    WHERE CA.id_calculo = :id_calculo");
            $rsp->bindParam(":id_calculo",$idcalculo);                        
            $rsp->execute();
            $rsp = $rsp->fetchAll(PDO::FETCH_OBJ);
            if ($rsp){
                return $rsp;
            }else {
                return 0;
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }
    public function editarDAlmacen($iddetalleA, $idcliente, $nohbl, $ubicacion, $peso, $volumen, $dut, $bultos, $embalajeD, $liberado, $resa, $dti, $ncancel, $norden, $mercaderia, $observaciones, $linea)
    {
        $fechaM = date("Y-m-d");

        $con = Conexion::getConexion();
        try {
            $stmt = $con->prepare("UPDATE detalle_almacen 
                    SET id_cliente=:idcliente,
                        id_embalaje=:idembalaje,
                        peso=:peso,
                        volumen=:volumen,
                        bultos=:bultos,
                        nohbl=:nohbl,
                        ubicacion=:ubicacion,
                        linea=:linea,
                        resa=:resa,
                        dti=:dti,
                        no_cancel=:no_cancel,
                        no_orden=:no_orden,
                        liberado=:liberado,
                        dut=:dut,
                        mercaderia=:mercaderia,
                        observaciones=:observaciones,
                        fecha_modificacion=:fechaM,
                        id_usuario_modifica=:idusuarioM
                    WHERE id_detalle=:iddetallea");

            $stmt->bindParam(":idcliente", $idcliente);
            $stmt->bindParam(":idembalaje", $embalajeD);
            $stmt->bindParam(":peso", $peso);
            $stmt->bindParam(":volumen", $volumen);
            $stmt->bindParam(":bultos", $bultos);
            $stmt->bindParam(":nohbl", $nohbl);
            $stmt->bindParam(":ubicacion", $ubicacion);
            $stmt->bindParam(":linea", $linea);
            $stmt->bindParam(":resa", $resa);
            $stmt->bindParam(":dti", $dti);
            $stmt->bindParam(":no_cancel", $ncancel);
            $stmt->bindParam(":no_orden", $norden);
            $stmt->bindParam(":liberado", $liberado);
            $stmt->bindParam(":dut", $dut);
            $stmt->bindParam(":mercaderia", $mercaderia);
            $stmt->bindParam(":observaciones", $observaciones);
            $stmt->bindParam(":fechaM", $fechaM);
            $stmt->bindParam(":idusuarioM", $_SESSION["idusuario"]);
            $stmt->bindParam(":iddetallea", $iddetalleA);
            $stmt->execute();
            if ($stmt !== false) {
                return $iddetalleA;
            } else {
                return 0;
            }
        } catch (\Throwable $th) {
            // echo $th->getMessage();
            return 0;
        }
    }
    public function listar($idalmacen)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT DA.id_detalle, 
                                        DA.id_almacen, 
                                        DA.estado,
                                        CL.Razons as cliente,  
                                        DA.nohbl,
                                        DA.peso, 
                                        DA.volumen, 
                                        DA.bultos,
                                        DA.ubicacion, 
                                        E.nombre as empaque, 
                                        DA.dut,
                                        DA.liberado,
                                        DA.linea, 
                                        DA.resa, 
                                        DA.dti, 
                                        DA.no_cancel, 
                                        DA.no_orden, 
                                        DA.mercaderia, 
                                        DA.observaciones
                                    FROM detalle_almacen AS DA INNER JOIN  
                                    empaque AS E ON E.id_empaque = DA.id_embalaje INNER JOIN 
                                    empresas AS CL ON CL.id_empresa = DA.id_cliente 
                                WHERE id_almacen = :idalmacen");
            $rsp->bindParam(":idalmacen", $idalmacen);
            $rsp->execute();
            $rsp = $rsp->fetchAll(PDO::FETCH_OBJ);
            return $rsp;
            $con = Conexion::cerrar();
        } catch (\Throwable $th) {
            //throw $th;
        }
    }
    public function MostrarNuevoCalculo($iddetallea)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT 
                                    DA.id_detalle, 
                                    DA.id_cliente,  
                                    DA.peso, 
                                    DA.volumen, 
                                    DA.bultos,
                                    DA.dut,
                                    DA.liberado,
                                    A.poliza,
                                    A.cant_clientes,
                                    DATE_FORMAT(A.fecha_almacen, '%m/%d/%Y') as fechaI,
                                    DA.id_cliente,
                                    (select financiacion 
                                            from sucursal as s 
                                        where s.id_sucursal = A.id_sucursal) as financiacion
                            FROM detalle_almacen as DA INNER JOIN 
                                almacen as A ON A.id_almacen = DA.id_almacen
                        where DA.id_detalle = :id_detalle");
            $rsp->bindParam(":id_detalle", $iddetallea);
            $rsp->execute();
            $rsp = $rsp->fetch(PDO::FETCH_OBJ);
            if ($rsp) {
                return $rsp;
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }
    public function listarCliente($iddetalleA)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT EM.Razons,
                                        EM.id_empresa
                                        FROM empresas  AS EM
                                    WHERE EM.id_empresa IN (
            
                                        SELECT E.id_empresa 
                                            FROM (
                                                SELECT  AL.id_consignado AS id_empresa
                                                FROM almacen AS AL INNER JOIN 
                                                    detalle_almacen AS DA ON DA.id_almacen = AL.id_almacen
                                                WHERE DA.id_detalle = :iddetalle	
                                                GROUP BY AL.id_consignado
                                                    UNION ALL 
                                                SELECT  DA.id_cliente AS id_empresa
                                                FROM almacen AS AL INNER JOIN 
                                                    detalle_almacen AS DA ON DA.id_almacen = AL.id_almacen
                                                WHERE DA.id_detalle = :iddetalle	
                                                GROUP BY DA.id_cliente
                                    ) AS E						
                                )");
            $rsp->bindParam(":iddetalle", $iddetalleA);
            $rsp->execute();
            $rsp = $rsp->fetchAll(PDO::FETCH_OBJ);
            if ($rsp) {
                return $rsp;
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }
    public function datosCliente($idcliente)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT C.direccion,
                                        C.identificacion,
                                        C.id_empresa 
                                FROM empresas AS C  
                                    WHERE C.id_empresa = :idcliente ");
            $rsp->bindParam(":idcliente", $idcliente);
            $rsp->execute();
            $rsp = $rsp->fetch(PDO::FETCH_OBJ);
            if ($rsp) {
                return $rsp;
            } else {
                return  $rsp = 0;
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }
    public function mostrarPlantillaCalcular($idplantilla)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT C.nombre,
                                    DP.minimo,
                                    DP.tarifa,
                                    DP.porcentaje,
                                    DP.por_peso,
                                    DP.por_volumen,
                                    DP.por_dia,
                                    MO.signo,
                                    P.omitir_almacenaje as OA,
                                    P.dias_libres,
                                    DP.id_detalle,
                                    C.id_catalogo
                                FROM plantilla_calculoa AS P INNER JOIN 
                                        detalle_plantillaa AS DP ON DP.id_plantilla = P.id_plantilla INNER JOIN 
                                        catalogo AS C ON C.id_catalogo = DP.id_catalogo INNER JOIN 
                                        moneda as MO on MO.id_moneda = DP.id_moneda
                                    WHERE P.id_plantilla =:idplantilla");
            $rsp->bindParam(":idplantilla", $idplantilla);
            $rsp->execute();
            $rsp = $rsp->fetchALL(PDO::FETCH_OBJ);
            if ($rsp) {
                return $rsp;
            } else {
                return  $rsp = array();
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }

    public function mostrarDetalleplantillCalculando($iddetalle)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT C.nombre,
                                    DP.minimo,
                                    DP.tarifa,
                                    DP.porcentaje,
                                    DP.por_peso,
                                    DP.por_volumen,
                                    DP.por_dia,
                                    MO.signo,
                                    P.omitir_almacenaje as OA,
                                    P.dias_libres,
                                    DP.id_detalle
                                FROM plantilla_calculoa AS P INNER JOIN 
                                        detalle_plantillaa AS DP ON DP.id_plantilla = P.id_plantilla INNER JOIN 
                                        catalogo AS C ON C.id_catalogo = DP.id_catalogo INNER JOIN 
                                        moneda as MO on MO.id_moneda = DP.id_moneda
                                    WHERE DP.id_detalle =:iddetalle");
            $rsp->bindParam(":iddetalle", $iddetalle);
            $rsp->execute();
            $rsp = $rsp->fetch(PDO::FETCH_OBJ);
            if ($rsp) {
                return $rsp;
            } else {
                return  $rsp = 0;
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }

    public function calculosDescripciones($descripcion, $minimo, $tarifa, $porcentaje, $impuesto, $diasAlma, $diascompletos, $diasl, $baseParaS, $totaldias, $peso, $tipocambio, $cif, $otrovalor,$descuentos)
    {
        if ($_SESSION["idpais"] == 92) {
            if ($descripcion == "Almacenaje") {
                $res = self::Almacengt($minimo, $porcentaje, $impuesto, $diasAlma);
                return $res;
            } else if ($descripcion == "Seguro") {
                return $res = self::SeguroGT($minimo, $porcentaje, $baseParaS, $totaldias);
            } else if ($descripcion == "Manejo")
                return $res = self::manejoGT($peso, $tarifa, $minimo);
            else {
                return 0;
            }
        } //fin guatemala
        else if ($_SESSION["idpais"] == 59) {
            if ($descripcion == "Almacenaje") {
                return self::almacenajeCR($tarifa, $baseParaS, $diasAlma, $minimo, $otrovalor,$descuentos);
            } else if ($descripcion == "Almacenaje Adicional") {
                return self::almacenajeAdicionalCR($diasAlma, $tipocambio, $otrovalor);
            } else if ($descripcion == "Manejo") {
                return self::manejoCR($tarifa, $peso, $minimo, $otrovalor);
            } else if ($descripcion == "Seguro") {
                return self::seguroCR($diasAlma, $tarifa, $minimo, $baseParaS, $otrovalor);
            } else if ($descripcion == "Precintos") {
                return self::precintosCR($tarifa, $otrovalor);
            } else {
                return 0;
            }
        } // fin costarica 

        else if ($_SESSION["idpais"] == 157) {
            if ($descripcion == "Almacenaje") {
                return self::almacenajeNI($minimo, $porcentaje, $cif, $diascompletos, $diasAlma);
            }
        } // fin nicaragua
    }

    //gt formulas
    public static function Almacengt($minimo, $porcentaje, $impuesto, $diasAlma)
    {

        if ($impuesto == "") {
            $impuesto = 0;
        }
        if ($diasAlma == "") {
            $diasAlma = 0;
        }
        $res = ($impuesto * ($porcentaje / 100)) * $diasAlma;
        if ($res < $minimo) {
            $res = $minimo;
        }

        return redondear10($res);
    }
    public static function gastosGT($minimo, $diasAlma, $cif, $porcentaje)
    {
        if ($diasAlma == "") {
            $diasAlma = 0;
        }

        $res = (($cif * ($porcentaje / 100)) / 30) * $diasAlma;
        if ($res < $minimo) {
            $res = $minimo;
        }
        return redondear10($res);
    }

    public static function manejoGT($peso, $tarifa, $minimo)
    {
        /*     r = (Round((peso / 1000) + 0.5)) * 1000
        r = Round(r)
        res = (r * CDbl(Me.grid.Columns(4).Value)) / 1000 */
        //revisar formulara todos deben de subir a mayor 10 
        $multiplo = (round(($peso / 1000) + 0.5)) * 1000;
        $res = ($multiplo * $tarifa) * 1000;
        if ($res < $minimo) {
            $res = $minimo;
        }
        return $minimo;
    }
    public static function TransmisionGT($baseParaS, $minimo, $cantCli)
    {
        $res = ($baseParaS / $cantCli);
        if ($res < $minimo) {
            $res = $minimo;
        }
        return $res;
    }
    public static function descargaGT()
    {
    }

    public static function SeguroGT($minimo, $porcentaje, $baseParaS, $totaldias)
    {
        if ($totaldias == "") {
            $totaldias = 0;
        }
        $res  = ($baseParaS * (($porcentaje / 100)) / 365) * $totaldias;
        if ($res < $minimo) {
            $res = $minimo;
        }
        return $res;
    }

    // costarica formulas
    public static function almacenajeCR($tarifa, $baseParaS, $diasAlma, $minimo, $otrovalor,$descuentos)
    {
        //$json = array();
        if ($descuentos == ""){
            $descuentos = 0;
        }
        $res = $tarifa * ($baseParaS / 1000) * ($diasAlma / 30);
        if ($res < $minimo) {
            $res = $minimo;
        }
        if ($descuentos >0){
            $res = ceil($res-(($descuentos/100)* $res));
        }
        //return $res;
        $iva = ($res + $otrovalor) * $_SESSION["Impuesto"];
        $iva = ceil($iva);

        $json = array();
        $json['iva'] = $iva;
        $json['valor'] = redondear_dos_decimal($res);
        return $json;
    }

    public static function almacenajeAdicionalCR($diasAlma, $tipoCambio, $otrovalor)
    {
        $res = ($diasAlma - 10) * 3 * $tipoCambio;
        if ($res > 0) {
        } else {
            $res = 0;
        }
        $iva = ($res + $otrovalor) * $_SESSION["Impuesto"];

        $iva = ceil($iva);
        $json = array();
        $json['iva'] = $iva;
        $json['valor'] = $res;
        return $json;
    }

    public static function manejoCR($tarifa, $peso, $minimo, $otrovalor)
    {
        $res = $tarifa * $peso;
        if ($res < $minimo) {
            $res = $minimo;
        }

        $iva = ($res + $otrovalor) * $_SESSION["Impuesto"];
        $iva = ceil($iva);
        $json = array();
        $json['iva'] = $iva;
        $json['valor'] = $res;
        return $json;
    }

    public static function seguroCR($diasAlma, $tarifa, $minimo, $baseParaS, $otrovalor)
    {
        $res = $tarifa * ($baseParaS / 1000) * ($diasAlma / 30);
        if ($res < $minimo) {
            $res = $minimo;
        }

        $iva = ($res + $otrovalor) * $_SESSION["Impuesto"];
        $iva = ceil($iva);
        $json = array();
        $json['iva'] = $iva;
        $json['valor'] = $res;
        return $json;
    }
    // precintos cr
    public static function precintosCR($tarifa, $otrovalor)
    {
        $res = $tarifa;

        $iva = ($res + $otrovalor) * $_SESSION["Impuesto"];
        $iva = ceil($iva);
        $json = array();
        $json['iva'] = $iva;
        $json['valor'] = $res;
        return $json;
    }
    // nicaragua
    public static function almacenajeNI($minimo, $porcentaje, $cif, $diascompletos, $diasAlma)
    {
        $res = 0;
        if ($diascompletos == 1) {
            $res = $minimo;
        } else {
            $res = ($cif * $porcentaje) * ceil(($diasAlma / 15));
            if ($res < $minimo) {
                $res = $minimo;
            }
        }
        return $res;
    }
}//final de la clase 