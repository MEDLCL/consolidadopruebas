<?php

require_once "../config/Conexion.php";
require_once "../config/funciones.php";
require_once "../modelos/calculoAlmacen.php";

$calculo = new calculoAlmacen();


$iddetalleAlmacen = isset($_POST["iddetalleAlmacen"]) ? $iddetalleAlmacen = $_POST["iddetalleAlmacen"] : $iddetalleAlmacen = 0;
$del = isset($_POST['delCalculo']) ? $del= limpia($_POST['delCalculo']) : $del= date('Y-m-d');
$al = isset($_POST['alcalculo']) ? $al = limpia($_POST['alcalculo']) : $al = date('Y-m-d');
$idplantilla = isset($_POST['idplantilla']) ?  $idplantilla= limpia($_POST['idplantilla']) : $idplantilla = '';
$impuesto = isset($_POST['impuesto']) ? $impuesto = $_POST['impuesto'] : $impuesto = 0;
$baseParaS= isset($_POST['baseparas'])? $baseParaS = $_POST['baseparas']: $baseParaS = 0 ;
$peso = isset($_POST['peso']) ? limpia($_POST['peso']) : $peso = 0;
$volumen = isset($_POST['volumen']) ? limpia($_POST['volumen']) : $volumen = 0;
$bultos = isset($_POST['bultos']) ? limpia($_POST['bultos']) : $bultosT = 0;
$cntclie = isset($_POST['cntclie']) ? $cntclie =limpia($_POST['cntclie']) : $cntclie = 0;
$diaslibres = isset($_POST['diaslibres']) ?$diaslibres= limpia($_POST['diaslibres']) : $diaslibres = 0;
$tminimo = isset($_POST["tminimo"]) ? $tminimo= limpia($_POST["tminimo"]) : $tminimo = 0; 
$dcompleto = isset($_POST["dcompleto"])? $dcompleto = limpia($_POST["dcompleto"]):$dcompleto= 0;
$diasalma = isset($_POST["diasAlmacenaje"])?$diasalma = limpia($_POST["diasAlmacenaje"]):$diasalma = 0;
$totaldias = isset($_POST["totaldias"]) ? $totaldias = limpia($_POST['totaldias']):$totaldias =0;
$tipocambio = isset($_POST["tipocambio"])?$tipoCambio = limpia($_POST["tipocambio"]):$tipocambio =0 ;
$idcliente = isset($_POST["cliente"])?$idcliente = limpia($_POST["cliente"]):$idcliente =0 ;
$iddetalle = isset($_POST["iddetalle"])?$iddetalle = limpia($_POST["iddetalle"]):$iddetalle =0 ;

$cif = isset($_POST["cif"])?$cif = limpia($_POST["cif"]):$cif =0 ;

if ($impuesto == ""){
    $impuesto = 0;
}
if ($baseParaS==""){
    $baseParaS =0 ;
}

switch ($_GET["op"]) {
    case 'guardaryeditar':
        
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
                "6" => '' */
                "0"=>  $reg->id_detalle,
                "1" => '<input type="text" name="Descripcion[]"  value = '.$reg->nombre.' readonly>',
                "2" => $reg->signo,
                "3" => '<input style="width: 70px;" type="text" name="valorDescripcion[]"  id="valorDescripcion'.$reg->id_detalle.'" value = "0">',
                //"3" => '<input style="width: 70px;" type="text" name="valorDescripcion'.$reg->id_detalle.'"  id="valorDescripcion'.$reg->id_detalle.'" value = "0">',
                //"3" => '<input style="width: 70px;" type="text" name="valorDescripcion'.$i.'"  id="valorDescripcion'.$i.'" value = "0">', //,
                "4" => '<input style="width: 70px;" type="text" name="valorsumar[]" values= "0">',
                "5" => '<input type="checkbox" name="ocultar[]">',
                "6" => '<input type="checkbox" name="prorratear[]" >',
                "7" => '<input style="width: 70px;" type="text" name="descuento[]"  value = "0">'
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
            $resp = $calculo->calculosDescripciones($reg->nombre,$reg->minimo,$reg->tarifa,$reg->porcentaje,$impuesto,$diasalma,$reg->OA,$reg->dias_libres,$baseParaS,$totaldias,$peso,$tipocambio,$cif);
            echo  $resp;
            break; 
            case 'calculariva':
            # code...
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