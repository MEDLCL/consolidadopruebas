<?php
include_once "Conexion.php";

function limpia($cadena){
    $cadena = trim($cadena);
    $cadena = htmlentities($cadena);
    $cadena = stripslashes($cadena);
    return $cadena;
}

function Redondear($valor){
/*     Dim rnd
Dim srnd
       srnd = numero / 10
       rnd = Round(numero / 10)
       
       If srnd = rnd Then
           redondear = numero
       ElseIf srnd > rnd Then
             redondear = Round((srnd + 1)) * 10
       ElseIf srnd < rnd Then
            redondear = Round((numero / 10)) * 10
       End If */
return $valor;
}
 ?>

