<?php
session_start();
include_once "../config/Conexion.php";
class Empresa
{

    public function __construct()
    {
    }
    public function grabar($codigo, $tipoe, $razons, $nombrec, $nit, $telefono, $dire, $comision, $cbmtarifa, $nombres, $apellidos, $correos, $telefonos, $puestos)
    {
        try {
            $con = Conexion::getConexion();
            $con->beginTransaction();
            $rspt = $con->prepare("INSERT INTO empresas (codigo,tipoe,id_sucursal,id_usuario,Razons,Nombrec,identificacion,telefono,direccion,porcentaje_comision,tipo_comision)
                            values(:codigo,:tipoe,:idsucursal,:idusuario,:razons,:nombrec,:nit,:telefono,:dire,:comision,:cbmtarifa)");
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
            $rspt->execute();

            if ($rspt) {
                $idempresa =   $con->lastInsertId();
                $cont = 0;
                if (count($nombrec) > 0) {
                    $rspt = $con->prepare("INSERT INTO contactos_e(id_empresa,nombre,apellido,correo,telefono,puesto)
                        VALUES (:idempresa,:nombre,:apellido,:correo,:telefono:puesto)");

                    while ($cont < $nombres) {
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
            $con = Conexion::cerrar();
            return 1;
        } catch (\Throwable $th) {
            $con->rollBack();
            $con = Conexion::cerrar();
            return 0;
        }
    }
}
