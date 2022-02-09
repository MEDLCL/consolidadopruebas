<?php
session_start();
include_once "../config/Conexion.php";
class Empresa
{
    //|representante_legal|dias_credito|cuenta_Bancaria|para_cheque|id_moneda_pago
    public function __construct()
    {
    }
    public function grabar($codigo, $tipoe, $razons, $nombrec, $nit, $telefono, $dire, $comision, $cbmtarifa, $nombres, $apellidos, $correos, $telefonos, $puestos,$idpaisEmpresa,$giroN,$tipoCarga,$tamanoEmp,$canalD,$representanteL,$diasc,$cuentaB,$paraChe,$id_MonedaP)
    {

        $con = Conexion::getConexion();
        try {
            $con->beginTransaction();
            $rspt = $con->prepare("INSERT INTO empresas (codigo,Tipoe,id_sucursal,id_usuario,Razons,Nombrec,identificacion,telefono,direccion,porcentaje_comision,tipo_comision,id_pais,id_giro_negocio,id_tipo_carga,id_tamano_empresa,id_canal_distribucion,id_aslo,representante_legal,dias_credito,cuenta_Bancaria,para_cheque,id_moneda_pago)
                            values(:codigo,:tipoe,:idsucursal,:idusuario,:razons,:nombrec,:nit,:telefono,:dire,:comision,:cbmtarifa,:idpais,:id_giro_negocio,:id_tipo_carga,:id_tamano_empresa,:id_canal_distribucion,:id_aslo,:representanteL,:diasCre,:cuentaBan,:parache,:idmonedaPA)");
            $rspt->bindParam(":codigo", $codigo);
            $rspt->bindParam(":tipoe", $tipoe);
            $rspt->bindParam(":idsucursal", $_SESSION['idsucursal']);
            $rspt->bindParam(":idusuario", $_SESSION['idusuario']);
            $rspt->bindParam(":razons", $razons);
            $rspt->bindParam(":nombrec", $nombrec);
            $rspt->bindParam(":nit", $nit);
            $rspt->bindParam(":telefono", $telefono);
            $rspt->bindParam(":dire", $dire);
            $rspt->bindParam(":comision", $comision);
            $rspt->bindParam(":cbmtarifa", $cbmtarifa);
            $rspt->bindParam(":idpais",$idpaisEmpresa);
            $rspt->bindParam(":id_giro_negocio",$giroN);
            $rspt->bindParam(":id_tipo_carga",$tipoCarga);
            $rspt->bindParam(":id_tamano_empresa",$tamanoEmp);
            $rspt->bindParam(":id_canal_distribucion",$canalD);
            $rspt->bindParam(":id_aslo",$_SESSION['idusuario']);
            $rspt->bindParam(":representanteL",$representanteL);
            $rspt->bindParam(":diasCre",$diasc);
            $rspt->bindParam(":cuentaBan",$cuentaB);
            $rspt->bindParam(":parache",$paraChe);
            $rspt->bindParam(":idmonedaPA",$id_MonedaP);
            $rspt->execute();

            if ($rspt) {
                $idempresa =   $con->lastInsertId();
                $cont = 0;
                if (count($nombres) > 0) {
                    $rspt = $con->prepare("INSERT INTO contactos_e(id_empresa,nombre,apellido,correo,telefono,puesto)
                        VALUES (:idempresa,:nombre,:apellido,:correo,:telefono,:puesto)");
                    $contador = count($nombres);
                    //echo $contador;
                    while ($cont < count($nombres)) {
                        $rspt->bindParam(":idempresa", $idempresa);
                        $rspt->bindParam(":nombre", $nombres[$cont]);
                        $rspt->bindParam(":apellido", $apellidos[$cont]);
                        $rspt->bindParam(":correo", $correos[$cont]);
                        $rspt->bindParam(":telefono", $telefonos[$cont]);
                        $rspt->bindParam("puesto", $puestos[$cont]);
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
    public function editarE($idempresa,$codigo, $tipoe, $razons, $nombrec, $nit, $telefono, $dire, $comision, $cbmtarifa, $nombres, $apellidos, $correos, $telefonos, $puestos,$idpaisEmpresa,$giroN,$tipoCarga,$tamanoEmp,$canalD)
    {
        $con = Conexion::getConexion();
        try {
            $con->beginTransaction();
            $rspt = $con->prepare("UPDATE empresas SET
                                    codigo=:codigo,
                                    Razons=:razons,
                                    Nombrec=:nombrec,
                                    identificacion=:nit,
                                    telefono=:telefono,
                                    direccion=:dire,
                                    porcentaje_comision=:comision,
                                    tipo_comision=:cbmtarifa,
                                    id_pais=:idpais,
                                    id_giro_negocio=:id_giro_negocio,
                                    id_tipo_carga=:id_tipo_carga,
                                    id_tamano_empresa=:id_tamano_empresa,
                                    id_canal_distribucion=:id_canal_distribucion
                                    WHERE id_empresa = :idempresa");
            $rspt->bindParam(":codigo", $codigo);
            $rspt->bindParam(":razons", $razons);
            $rspt->bindParam(":nombrec", $nombrec);
            $rspt->bindParam(":nit", $nit);
            $rspt->bindParam(":telefono", $telefono);
            $rspt->bindParam(":dire", $dire);
            $rspt->bindParam(":comision", $comision);
            $rspt->bindParam(":cbmtarifa", $cbmtarifa);
            $rspt->bindParam(":idempresa", $idempresa);
            $rspt->bindParam(":idpais",$idpaisEmpresa);
            $rspt->bindParam(":id_giro_negocio",$giroN);
            $rspt->bindParam(":id_tipo_carga",$tipoCarga);
            $rspt->bindParam(":id_tamano_empresa",$tamanoEmp);
            $rspt->bindParam(":id_canal_distribucion",$canalD);
            $rspt->execute();
            if ($rspt) {
                $rspt = $con->prepare("DELETE FROM contactos_e where id_empresa= :idempresa");
                $rspt->bindParam(":idempresa", $idempresa);
                $rspt->execute();
                if ($rspt) {
                    $cont = 0;
                    if (count($nombres) > 0) {
                        $rspt = $con->prepare("INSERT INTO contactos_e(id_empresa,nombre,apellido,correo,telefono,puesto)
                        VALUES (:idempresa,:nombre,:apellido,:correo,:telefono,:puesto)");
                        $contador = count($nombres);
                        //echo $contador;
                        while ($cont < count($nombres)) {
                            $rspt->bindParam(":idempresa", $idempresa);
                            $rspt->bindParam(":nombre", $nombres[$cont]);
                            $rspt->bindParam(":apellido", $apellidos[$cont]);
                            $rspt->bindParam(":correo", $correos[$cont]);
                            $rspt->bindParam(":telefono", $telefonos[$cont]);
                            $rspt->bindParam("puesto", $puestos[$cont]);
                            $rspt->execute();
                            $cont++;
                        }
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
    public function buscaEmpresa($idempresa)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT * FROM empresas WHERE  id_empresa = :idempresa");
            $rsp->bindParam(":idempresa", $idempresa);
            $rsp->execute();
            $rsp = $rsp->fetch(PDO::FETCH_OBJ);
            return $rsp;
        } catch (\Throwable $th) {
            return 0;
        }
    }
    public function listar()
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT E.id_empresa, 
                                        E.Razons,
                                        E.Nombrec,
                                        E.identificacion,
                                        E.direccion,
                                        E.telefono, 
                                        E.Tipoe,
                                        E.codigo,
                                        E.estado,
                                        E.porcentaje_comision,
                                        E.tipo_comision,
                                        C.nombre, C.apellido, C.correo, C.telefono as tel, C.puesto,
                                        P.nombre as pais
                                FROM empresas as E LEFT JOIN 
                                    pais as P on P.idpais = E.id_pais LEFT JOIN
                                        contactos_e as C ON E.id_empresa = C.id_empresa 
                                WHERE Tipoe = :tipoe AND id_sucursal = :idsucursal
                                ORDER BY E.id_empresa ASC");
            $rsp->bindParam(":tipoe", $_SESSION['Iniciale']);
            $rsp->bindParam(":idsucursal", $_SESSION['idsucursal']);
            $rsp->execute();
            $rsp = $rsp->fetchAll(PDO::FETCH_OBJ);
            return $rsp;
        } catch (\Throwable $th) {
            return 0;
        }
    }
    public function listarcontacto($idempresa)
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
    public function  verificaempresa($razons, $nombrec)
    {
        try {
            $con = Conexion::getConexion();
            $rsp = $con->prepare("SELECT * FROM empresas 
                                WHERE (Razons = :razons OR Nombrec = :nombrec)
                                    and id_sucursal = :idsucursal");
            $rsp->bindParam(':razons', $razons);
            $rsp->bindParam(':nombrec', $nombrec);
            $rsp->bindParam(':idsucursal', $_SESSION['idsucursal']);
            $rsp->execute();
            $rsp = $rsp->fetch(PDO::FETCH_OBJ);
            if ($rsp) {
                return 2;
            } else {
                return 3;
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }
    public function verificaempresaU($razons, $nombrec, $idempresa)
    {
        try {
            $con = Conexion::getConexion();
            $rsp = $con->prepare("SELECT * FROM empresas 
                                WHERE (Razons = :razons OR Nombrec = :nombrec)
                                    and id_sucursal = :idsucursal
                                    and id_empresa<> :idempresa");
            $rsp->bindParam(':razons', $razons);
            $rsp->bindParam(':nombrec', $nombrec);
            $rsp->bindParam(':idsucursal', $_SESSION['idsucursal']);
            $rsp->bindParam(':idempresa', $idempresa);
            $rsp->execute();
            $rsp = $rsp->fetch(PDO::FETCH_OBJ);
            if ($rsp) {
                return 2;
            } else {
                return 3;
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }
    public function codigo($tipoe)
    {
        try {
            $con = Conexion::getConexion();
            $rspt = $con->prepare("SELECT COUNT(*) as total FROM empresas WHERE Tipoe = :tipoe and id_sucursal = :idsucursal");
            $rspt->bindParam(":tipoe",$tipoe);
            $rspt->bindParam(":idsucursal",$_SESSION['idsucursal']);
            $rspt->execute(); 
            $rspt= $rspt->fetch(PDO::FETCH_OBJ);
            if ($rspt){
                return $rspt->total+1;
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }
    public  function eliminarContacto($idcontacto){
        try {
            $con = Conexion::getConexion();
            $rspt = $con->prepare("DELETE FROM contactos_e WHERE id_contacto = :idcontacto");
            $rspt->bindParam(":idcontacto",$idcontacto);
            $rspt->execute();
            if ($rspt->rowCount()>0){
                return 1;
            }else{
                return 1;
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }
}
