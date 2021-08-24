<?php

require_once "../config/Conexion.php";
require_once "../config/funciones.php";
require_once "../modelos/calculoAlmacen.php";

$calculo = new calculoAlmacen();

$idcliente = isset($_POST["ClienteCalculoA"])?$idcliente = limpia($_POST["ClienteCalculoA"]):$idcliente =0 ;

$iddetalleAlmacen = isset($_POST["id_detalleA_calculo"]) ? $iddetalleAlmacen = $_POST["id_detalleA_calculo"] : $iddetalleAlmacen = 0;
$nit = isset($_POST["nitCalculo"]) ? $nit = limpia($_POST['nitCalculo']):$nit ='';
$direccion= isset($_POST["direccionCalculo"]) ? $direccion = limpia($_POST['direccionCalculo']):$direccion ='';

$totaldias = isset($_POST["totalDias"]) ? $totaldias = limpia($_POST['totalDias']):$totaldias =0;

$diasalma = isset($_POST["diasAlmacenaje"])?$diasalma = limpia($_POST["diasAlmacenaje"]):$diasalma = 0;

$del = isset($_POST['delCalculoA']) ? $del= limpia($_POST['delCalculoA']) : $del= date('Y-m-d');
$al = isset($_POST['alCalculoA']) ? $al = limpia($_POST['alCalculoA']) : $al = date('Y-m-d');
$dut = isset($_POST['dutCalculo']) ? $dut = limpia($_POST['dutCalculo']) : $dut ='';
$polizaSalida = isset($_POST['polizaSalida']) ? $polizaSalida = limpia($_POST['polizaSalida']) : $polizaSalida ='';
$ordenSalida = isset($_POST['ordenSalida']) ? $ordenSalida = limpia($_POST['ordenSalida']) : $ordenSalida ='';
$cifDolares = isset($_POST['cifgtdolar']) ? $cifDolares = limpia($_POST['cifgtdolar']) : $cifDolares ='';
$cif= isset($_POST['cifCalculo']) ? $cif = limpia($_POST['cifCalculo']) : $cif ='';
$descuentoP = isset($_POST['descuento']) ? $descuentoP = limpia($_POST['descuento']) : $descuentoP =0;
$descuentoValor = isset($_POST['descuentoValor']) ? $descuentoValor = limpia($_POST['descuentoValor']) : $descuentoValor =0;
$financiacionV = isset($_POST['financiado']) ? $finaciacionV = limpia($_POST['financiado']) : $finaciacionV =0;
$financiacionP = isset($_POST['porcentajefinanciado']) ? $financiacionP = limpia($_POST['porcentajefinanciado']) : $financiacionP =0;
$aplicaf = isset($_POST['aplicaF']) ? $aplicaf = limpia($_POST['aplicaF']) : $aplicaf =0;


$idplantilla = isset($_POST['plantilla']) ?  $idplantilla= limpia($_POST['plantilla']) : $idplantilla = '';
$impuesto = isset($_POST['impuestoCalculo']) ? $impuesto = $_POST['impuestoCalculo'] : $impuesto = 0;
$baseParaS= isset($_POST['bSeguroCalculo'])? $baseParaS = $_POST['bSeguroCalculo']: $baseParaS = 0 ;
$peso = isset($_POST['pesoCalculo']) ? limpia($_POST['pesoCalculo']) : $peso = 0;
$volumen = isset($_POST['volumenCalculo']) ? limpia($_POST['volumenCalculo']) : $volumen = 0;
$bultos = isset($_POST['bultosCalculoPen']) ? limpia($_POST['bultosCalculoPen']) : $bultosT = 0;
$cntclie = isset($_POST['clientesCuadrilla']) ? $cntclie =limpia($_POST['clientesCuadrilla']) : $cntclie = 0;
$cClie =  isset($_POST['CantClientes']) ? $cClie =limpia($_POST['CantClientes']) : $cClie = 0;
$diaslibres = isset($_POST['diaslPC']) ?$diaslibres= limpia($_POST['diaslPC']) : $diaslibres = 0;
$tminimo = isset($_POST["TotalMinimo"]) ? $tminimo= limpia($_POST["TotalMinimo"]) : $tminimo = 0; 
$dcompleto = isset($_POST["diascompletoPC"])? $dcompleto = limpia($_POST["diascompletoPC"]):$dcompleto= 0;


