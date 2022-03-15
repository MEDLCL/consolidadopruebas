<?php
include_once "Conexion.php";
date_default_timezone_set ('America/Guatemala');

function limpia($cadena){
    $cadena = trim($cadena);
    $cadena = htmlentities($cadena);
    $cadena = stripslashes($cadena);
    $cadena = utf8_decode($cadena);
    return $cadena;
}

function Redondear10($valor){
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
$res=0;       
$redondear = round($valor/10);
$sinR = ($valor/10);
if ($redondear = $sinR){
    $res = $valor;
}elseif($sinR>$redondear){
    $res = (round($sinR+1))*10;
}elseif ($sinR < $redondear){
    $res = (round($valor/10))*10;
}
    return $res;
}

function redondear_dos_decimal($valor) {
    $float_redondeado=round($valor * 100) / 100;
    return $float_redondeado;
}
?>

