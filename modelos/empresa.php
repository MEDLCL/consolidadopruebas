<?php
session_start();
include_once "../config/Conexion.php";
class Empresa
{
    //|representante_legal|dias_credito|cuenta_Bancaria|para_cheque|id_moneda_pago
    public function __construct()
    {
    }
    public function grabar($codigo, $tipoe, $razons, $nombrec, $nit, $telefono, $dire, $comision, $cbmtarifa, $nombres, $apellidos, $correos, $telefonos, $puestos, $idpaisEmpresa, $giroN, $tipoCarga, $tamanoEmp, $canalD, $representanteL, $diasc, $cuentaB, $paraChe, $id_MonedaP, $aniversarioCliente, $celularesc, $cumplec,$medioComunicacionC,$nombreSucursalM)
    {
        if ($aniversarioCliente <> "") {
            $aniversarioCliente =  date("Y-m-d", strtotime($aniversarioCliente));
        }
        $con = Conexion::getConexion();
        try {
            $con->beginTransaction();
            $rspt = $con->prepare("INSERT INTO empresas (codigo,Tipoe,id_sucursal,id_usuario,Razons,Nombrec,identificacion,telefono,direccion,porcentaje_comision,tipo_comision,id_pais,id_giro_negocio,id_tipo_carga,id_tamano_empresa,id_canal_distribucion,id_aslo,representante_legal,dias_credito,cuenta_Bancaria,para_cheque,id_moneda_pago,aniversario)
                            values(:codigo,:tipoe,:idsucursal,:idusuario,:razons,:nombrec,:nit,:telefono,:dire,:comision,:cbmtarifa,:idpais,:id_giro_negocio,:id_tipo_carga,:id_tamano_empresa,:id_canal_distribucion,:id_aslo,:representanteL,:diasCre,:cuentaBan,:parache,:idmonedaPA,:aniversario)");
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
            $rspt->bindParam(":idpais", $idpaisEmpresa);
            $rspt->bindParam(":id_giro_negocio", $giroN);
            $rspt->bindParam(":id_tipo_carga", $tipoCarga);
            $rspt->bindParam(":id_tamano_empresa", $tamanoEmp);
            $rspt->bindParam(":id_canal_distribucion", $canalD);
            $rspt->bindParam(":id_aslo", $_SESSION['idusuario']);
            $rspt->bindParam(":representanteL", $representanteL);
            $rspt->bindParam(":diasCre", $diasc);
            $rspt->bindParam(":cuentaBan", $cuentaB);
            $rspt->bindParam(":parache", $paraChe);
            $rspt->bindParam(":idmonedaPA", $id_MonedaP);
            $rspt->bindParam(":aniversario", $aniversarioCliente);

            $rspt->execute();

            if ($rspt) {
                $idempresa =   $con->lastInsertId();
                $cont = 0;
                if (count($nombres) > 0) {
                    $rspt = $con->prepare("INSERT INTO contactos_e(id_empresa,nombre,apellido,correo,telefono,puesto,celular,cumpleanios,id_comunicacion)
                        VALUES (:idempresa,:nombre,:apellido,:correo,:telefono,:puesto,:celular,:cumpleanios,:idcomunicacion)");
                    //$cont = count($nombres);
                    //echo $contador;
                    while ($cont < count($nombres)) {
                        $rspt->bindParam(":idempresa", $idempresa);
                        $rspt->bindParam(":nombre", $nombres[$cont]);
                        $rspt->bindParam(":apellido", $apellidos[$cont]);
                        $rspt->bindParam(":correo", $correos[$cont]);
                        $rspt->bindParam(":telefono", $telefonos[$cont]);
                        $rspt->bindParam(":puesto", $puestos[$cont]);
                        $rspt->bindParam(":celular", $celularesc[$cont]);
                        $rspt->bindParam(":cumpleanios", $cumplec[$cont]);
                        $rspt->bindParam(":idcomunicacion", $medioComunicacionC[$cont]);                       
                        $rspt->execute();
                        $cont++;
                    }
                }
                $contSC =0;
                if (count($nombreSucursalM) > 0) {
                    $rspt = $con->prepare("INSERT INTO sucursal_empresa(id_empresa,nombre)
                        VALUES (:idempresa,:nombre)");
                    //$cont = count($nombres);
                    //echo $contador;
                    while ($cont < count($nombreSucursalM)) {
                        $rspt->bindParam(":idempresa", $idempresa);
                        $rspt->bindParam(":nombre", $nombreSucursalM[$cont]);                  
                        $rspt->execute();
                        $contSC++;
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
    public function editarE($idempresa, $codigo, $tipoe, $razons, $nombrec, $nit, $telefono, $dire, $comision, $cbmtarifa, $nombres, $apellidos, $correos, $telefonos, $puestos, $idpaisEmpresa, $giroN, $tipoCarga, $tamanoEmp, $canalD, $aniversarioCliente)
    {

        if ($aniversarioCliente <> "") {
            $aniversarioCliente =  date("Y-m-d", strtotime($aniversarioCliente));
        }
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
                                    id_canal_distribucion=:id_canal_distribucion,
                                    aniversario=:aniversario
                                    WHERE id_empresa = :idempresa");
            $rspt->bindParam(":codigo", $codigo);
            $rspt->bindParam(":razons", $razons);
            $rspt->bindParam(":nombrec", $nombrec);
            $rspt->bindParam(":nit", $nit);
            $rspt->bindParam(":telefono", $telefono);
            $rspt->bindParam(":dire", $dire);
            $rspt->bindParam(":comision", $comision);
            $rspt->bindParam(":cbmtarifa", $cbmtarifa);
            $rspt->bindParam(":idpais", $idpaisEmpresa);
            $rspt->bindParam(":id_giro_negocio", $giroN);
            $rspt->bindParam(":id_tipo_carga", $tipoCarga);
            $rspt->bindParam(":id_tamano_empresa", $tamanoEmp);
            $rspt->bindParam(":id_canal_distribucion", $canalD);
            $rspt->bindParam(":aniversario", $aniversarioCliente);
            $rspt->bindParam(":idempresa", $idempresa);
            $rspt->execute();

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
            $rsp = $con->prepare("SELECT id_empresa, 
                                        id_sucursal, 
                                        id_usuario, 
                                        id_pais, 
                                        Razons, 
                                        Nombrec, 
                                        identificacion, 
                                        direccion, 
                                        telefono, 
                                        Tipoe, 
                                        codigo, 
                                        estado, 
                                        porcentaje_comision, 
                                        tipo_comision, 
                                        fecha, 
                                        id_giro_negocio, 
                                        id_tamano_empresa, 
                                        id_tipo_carga, 
                                        id_canal_distribucion, 
                                        id_aslo, 
                                        representante_legal, 
                                        dias_credito, 
                                        cuenta_Bancaria, 
                                        para_cheque, 
                                        id_moneda_pago, 
                                        CASE WHEN aniversario = '0000-00-00' THEN '' ELSE IFNULL( date_format(aniversario,'%Y-%m-%d'),'') END AS aniversario
                                    FROM empresas WHERE  id_empresa = :idempresa");
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
                                        P.nombre as pais
                                FROM empresas as E LEFT JOIN 
                                    pais as P on P.idpais = E.id_pais
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
    public function grabarContacto($idempresa, $Nombre, $Apellido, $Correo, $telefonoc, $puesto, $celularclie, $cumpleContatoClie, $medioComunicacionCli)
    {
        $json = array();
        if ($cumpleContatoClie <> "") {
            $cumpleContatoClie =  date("Y-m-d", strtotime($cumpleContatoClie));
        }

        $con = Conexion::getConexion();
        try {
            $con->beginTransaction();
            $rspt = $con->prepare("INSERT INTO contactos_e(id_empresa,nombre,apellido,correo,telefono,puesto,celular,cumpleanios,id_comunicacion)
                        VALUES (:idempresa,:nombre,:apellido,:correo,:telefono,:puesto,:celular,:cumpleanios,:idcomunicacion)");
            $rspt->bindParam(":idempresa", $idempresa);
            $rspt->bindParam(":nombre", $Nombre);
            $rspt->bindParam(":apellido", $Apellido);
            $rspt->bindParam(":correo", $Correo);
            $rspt->bindParam(":telefono", $telefonoc);
            $rspt->bindParam(":puesto", $puesto);
            $rspt->bindParam(":celular", $celularclie);
            $rspt->bindParam(":cumpleanios", $cumpleContatoClie);
            $rspt->bindParam(":idcomunicacion", $medioComunicacionCli);
            $rspt->execute();

            
            $json['id_contacto'] = $con->lastInsertId();
            $json['mensaje']= "Contacto ingresado con exito";
            $con->commit(); 
            return $json;
        } catch (\Throwable $th) {
            $con->rollBack();
            $json['id_contacto'] = 0;
            $json['mensaje']= "Error al ingresar Contacto ".$th->getMessage();
            return $json;
        }
    }
    
    public function editarContacto($idcontacto,$Nombre,$Apellido,$Correo,$telefonoc,$puesto,$celularclie,$cumpleContatoClie,$medioComunicacionCli){
        if ($cumpleContatoClie <> "") {
            $cumpleContatoClie =  date("Y-m-d", strtotime($cumpleContatoClie));
        }
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("UPDATE contactos_e
                                    SET nombre=:nombre, 
                                        apellido=:apellido, 
                                        correo=:correo, 
                                        telefono=:telefono, 
                                        puesto=:puesto, 
                                        celular=:celular, 
                                        cumpleanios=:cumple, 
                                        id_comunicacion=:medioComunicacionCli
                                    WHERE id_contacto=:idcontacto");

            $rsp->bindParam(":nombre", $Nombre);
            $rsp->bindParam(":apellido", $Apellido);
            $rsp->bindParam(":correo", $Correo);
            $rsp->bindParam(":telefono", $telefonoc);
            $rsp->bindParam(":puesto", $puesto);
            $rsp->bindParam(":celular", $celularclie);
            $rsp->bindParam(":cumple", $cumpleContatoClie);
            $rsp->bindParam(":medioComunicacionCli", $medioComunicacionCli);
            $rsp->bindParam(":idcontacto", $idcontacto);
            $rsp->execute();
            if ($rsp !== false) {
                $json = array();
                $json['id_contacto'] = $idcontacto;
                $json['mensaje']= "Contacto Actualizado con exito";
                return $json;
            } 
        } catch (\Throwable $th) {
            $json = array();
            $json['id_contacto'] = 0;
            $json['mensaje']= "Error al ingresar Contacto ".$th->getMessage();
            return $json;
    }
}
    public function listarcontacto($idempresa)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT C.id_contacto,
                                    C.id_empresa,
                                    C.nombre,
                                    C.apellido,
                                    C.correo,
                                    C.telefono,
                                    C.puesto,
                                    C.celular,
                                    CASE WHEN cumpleanios = '0000-00-00' THEN '' ELSE IFNULL( date_format(cumpleanios,'%Y/%m/%d'),'') END AS cumpleanios,
                                    CP.nombre as omunicacion,
                                    CP.id_comunicacion
                        FROM contactos_e AS C LEFT JOIN 
                        comunicacionpreferida as CP on CP.id_comunicacion = C.id_comunicacion
                        WHERE id_empresa= :idempresa");
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

    public function mostrarContacto($idcontacto)
    {
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT C.id_contacto,
                                C.id_empresa,
                                C.nombre,
                                C.apellido,
                                C.correo,
                                C.telefono,
                                C.puesto,
                                C.celular,
                                CASE WHEN cumpleanios = '0000-00-00' THEN '' ELSE IFNULL(date_format(cumpleanios,'%Y-%m-%d'),'') END AS cumpleanios,
                                IFNULL(C.id_comunicacion,0)AS id_comunicacion
                    FROM contactos_e AS C 
                    WHERE id_contacto= :idcontacto");
            $rsp->bindParam(":idcontacto", $idcontacto);
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

    public function mostrarSucursal($idsucursalempresa){
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT id_sucursal_empresa, 
                                            nombre, 
                                            id_empresa
                                    FROM sucursal_empresa
                                    WHERE id_sucursal_empresa =:id_sucursal_empresa");
            $rsp->bindParam(":id_sucursal_empresa", $idsucursalempresa);
            $rsp->execute();
            $rsp = $rsp->fetch(PDO::FETCH_OBJ);
            if ($rsp) {
                return $rsp;
            } else {
                return array();
            }
        } catch (\Throwable $th) {
            return 0;
        } 
    }
    public function listarSucursales($idempresa){
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("SELECT id_sucursal_empresa, 
                                            nombre, 
                                            id_empresa
                                    FROM sucursal_empresa
                                    WHERE id_empresa =:idempresa");
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
    public function editarSucursal($id_sucursalCliente,$nombreSucursal){
        $con = Conexion::getConexion();
        try {
            $rsp = $con->prepare("UPDATE sucursal_empresa
                                    SET nombre=:nombre
                                    WHERE id_sucursal_empresa=:id_sucursal_empresa");

            $rsp->bindParam(":nombre", $nombreSucursal);
            $rsp->bindParam(":id_sucursal_empresa", $id_sucursalCliente);
            $rsp->execute();
            if ($rsp !== false) {
                $json = array();
                $json['id_sucursal_empresa'] = $id_sucursalCliente;
                $json['mensaje']= "Sucursal Actualizado con exito";
                return $json;
            } 
        } catch (\Throwable $th) {
            $json = array();
            $json['id_sucursal_empresa'] = 0;
            $json['mensaje']= "Error al ingresar Sucursal ".$th->getMessage();
            return $json;
    }
    }
    public function grabaSucursal($idempresa,$nombreSucursal){
        $con = Conexion::getConexion();
        try {
            $con->beginTransaction();
            $rspt = $con->prepare("INSERT INTO sucursal_empresa(id_empresa,nombre)
                        VALUES (:idempresa,:nombre)");
            $rspt->bindParam(":idempresa", $idempresa);
            $rspt->bindParam(":nombre", $nombreSucursal);
            $rspt->execute();

            
            $json['id_sucursal_empresa'] = $con->lastInsertId();
            $json['mensaje']= "Sucursal ingresado con exito";
            $con->commit(); 
            return $json;
        } catch (\Throwable $th) {
            $con->rollBack();
            $json['id_sucursal_empresa'] = 0;
            $json['mensaje']= "Error al ingresar Sucursal ".$th->getMessage();
            return $json;
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
            $rspt->bindParam(":tipoe", $tipoe);
            $rspt->bindParam(":idsucursal", $_SESSION['idsucursal']);
            $rspt->execute();
            $rspt = $rspt->fetch(PDO::FETCH_OBJ);
            if ($rspt) {
                return $rspt->total + 1;
            }
        } catch (\Throwable $th) {
            return 0;
        }
    }
    public  function eliminarContacto($idcontacto, $idempresa)
    {
        try {
            $con = Conexion::getConexion();
            $rspt = $con->prepare("DELETE FROM contactos_e WHERE id_contacto = :idcontacto and id_empresa = :idempresa");
            $rspt->bindParam(":idcontacto", $idcontacto);
            $rspt->bindParam(":idempresa", $idempresa);
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