$tipocambio = isset($_POST["tipoCambioCalculo"])?$tipoCambio = limpia($_POST["tipoCambioCalculo"]):$tipocambio =0 ;

$iddetalle = isset($_POST["iddetalle"])?$iddetalle = limpia($_POST["iddetalle"]):$iddetalle =0 ;

$subtotal = isset($_POST["subtotal"])?$subtotal = limpia($_POST["subtotal"]):$subtotal =0 ;
$iva = isset($_POST["iva"])?$iva = limpia($_POST["iva"]):$iva =0 ;

$otrovalor = isset($_POST["otrovalor"])?$otrovalor = limpia($_POST["otrovalor"]):$otrovalor =0 ;

/* $iddetalles
$valor 
$sumarvalores
$descuento 
 */
$exentoIva =0;

switch ($_GET["op"]) {
    case 'guardaryeditar':
            $rspt = $calculo->grabarCalculo($idcliente,$idplantilla,$iddetalle,$direccion,$nit,$totaldias,$diasalma,$diaslibres,$del,$al,$dut,$polizaSalida,$ordenSalida,$tipocambio,$cifDolares,$cif,$impuesto,$baseParaS,$bultos,$peso,$volumen,$cClie,$cntclie,$descuentoP,$descuentoValor,$financiacionV,$financiacionP,$aplicaf,$subtotal,$iva,$exentoIva);
        break;

    case 'mostrar':

        break;

    case 'MostrarCalculoNuevo':
        $rspt = $calculo->MostrarNuevoCalculo($iddetalleAlmacen);
        mb_internal_encoding('UTF-8');

        echo json_encode($rspt);
        break;

    case 'listarCliente':
        $rspt = $calculo->listarCliente($iddetalleAlmacen);
        $selec = '<option value="0" selected>Seleccione una Opcion</option>';
        foreach ($rspt as  $resp) {
            $selec = $selec . '<option value="' . $resp->id_empresa . '">' . $resp->Razons . '</option>';
        }
        echo $selec;
        break;
    case 'datosCliente':
        $rspt = $calculo->datosCliente($idcliente);
        mb_internal_encoding('UTF-8');
        echo json_encode($rspt);
    break;

    case 'contarDias':
        $fechadel = new DateTime ($del);
        $fechahasta = new DateTime($al);
        $diff = $fechadel->diff($fechahasta);
        $dias = $diff->days;
        echo intval($dias) + 1;
        break;
    case 'llenaTablacalculo':
        $rspt = $calculo->mostrarPlantillaCalcular($idplantilla);

        mb_internal_encoding('UTF-8');
        //se declara un array para almacenar todo el query
        $data = array();
        $i = 0; 
        foreach ($rspt as $reg) {
            $data[] = array(
                /*  "0" => $reg->nombre,
                "1" => $reg->signo,
                "2" => '<input style="width: 70px;" type="text" name="valorDescripcion[]" value = '. $calculo->calculosDescripciones($reg->nombre,$reg->minimo,$reg->tarifa,$reg->porcentaje,$impuesto,$diasalma,$reg->OA,$reg->dias_libres,$baseParaS,$totaldias,$peso,$tipocambio).'>', //,
                "3" => '<input style="width: 70px;" type="text" name="valorsumar[]">',
                "4" => '',
                "5" => '',
                "6" => '' 
                "0"=>  $reg->id_detalle,*/
                "0"=>'<input  type="text" name="id_detalle[]" id="id_detalle'.$reg->id_detalle.'" value = "'.$reg->id_detalle.'" readonly style="width: 30px;">',   
                "1" => '<input  type="text" name="Descripcion[]"  value = "'.$reg->nombre.'" readonly>',
                "2" => $reg->signo,
                "3" => '<input style="width: 70px;" type="number" name="valorDescripcion[]"  id="valorDescripcion'.$reg->id_detalle.'" value = "0" readonly>',
                //"3" => '<input style="width: 70px;" type="text" name="valorDescripcion'.$reg->id_detalle.'"  id="valorDescripcion'.$reg->id_detalle.'" value = "0">',
                //"3" => '<input style="width: 70px;" type="text" name="valorDescripcion'.$i.'"  id="valorDescripcion'.$i.'" value = "0">', //,
                "4" => '<input style="width: 70px;" type="number" name="valorSumar[]"  id="valorSumar'.$reg->id_detalle.'" value= "0">',
                "5" => '<input type="checkbox" name="ocultar[]">',
                "6" => '<input type="checkbox" name="prorratear[]" >',
                "7" => '<input style="width: 70px;" type="number" name="descuento[]"  value = "0">',
                "8" => '<input style="width: 70px;" type="number" name="ivaDescripcion[]"  id="ivaDescripcion'.$reg->id_detalle.'" value = "0" readonly>'
            );
            $i = $i+1;
        }
        $results = array(
            "sEcho" => 1, //informacion para el datatable
            "iTotalRecords" => count($data), //enviamos el total al datatable
            "iTotalDisplayRecords" => count($data), //enviamos total de rgistror a utlizar
            "aaData" => $data
        );
        echo json_encode($results);

        break; 
        case 'calcular':
            $reg = $calculo->mostrarDetalleplantillCalculando($iddetalle);
            $resp = $calculo->calculosDescripciones($reg->nombre,$reg->minimo,$reg->tarifa,$reg->porcentaje,$impuesto,$diasalma,$reg->OA,$reg->dias_libres,$baseParaS,$totaldias,$peso,$tipocambio,$cif,$otrovalor);
            
            echo  json_encode($resp);
            break; 

        case 'calculariva':
            $reg = $subtotal * $_SESSION["Impuesto"];
            echo doubleval($reg);
        break;  

}

