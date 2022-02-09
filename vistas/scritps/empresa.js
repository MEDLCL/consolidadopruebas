function init() {
    listar();
    llenaPaisEmpresas();
    llenaAslos();
    llenagiro();
    llenaTamanos();
    llenaTipoCargaEmpresa();
    llenaCanalaDis();
    $("#asloEmpresa").prop("disabled", true);
    llenaMonedaPago();
    llenaEquipos();
    llenalicencias();
    $("#tblEquipos").DataTable({
        dom: 'rti'
    });
    $("#tblPilotos").DataTable({
        dom: 'rti'
    });
}

var cont = 0;

function llenaEquipos() {
    $("#tipoEquipo").empty();
    $.post("../modelos/pais.php?op=equipo", {}, function (data, status) {
        $("#tipoEquipo").html(data);
        $("#tipoEquipo").selectpicker("refresh");
        $("#tipoEquipo").val(0);
        $("#tipoEquipo").selectpicker("refresh");
    });
}

function llenalicencias(){
    $("#tipoLicencia").empty();
    $.post(
        "../modelos/pais.php?op=General&tabla=tipo_licencia&campo=nombre", {
            id: "id_giro_negocio",
            tipoe: "",
        },
        function (data, status) {
            $("#tipoLicencia").html(data);
            $("#tipoLicencia").selectpicker("refresh");
            $("#tipoLicencia").val(0);
            $("#tipoLicencia").selectpicker("refresh");
        }
    );  
}
function llenaMonedaPago() {
    $("#monedaPago").empty();
    $.post("../modelos/pais.php?op=llenaMoneda", {}, function (data, status) {
        $("#monedaPago").html(data);
        $("#monedaPago").selectpicker("refresh");
        $("#monedaPago").val(0);
        $("#monedaPago").selectpicker("refresh");
    });
}

function llenagiro() {
    $("#giroNegocio").empty();
    $.post(
        "../modelos/pais.php?op=General&tabla=giro_negocio&campo=nombre", {
            id: "id_giro_negocio",
            tipoe: "",
        },
        function (data, status) {
            $("#giroNegocio").html(data);
            $("#giroNegocio").selectpicker("refresh");
            $("#giroNegocio").val(0);
            $("#giroNegocio").selectpicker("refresh");
        }
    );
}

function llenaTamanos() {
    $("#tamanoEmpresa").empty();
    $.post(
        "../modelos/pais.php?op=General&tabla=tamano_empresa&campo=nombre", {
            id: "id_tamano",
            tipoe: "",
        },
        function (data, status) {
            $("#tamanoEmpresa").html(data);
            $("#tamanoEmpresa").selectpicker("refresh");
            $("#tamanoEmpresa").val(0);
            $("#tamanoEmpresa").selectpicker("refresh");
        }
    );
}

function llenaTipoCargaEmpresa() {
    $("#tipoCargaEmpresa").empty();
    $.post(
        "../modelos/pais.php?op=General&tabla=tipo_carga_empresa&campo=nombre", {
            id: "id_tipo_carga_empresa",
            tipoe: "",
        },
        function (data, status) {
            $("#tipoCargaEmpresa").html(data);
            $("#tipoCargaEmpresa").selectpicker("refresh");
            $("#tipoCargaEmpresa").val(0);
            $("#tipoCargaEmpresa").selectpicker("refresh");
        }
    );
}

function llenaCanalaDis() {
    $("#canalDistribucion").empty();
    $.post(
        "../modelos/pais.php?op=General&tabla=canal_distribucion&campo=nombre", {
            id: "id_canal_distribucion",
            tipoe: "",
        },
        function (data, status) {
            $("#canalDistribucion").html(data);
            $("#canalDistribucion").selectpicker("refresh");
            $("#canalDistribucion").val(0);
            $("#canalDistribucion").selectpicker("refresh");
        }
    );
}

function llenaAslos() {
    $("#asloEmpresa").empty();
    $.post(
        "../modelos/pais.php?op=selectN&tabla=login&campo=acceso", {
            id: "id_usuario",
            tipoe: "",
        },
        function (data, status) {
            $("#asloEmpresa").html(data);
            $("#asloEmpresa").selectpicker("refresh");
            $("#asloEmpresa").val(0);
            $("#asloEmpresa").selectpicker("refresh");
        }
    );
}

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

    $.post("../ajax/empresa.php?op=eliminaC", {
            id_contacto: id_contacto
        },
        function (data) {
            if (data == 1) {
                $('#fila' + id_contacto).remove();
                alertify.warning("Contacto eliminado");
            } else {
                alertify.error("Contacto no se pudo eliminar");
            }
        }
    );
}

