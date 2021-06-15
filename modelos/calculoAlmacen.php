<?php
session_start();
include_once "../config/Conexion.php";

class calculoAlmacen
{

    public function __construct()
    {
    }
    public function grabar($idalmacen, $idcliente, $nohbl, $ubicacion, $peso, $volumen, $dut, $bultos, $embalajeD, $liberado, $resa, $dti, $ncancel, $norden, $mercaderia, $observaciones, $linea)
    {
        $fechaG = date("Y-m-d");
        $estado = 1;
        $con = Conexion::getConexion();
        try {
            $stmt = $con->prepare("INSERT INTO detalle_almacen(id_almacen, id_cliente,id_usuario,id_embalaje,peso,volumen,bultos, nohbl, estado, ubicacion, linea, resa, dti, no_cancel, no_orden, liberado, dut, mercaderia, observaciones, fecha_graba, fecha_modificacion, id_usuario_modifica)
                                VALUES (:idalmacen,:idcliente,:idusuario,:idembalaje,:peso,:volumen,:bultos,:nohbl,:estado,:ubicacion,:linea,:resa,:dti,:ncancel,:norden,:liberado,:dut,:mercaderia,:observaciones,:fechaG,:fechaM,:idusuarioM)");
            $stmt->bindParam(":idalmacen", $idalmacen);
            $stmt->bindParam(":idcliente", $idcliente);
            $stmt->bindParam(":idusuario", $_SESSION["idusuario"]);
            $stmt->bindParam(":idembalaje", $embalajeD);
            $stmt->bindParam(":peso", $peso);
            $stmt->bindParam(":volumen", $volumen);
            $stmt->bindParam(":bultos", $bultos);
            $stmt->bindParam(":nohbl", $nohbl);
            $stmt->bindParam(":peso", $peso);
            $stmt->bindParam(":volumen", $volumen);
            $stmt->bindParam(":bultos", $bultos);
            $stmt->bindParam(":estado", $estado);
            $stmt->bindParam(":ubicacion", $ubicacion);
            $stmt->bindParam(":linea", $linea);
            $stmt->bindParam(":resa", $resa);
            $stmt->bindParam(":dti", $dti);
            $stmt->bindParam(":ncancel", $ncancel);
            $stmt->bindParam(":norden", $norden);
            $stmt->bindParam(":liberado", $liberado);
            $stmt->bindParam(":dut", $dut);
            $stmt->bindParam(":mercaderia", $mercaderia);
            $stmt->bindParam(":observaciones", $observaciones);
            $stmt->bindParam(":fechaG", $fechaG);
            $stmt->bindParam(":fechaM", $fechaG);
            $stmt->bindParam(":idusuarioM", $_SESSION["idusuario"]);
            $stmt->execute();
            if ($stmt) {
                return $con->lastInsertId();
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
                                    DA.id_cliente
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
    public function datosCliente($idcliente){
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
                                    DP.id_detalle
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

    public function mostrarDetalleplantillCalculando($iddetalle){
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

    public function calculosDescripciones($descripcion,$minimo,$tarifa,$porcentaje,$impuesto,$diasAlma,$diascompletos,$diasl,$baseParaS,$totaldias,$peso,$tipocambio){
        if ($_SESSION["idpais"]==92){
            if ($descripcion== "Almacenaje"){
                $res = self::Almacengt($minimo,$porcentaje,$impuesto,$diasAlma);
                return $res;
            }else if ($descripcion == "Seguro"){
                return $res = self::SeguroGT($minimo,$porcentaje,$baseParaS,$totaldias);
            }else if ($descripcion=="Manejo")
                return $res = self::manejoGT($peso,$tarifa,$minimo);
            else{
                return 0;
            }
        }//fin guatemala
        else if ($_SESSION["idpais"]==59){
            if ($descripcion == "Almacenaje"){
                return self::almacenajeCR($tarifa,$baseParaS,$diasAlma,$minimo);
            }else if ($descripcion == "Almacenaje Adicional"){
                return self::almacenajeAdicionalCR($diasAlma,$tipocambio);
            }
        }// fin costarica 
    }
    public static function Almacengt($minimo,$porcentaje,$impuesto,$diasAlma){
        
        if ($impuesto == ""){
            $impuesto =0;
        }
        if ($diasAlma==""){
            $diasAlma = 0 ;
        }
        $res = ($impuesto*($porcentaje/100))*$diasAlma;
        if ($res<$minimo){
            $res = $minimo;
        }

        return redondear10($res);
    }
    public static function gastosGT($minimo,$diasAlma,$cif,$porcentaje){
        if ($diasAlma==""){
            $diasAlma =0;
        }

        $res= (($cif*($porcentaje/100))/30)*$diasAlma;
        if ($res<$minimo){
            $res = $minimo;
        }
        return redondear10($res);
    }

    public static function manejoGT($peso,$tarifa,$minimo){
    /*     r = (Round((peso / 1000) + 0.5)) * 1000
        r = Round(r)
        res = (r * CDbl(Me.grid.Columns(4).Value)) / 1000 */
    //revisar formulara todos deben de subir a mayor 10 
    $multiplo = (round(($peso/1000)+0.5)) *1000;
        $res = ($multiplo * $tarifa)*1000;
        if ($res<$minimo){
            $res = $minimo;
        }
        return $minimo;
    }
    public static function TransmisionGT($baseParaS,$minimo,$cantCli){
        $res = ($baseParaS /$cantCli);
        if ($res<$minimo){
            $res = $minimo;
        }
        return $res;
    }
    public static function descargaGT(){

    }

    public static function SeguroGT($minimo,$porcentaje,$baseParaS,$totaldias){
        if ($totaldias == ""){
            $totaldias = 0;
        }
        $res  = ($baseParaS * (($porcentaje/100))/365)*$totaldias;
        if ($res<$minimo){
            $res = $minimo;
        }
        return $res;

    }


public static function almacenajeCR($tarifa,$baseParaS,$diasAlma,$minimo){
    $res = $tarifa* ($baseParaS/1000)* ($diasAlma/30);
    if ($res <$minimo){
        $res = $minimo;
    }

    return $res;
}
public static function almacenajeAdicionalCR($diasAlma,$tipoCambio){
    $res = ($diasAlma-10)*3*$tipoCambio;
    return $res;
}
public static function manejoCR($tarifa,$peso,$minimo){
    $res = $tarifa*$peso;
    if ($res<$minimo){
        $res = $minimo;
    }
    return $res;
}
public static function seguroCR($diasAlma,$tarifa,$minimo,$baseParaS){
    $res = $tarifa*($baseParaS/1000)*($diasAlma/30);
    if ($res <$minimo){
        $res = $minimo;
    }
    return $res;
}

}//final de la clase 