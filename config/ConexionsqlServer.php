<?php
include_once "configDBSqlServer.php";

class Conexion
{
    private static $con = null;

    private function __construct()
    {
        try {
            self::$con = new PDO(
                GESTOR . ":dbname=" . DB_NAME
                    . ";host=" . HOST
                    . ";charset=" . CODIFICACION,
                USER,
                PASS
            );
            self::$con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            echo 'Ha surgido un error y no se puede conectar a la base de datos. Detalle: ' . $e->getMessage();
            exit;
        }
    }
    public static function getConexion()
    {
        if (!self::$con) {
            new self();
        }
        return self::$con;
    }
    public static function cerrar()
    {
        self::$con = null;
    }
}

/* $contraseña = "jssue";
$usuario = "jssue";
$nombreBaseDeDatos = "sercogua";
# Puede ser 127.0.0.1 o el nombre de tu equipo; o la IP de un servidor remoto
$rutaServidor = "IT-SCG\ITSCS";
try {
    $base_de_datos = new PDO("sqlsrv:server=$rutaServidor;database=$nombreBaseDeDatos", $usuario, $contraseña);
    $base_de_datos->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (Exception $e) {
    echo "Ocurrió un error con la base de datos: " . $e->getMessage();
} */
/* 
$serverName = "IT-SCG\ITSCS,1433"; //serverName\instanceName, portNumber (por defecto es 1433)
$connectionInfo = array( "Database"=>"sercogua", "UID"=>"jssue", "PWD"=>"jssue");
$conn = sqlsrv_connect( $serverName, $connectionInfo);

if( $conn ) {
    echo "Conexión establecida.<br />";
}else{
    echo "Conexión no se pudo establecer.<br />";
    die( print_r( sqlsrv_errors(), true));
} */
//$serverName = "serverName\sqlexpress"; //serverName\instanceName

// Puesto que no se han especificado UID ni PWD en el array  $connectionInfo,
// La conexión se intentará utilizando la autenticación Windows.
/* $connectionInfo = array( "Database"=>"dbName");
$conn = sqlsrv_connect( $serverName, $connectionInfo);

if( $conn ) {
    echo "Conexión establecida.<br />";
}else{
    echo "Conexión no se pudo establecer.<br />";
    die( print_r( sqlsrv_errors(), true));
} */