function limpiarEmpresas() {
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
    $("#paisEmpresa").val(0);
    $("#paisEmpresa").selectpicker("refresh");

    $("#giroNegocio").val(0);
    $("#giroNegocio").selectpicker("refresh");

    $("#tamanoEmpresa").val(0);
    $("#tamanoEmpresa").selectpicker("refresh");

    $("#tipoCargaEmpresa").val(0);
    $("#tipoCargaEmpresa").selectpicker("refresh");

    $("#canalDistribucion").val(0);
    $("#canalDistribucion").selectpicker("refresh");

    $("#asloEmpresa").val(0);
    $("#asloEmpresa").selectpicker("refresh");

    $("#diasCreditoTR").val(0);
}

function nuevo(tipoe) {
    limpiarEmpresas();
    $('#consignadoa').hide();
    $("#otrosTruck").hide();
    $("#codigo").prop("readonly", true)

    $("#flota-tab").hide();
    $("#experiencia-tab").hide();
    $("#categoria-tab").hide();
    $("#paraPagoProveedor").hide()
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
        $("#otrosTruck").show();
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

        $("#flota-tab").show();
        $("#experiencia-tab").show();
        $("#categoria-tab").show();
        $("#paraPagoProveedor").show()
    }
    $('#tipoE').val(tipo);
}

