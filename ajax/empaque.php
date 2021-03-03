<?php
require_once "../config/Conexion.php";
require_once "../config/funciones.php";

$id_empaque = isset($_POST["id_empaque"]) ? $id_empaque = $_POST["id_empaque"] : $id_empaque = 0;
$nombre = isset($_POST['nombre']) ? limpia($_POST['nombre']) : $nombre = '';



switch ($_GET["op"]) {
    case 'guardaryeditar':
        if ($id_empaque == 0 || $id_empaque == "") {
            //insertar nuevos registros
            try {
                $con = Conexion::getConexion();
                $stmt = $con->prepare("INSERT INTO empaque (nombre) VALUES (:nombre)");
                $stmt->bindParam(':nombre', $nombre);
                $stmt->execute();
                
                if ($stmt) {
                    echo  1;
                }

            } catch (\Throwable $th) {
                echo "" . $th->getMessage();
            }
        } else {
            //actualizar registros
            try {
                $con = Conexion::getConexion();
                $stmt = $con->prepare("UPDATE empaque
                                SET nombre= :nombre,
                                WHERE  id_empaque = :id_empaque");
                $stmt->bindParam(':nombre', $nombre);
                $stmt->bindParam(':id_empaque', $id_empaque);
                $stmt->execute();
                if ($stmt !== false) {
                    echo 1;
                }
                $con = Conexion::cerrar();
            } catch (\Throwable $th) {
                echo "Error" . $th->getMessage();
                $con = Conexion::cerrar();
            }
        }
        break;
}
