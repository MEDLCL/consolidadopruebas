function init() {}
var cont = 0;

function registrarc() {
	var nombre = $('#Nombre').val();
	var apellido = $('#Apellido').val();
	var correo = $('#Correo').val();
	var telefono = $('#telefonoc').val();
	var puesto = $('#puesto').val();

	if (nombre.trim() == '') {
		alertify.alert('Campo vacio', 'Debe de ingresar Nombre');
		return false;
	} else if (apellido.trim() == '') {
		alertify.alert('Campo Vacio', 'Debe de ingresar Apellido');
		return false;
	} else if (correo.trim() == '') {
		alertify.alert('Campo Vacio', 'Debe de ingresar el correo');
		return false;
	} else if (validaCorreo(correo) == false) {
		alertify.alert('Validando', 'Debe de ingresar un correo valido');
		return false;
	}
	var fila =
		'<tr class="filas" id ="fila' +cont +'">' +
		'<td><button type="button" class="btn btn-danger" onclick="eliminarfila(' +cont +')"><span class="fa fa-trash-o"></span></button></td>' +
		'<td ><input type "text"    name ="nombresc[]" id ="nombresc[]" value="'+nombre+'"></td>' +
		'<td ><input type "text"    name ="apellidosc[]" id ="apellidosc[]" value="'+apellido+'"></td>' +
		'<td ><input type "text"    name ="correosc[]" id ="correosc[]" value="'+correo+'"></td>' +
		'<td ><input type "text"    name ="telefonosc[]" id ="telefonosc[]" value="'+telefono+'"></td>' +
		'<td ><input type "text"    name ="puestosc[]" id ="puestosc[]" value="'+puesto+'"></td>' +
		'</tr>';
	cont++;
	$('#Tcontactos').append(fila);
}
//funcion para eliminar fila de la tabla contactos
function eliminarfila(cont) {
	$('#fila' + cont).remove();
}

function limpiar() {
	$('#codigo').val('');
	$('#idempresa').val('0');
	$('#Razons').val('');
	$('#Nombrec').val('');
	$('#identificacion').val('');
	$('#telefono').val('');
	$('#direccion').val('');
	$('#Nombre').val('');
	$('#Apellido').val('');
	$('#Correo').val('');
	$('#telefonoc').val('');
	$('#puesto').val('');
	$('#comision').val('0');
	$('tbody').children().remove();
}

function nuevo(tipoe) {
	limpiar();
	$('#consignadoa').hide();
	var tipo = '';
	if (tipoe == 'agentee') {
		tipo = 'AE';
	} else if (tipoe == 'agenciac') {
		tipo = 'AC';
	} else if (tipoe == 'aereolinea') {
		tipo = 'AL';
	} else if (tipoe == 'almacen') {
		tipo = 'AM';
	} else if (tipoe == 'cliente') {
		tipo = 'CL';
	} else if (tipoe == 'consignado') {
		tipo = 'CO';
		$('#consignadoa').show();
	} else if (tipoe == 'embarcador') {
		tipo = 'EM';
	} else if (tipoe == 'naviera') {
		tipo = 'NA';
	} else if (tipoe == 'proveedor') {
		tipo = 'PR';
	} else if (tipoe == 'transporte') {
		tipo = 'TR';
	}
	$('#tipoE').val(tipo);
}

function grabareditar() {
	var rasons = $('#Razons').val();
	var nombrec = $('#Nombrec').val();
	var nit = $('#identificacion').val();
	//var telefono = $('#telefono').val();
	var dire = $('#direccion').val();

	if (rasons.trim() == '') {
		alertify.alert('Campo vacio', 'Debe de ingresar Razon Social');
		return false;
	} else if (nombrec.trim() == '') {
		alertify.alert('Campo Vacio', 'Debe de ingresar Nombre Comercial');
		return false;
	} else if (dire.trim() == '') {
		alertify.alert('Campo Vacio', 'Debe de ingresar la Dirección');
		return false;
	}
	if (nit.trim() == '') {
		$('#identificacion').val('c/f');
	}
	
	var form = new FormData($('#frmempresa')[0]);
	//var form = $('#frmempresa').serialize();
	$.ajax({
		url: '../ajax/empresa.php?op=guardaryeditar',
		type: 'POST',
		data: form,
		contentType: false,
		processData: false,
		success: function(datos) {
			if (datos == 1) {
				$('#Tempresas').DataTable().ajax.reload();
				alertify.success('Proceso Realizado con exito');
				$("#modalsucursal").modal("hide");
			} else {
				alertify.error('Proceso no se pudo realizar') + ' ' + datos;
			}
		}
	});
}

function descarmarymarcar(id) {}
init();
