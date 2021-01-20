<?php
include_once "../config/Conexion.php";
class Sucursal{
    public function __construct()
    {
    }
    public function codigo($nombrec,$pais){
        try {

            $con = Conexion::getConexion();
            $con->beginTransaction();
            $rspt = $con->prepare('SELECT count(*)AS cont FROM sucursal');
            $rspt->execute();
            $rspt = $rspt->fetch(PDO::FETCH_OBJ);
            $cont = $rspt->cont + 1;
            $codigo = substr($nombrec, 0, 3);
            $rsppais = $con->prepare("SELECT * FROM pais where idpais = $pais");
            $rsppais->execute();
            $rsppais = $rsppais->fetch(PDO::FETCH_OBJ);
            $codigo = strtoupper($codigo . $rsppais->iniciales . $cont);
            $con->commit();
            return $codigo;
        } catch (\Throwable $th) {
            $con->rollBack();
            $codigo = '';
            return $codigo;
        }
    }

}




?>