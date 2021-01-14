<?php
include_once "Conexion.php";

function limpia($cadena){
    $cadena = trim($cadena);
    $cadena = htmlentities($cadena);
<<<<<<< HEAD
    $cadena = stripslashes($cadena);
=======

>>>>>>> develop
    return $cadena;
}
 ?>

