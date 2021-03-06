function init() {
    listar();
}
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
        '<tr class="filas" id ="fila' + cont + '">' +
        '<td><button type="button" class="btn btn-danger" onclick="eliminarfila(' + cont + ')"><span class="fa fa-trash-o"></span></button></td>' +
        '<td ><input type "text"    name ="nombresc[]" id ="nombresc[]" value="' + nombre + '"></td>' +
        '<td ><input type "text"    name ="apellidosc[]" id ="apellidosc[]" value="' + apellido + '"></td>' +
        '<td ><input type "text"    name ="correosc[]" id ="correosc[]" value="' + correo + '"></td>' +
        '<td ><input type "text"    name ="telefonosc[]" id ="telefonosc[]" value="' + telefono + '"></td>' +
        '<td ><input type "text"    name ="puestosc[]" id ="puestosc[]" value="' + puesto + '"></td>' +
        '</tr>';
    cont++;
    $('#Tcontactos').append(fila);
}
//funcion para eliminar fila de la tabla contactos
function eliminarfila(id_contacto) {

    $.post("../ajax/empresa.php?op=eliminaC", { id_contacto: id_contacto },
        function(data) {
            if (data == 1) {
                $('#fila' + id_contacto).remove();
                alertify.warning("Contacto eliminado");
            } else {
                alertify.error("Contacto no se pudo eliminar");
            }
        }
    );
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
    $('#tbodyC').children().remove();
    $("#cmb").prop("checked", false);
    $("#tarifa").prop("checked", false);
    $('#consignadoa').hide();
}

function nuevo(tipoe) {
    limpiar();
    $("#codigo").prop("readonly", true)
    var tipo = '';
    if (tipoe == 'agentee') {
        tipo = 'AE';
        $("#titulomodale").html("Agente Embarcador");
    } else if (tipoe == 'agenciac') {
        tipo = 'AC';
        $("#titulomodale").html("Agencia de carga");
    } else if (tipoe == 'aereolinea') {
        tipo = 'AL';
        $("#titulomodale").html("Aereolinea");
    } else if (tipoe == 'almacen') {
        tipo = 'AM';
        $("#titulomodale").html("Almacen");
    } else if (tipoe == 'cliente') {
        tipo = 'CL';
        $("#titulomodale").html("Cliente");
    } else if (tipoe == 'consignado') {
        tipo = 'CO';
        $("#titulomodale").html("Consignado");
        $('#consignadoa').show();
    } else if (tipoe == 'embarcador') {
        tipo = 'EM';
        $("#titulomodale").html("Embarcador");
    } else if (tipoe == 'naviera') {
        tipo = 'NA';
        $("#titulomodale").html("Naviera");
    } else if (tipoe == 'proveedor') {
        tipo = 'PR';
        $("#titulomodale").html("Proveedor");
    } else if (tipoe == 'transporte') {
        tipo = 'TR';
        $("#titulomodale").html("Transportista");
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

    /* var form = new FormData($('#frmempresa')[0]);
        //genera codigo
        if ($("#idempresa").val() == 0) {
            $.ajax({
                url: "../ajax/empresa.php?op=codigo",
                type: "POST",
                data: form,
                contentType: false,
                processData: false,
                success: function(datos) {
                    $('#codigo').val(datos);
                }
            });
        } */
    var form = new FormData($('#frmempresa')[0]);
    $.ajax({
        url: '../ajax/empresa.php?op=guardaryeditar',
        type: 'POST',
        data: form,
        cache: false,
        contentType: false,
        processData: false,
        success: function(datos) {
            if (datos == 1) {
                $('#Tempresas').DataTable().ajax.reload();
                alertify.success('Proceso Realizado con exito');
                $("#modalempresa").modal("hide");
                llenaEmpresaEnModal();
            } else if (datos == 2) {
                alertify.warning('Datos Duplicados', 'Empresa ya registrada');
            } else {
                alertify.error('Proceso no se pudo realizar') + ' ' + datos;
            }
        }
    });
}

function llenaEmpresaEnModal() {
    var llama = $("#llama").val();
    var queActu = $("#queActualizar").val();
    if (llama == "kardex") {
        if (queActu == "conAL") {
            llenaconsignado();
        } else if (queActu == "cliDA") {
            llenaCliente();
        }
    }

}

function listar() {
    tabla = $('#Tempresas').dataTable({
        "aProcessing": true, //Activamos el procesamiento del datatables
        "aServerSide": true, //Paginacion y fltrado realizado por el servidor
        dom: 'Bfrtip', //Definimos los elementos de control de tabla
        buttons: ['copyHtml5', 'excelHtml5', 'pdfHtml5'],
        "ajax": {
            url: '../ajax/empresa.php?op=listare',
            type: "get",
            dataType: "json",
            error: function(e) {
                console.log(e.responseText);
            }
        },
        "bDestroy": true,
        "iDisplayLenth": 10, //paginacion
        "order": [
                [0, "desc"]
            ] //order los datos
    });
}

function mostrarempresa(idempresa) {
    limpiar();
    $("#codigo").prop("readonly", false)
    $.post("../ajax/empresa.php?op=mostrare", { idempresa: idempresa },
        function(data, status) {
            data = JSON.parse(data);
            $('#codigo').val(data.codigo);
            $('#idempresa').val(data.id_empresa);
            $('#Razons').val(data.Razons);
            $('#Nombrec').val(data.Nombrec);
            $('#identificacion').val(data.identificacion);
            $('#telefono').val(data.telefono);
            $('#direccion').val(data.direccion);
            $('#comision').val(data.porcentaje_comision);
            $('#tipoE').val(data.Tipoe);
            if (data.Tipoe == 'CO') {
                $('#consignadoa').show();
            } else {
                $('#consignadoa').hide();
            }
            if (data.tipo_comision == 'cbm') {
                $("#cbm").prop("checked", true);
            } else if (data.tipo_comision == 'tarifa') {
                $("#tarifa").prop("checked", true);
            }
        })
    $.ajax({
        type: "POST",
        dataType: "html",
        url: "../ajax/empresa.php?op=cargac",
        data: "idempresa=" + idempresa,
        success: function(resp) {
            $('#tbodyC').append(resp);
        }
    });
}
init();