function grabareditar() {
    var rasons = $('#Razons').val();
    var nombrec = $('#Nombrec').val();
    var nit = $('#identificacion').val();
    //var telefono = $('#telefono').val();
    var dire = $('#direccion').val();
    var idpaisE = $("#paisEmpresa").prop("selectedIndex");

    if (rasons.trim() == '') {
        alertify.alert('Campo vacio', 'Debe de ingresar Razon Social');
        return false;
    } else if (nombrec.trim() == '') {
        alertify.alert('Campo Vacio', 'Debe de ingresar Nombre Comercial');
        return false;
    } else if (dire.trim() == '') {
        alertify.alert('Campo Vacio', 'Debe de ingresar la Dirección');
        return false;
    } else if (idpaisE == -1 || idpaisE == 0) {
        alertify.alert("Campo Vacio", "Debe de seleccionar el Pais");
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
        success: function (datos) {
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
    } else if (llama == "CreaMar") {
        if (queActu == 'AgenteE') {
            llenaAgente();
        } else if (queActu == 'Naviera') {
            llenaNaviera();
        } else if (queActu == 'AgenciaC') {
            llenaAGenciaCarga();
        }
    }else if (llama =="evaluaProyecto"){
        if (queActu == "clienteEva"){
            llenaClienteProyeto();
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
            error: function (e) {
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
    $("#codigo").prop("readonly", false);

    $("#flota-tab").hide();
    $("#experiencia-tab").hide();
    $("#categoria-tab").hide();
    $("#paraPagoProveedor").hide();

    $.post("../ajax/empresa.php?op=mostrare", {
            idempresa: idempresa
        },
        function (data, status) {
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
            $("#paisEmpresa").val(data.id_pais);
            $("#paisEmpresa").selectpicker("refresh");

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

            if (data.Tipoe == "CL") {
                $('#otrosTruck').show();
            } else {
                $('#otrosTruck').hide();
            }
            if (data.tipo == "TR") {
                $("#flota-tab").show();
                $("#experiencia-tab").show();
                $("#categoria-tab").show();
                $("#paraPagoProveedor").show();
            }

            $("#giroNegocio").val(data.id_giro_negocio);
            $("#giroNegocio").selectpicker("refresh");

            $("#tamanoEmpresa").val(data.id_tamano_empresa);
            $("#tamanoEmpresa").selectpicker("refresh");

            $("#tipoCargaEmpresa").val(data.id_tipo_carga);
            $("#tipoCargaEmpresa").selectpicker("refresh");

            $("#canalDistribucion").val(data.id_canal_distribucion);
            $("#canalDistribucion").selectpicker("refresh");

            $("#asloEmpresa").val(data.id_aslo);
            $("#asloEmpresa").selectpicker("refresh");
        })
    $.ajax({
        type: "POST",
        dataType: "html",
        url: "../ajax/empresa.php?op=cargac",
        data: "idempresa=" + idempresa,
        success: function (resp) {
            $('#tbodyDetaplantilla').append(resp);
        }
    });
}

function llenaPaisEmpresas() {
    $("#paisEmpresa").empty();
    $.post(
        "../modelos/pais.php?op=pais&tabla=pais&campo=nombre", {},
        function (data, status) {
            $("#paisEmpresa").html(data);
            $("#paisEmpresa").selectpicker("refresh");
            $("#paisEmpresa").val(0);
            $("#paisEmpresa").selectpicker("refresh");
        }
    );
}

function registrarEquipo() {
    var tipoequipo = $('#tipoEquipo').prop("selectedIndex");
    var equipo = $("#tipoEquipo option:selected").html();
    var placaCabezal = $('#placaCabezal').val();
    var placaFurgon = $('#placaFurgon').val();
    var tarjetaC = $('#tarjetaCirculacion').val();
    var gps = $('#gps').val();
    /* tipoEquipo 
        placaCabezal
        placaFurgon
        tarjetaCirculacion
        gps */
        
    if (idempresa == 0) {

    }
    if (tipoequipo==-1 || tipoequipo ==0) {
        alertify.alert('Campo vacio', 'Debe de Seleccionar el equipo');
        return false;
    } else if (placaCabezal.trim() == '') {
        alertify.alert('Campo Vacio', 'Debe de ingresar La Placa del Cabezal');
        return false;
    } else if (placaFurgon.trim() == '') {
        alertify.alert('Campo Vacio', 'Debe de ingresar La Placa del Furgon');
        return false;
    } else if (tarjetaC.trim()=='') {
        alertify.alert('Validando', 'Debe de ingresar la tarjeta de Circulacion');
        return false;
    }
    var fila =
        '<tr class="filas" id ="fila' + cont + '">' +
        '<td><button type="button" class="btn btn-danger btn-sm" onclick="eliminarfila(' + cont + ')"><span class="fa fa-trash-o"></span></button></td>' +
        '<td ><input type "text"  style="width: 25px;"  name ="idsequipo[]" id ="idsequipo[]" value="' + cont + '"></td>' +
        '<td ><input type "text"  style="width: 100px;"  name ="Equipos[]" id ="Equipos[]" value="' + equipo + '"></td>' +
        '<td ><input type "text"  style="width: 100px;"  name ="placasCabezal[]" id ="placasCabezal[]" value="' + placaCabezal + '"></td>' +
        '<td ><input type "text"  style="width: 100px;"  name ="placasfurgon[]" id ="placasfurgon[]" value="' + placaFurgon + '"></td>' +
        '<td ><input type "text"  style="width: 100px;"  name ="tarjetasC[]" id ="tarjetasC[]" value="' + tarjetaC + '"></td>' +
        '<td ><input type "text"  style="width: 100px;"  name ="gpss[]" id ="gpss[]" value="' + gps + '"></td>' +
        '</tr>';
    cont++;
    $('#tbodyEquipos').append(fila);
}
function eliminarEquipo(){

}
function registrarPiloto() {
    var idtipolicencia = $('#tipoLicencia').prop("selectedIndex");
    var tipolicencia = $("#tipoLicencia option:selected").html();
    var numeroLicencia = $('#numeroLicencia').val();
    var nombrePiloto = $('#nombrePiloto').val();

        
    if (idempresa == 0) {
    }
    if (nombrePiloto.trim()=="") {
        alertify.alert('Campo vacio', 'Debe de ingresar el Nombre del piloto');
        return false;
    } else if (idtipolicencia == -1 || idtipolicencia ==0) {
        alertify.alert('Campo Vacio', 'Debe de seleccionar el tipo de licencia');
        return false;
    } else if (numeroLicencia.trim() == '') {
        alertify.alert('Campo Vacio', 'Debe de ingresar el numero de licencia');
        return false;
    } 
    var fila =
        '<tr class="filas" id ="fila' + cont + '">' +
        '<td><button type="button" class="btn btn-danger btn-sm" onclick="eliminarfila(' + cont + ')"><span class="fa fa-trash-o"></span></button></td>' +
        '<td ><input type "text"  style="width: 25px;"  name ="idslicencias[]" id ="idslicencias[]" value="' + cont + '"></td>' +
        '<td ><input type "text"  style="width: 100px;"  name ="nombresPilotos[]" id ="nombresPilotos[]" value="' + nombrePiloto + '"></td>' +
        '<td ><input type "text"  style="width: 100px;"  name ="tiposLicencias[]" id ="tiposLicencias[]" value="' + tipolicencia + '"></td>' +
        '<td ><input type "text"  style="width: 100px;"  name ="numerosLicencias[]" id ="numerosLicencias[]" value="' + numeroLicencia + '"></td>' +
        '</tr>';
    cont++;
    $('#tbodypilotos').append(fila);
}
init();