/* 
probar simulacion de click
const element = document.getElementById("cohort");
const event = new MouseEvent("mousedown");
element.dispatchEvent(event);

var selectedOptionText = $('#mySelectID').find(":selected").text();//selected option text
var selectedOptionVal = $('#mySelectID').find(":selected").val();//selected option value

$(function() {
    $("#datepicker").datepicker();
    
    $("#datepicker").val();
    
    $("#datepicker").on("change",function(){
        var selected = $(this).val();
        alert(selected);
    });
});


function agregarDetalle(idarticulo,articulo,precio_venta)
  {
  	var cantidad=1;
    var descuento=0;

    if (idarticulo!="")
    {
    	var subtotal=cantidad*precio_venta;
    	var fila='<tr class="filas" id="fila'+cont+'">'+
    	'<td><button type="button" class="btn btn-danger" onclick="eliminarDetalle('+cont+')">X</button></td>'+
    	'<td><input type="hidden" name="idarticulo[]" value="'+idarticulo+'">'+articulo+'</td>'+
    	'<td><input type="number" name="cantidad[]" id="cantidad[]" value="'+cantidad+'"></td>'+
    	'<td><input type="number" name="precio_venta[]" id="precio_venta[]" value="'+precio_venta+'"></td>'+
    	'<td><input type="number" name="descuento[]" value="'+descuento+'"></td>'+
    	'<td><span name="subtotal" id="subtotal'+cont+'">'+subtotal+'</span></td>'+
    	'<td><button type="button" onclick="modificarSubototales()" class="btn btn-info"><i class="fa fa-refresh"></i></button></td>'+
    	'</tr>';
    	cont++;
    	detalles=detalles+1;
    	$('#detalles').append(fila);
    	modificarSubototales();
    }
    else
    {
    	alert("Error al ingresar el detalle, revisar los datos del artículo");
    }
  }

  function modificarSubototales()
  {
  	var cant = document.getElementsByName("cantidad[]");
    var prec = document.getElementsByName("precio_venta[]");
    var desc = document.getElementsByName("descuento[]");
    var sub = document.getElementsByName("subtotal");

    for (var i = 0; i <cant.length; i++) {
    	var inpC=cant[i];
    	var inpP=prec[i];
    	var inpD=desc[i];
    	var inpS=sub[i];

    	inpS.value=(inpC.value * inpP.value)-inpD.value;
    	document.getElementsByName("subtotal")[i].innerHTML = inpS.value;
    }
    calcularTotales();

  }
  function calcularTotales(){
  	var sub = document.getElementsByName("subtotal");
  	var total = 0.0;

  	for (var i = 0; i <sub.length; i++) {
		total += document.getElementsByName("subtotal")[i].value;
	}
	$("#total").html("S/. " + total);
    $("#total_venta").val(total);
    evaluar();
  }

  function evaluar(){
  	if (detalles>0)
    {
      $("#btnGuardar").show();
    }
    else
    {
      $("#btnGuardar").hide(); 
      cont=0;
    }
  }

  function eliminarDetalle(indice){
  	$("#fila" + indice).remove();
  	calcularTotales();
  	detalles=detalles-1;
  	evaluar()
  } */