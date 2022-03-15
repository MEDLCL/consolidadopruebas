var tablaServicio;
var tablaFletes;
var cont = 0;
var tablaVentas;

function init() {
    cargaTipoVenta();
    cargaCliente();
    VentaInternacional();
    cargaEmpresasVenta("EM", "embarcadorVenta");
    cargaEmpresasVenta("CL", "notificaraVenta");
    cargaEmpresasVenta("AC", "agenteVenta");
    llenacatalogoVentaTruck();
    listarVentas();
    tipocargaventa();
    llenaMoneda("servicioMonedaVenta");
    llenaMoneda("monedaFleteMV");
    $("#btnNuevoServicioA").hide();
    $("#btnNuevoFlete").hide();
    $("#listadoVentasTRUCK").show();
    $("#ventaTruck").hide();
    llenaSelect("tipounidadFleteVenta","tipo_unidades_truc","idtipo_unidades");
}

function llenaSelect(select,tabla,id){
    $("#"+select).empty();
    $.post(
        "../modelos/pais.php?op=selectN&tabla="+tabla+"&campo=nombre", {
            id: id,
            tipoe: "",
        },
        function (data, status) {
            $("#"+select).html(data);
            $("#"+select).selectpicker("refresh");
            $("#"+select).val(0);
            $("#"+select).selectpicker("refresh");
        }
    );
}


function tipocargaventa() {
    $("#tipocargaFleteMV").empty();
    $.post(
        "../modelos/pais.php?op=selectN&tabla=tipo_carga_empresa&campo=nombre", {
            id: "id_tipo_carga_empresa",
            tipoe: "",
        },
        function (data, status) {
            $("#tipocargaFleteMV").html(data);
            $("#tipocargaFleteMV").selectpicker("refresh");
            $("#tipocargaFleteMV").val(0);
            $("#tipocargaFleteMV").selectpicker("refresh");
        }
    );
}

function llenaMoneda(selecMoneda) {
    $("#" + selecMoneda).empty();
    $.post("../modelos/pais.php?op=llenaMoneda", {}, function (data, status) {
        $("#" + selecMoneda).html(data);
        $("#" + selecMoneda).selectpicker("refresh");
        $("#" + selecMoneda).val(3);
        $("#" + selecMoneda).selectpicker("refresh");
    });
}

function llenacatalogoVentaTruck() {
    $("#servicioVentaTruck").empty();
    $.post(
        "../modelos/pais.php?op=selectN&tabla=catalogo&campo=nombre", {
            id: "id_catalogo",
            tipoe: "",
        },
        function (data, status) {
            $("#servicioVentaTruck").html(data);
            $("#servicioVentaTruck").selectpicker("refresh");
            $("#servicioVentaTruck").val(0);
            $("#servicioVentaTruck").selectpicker("refresh");
        }
    );
}

function cargaEmpresasVenta(tipoempresa, selectT) {
    $("#" + selectT).empty();
    $.post(
        "../modelos/pais.php?op=selecEmpresa&tabla=empresas&campo=Razons", {
            id: "id_empresa",
            tipoe: tipoempresa,
        },
        function (data, status) {
            $("#" + selectT).html(data);
            $("#" + selectT).selectpicker("refresh");
            $("#" + selectT).val(0);
            $("#" + selectT).selectpicker("refresh");
        }
    );
}

function cargaTipoVenta() {
    $("#tipoVentaTRuck").empty();
    $.post(
        "../modelos/pais.php?op=General&tabla=tipo_venta_truck&campo=nombre", {
            id: "id_tipo_venta",
            tipoe: "",
        },
        function (data, status) {
            $("#tipoVentaTRuck").html(data);
            $("#tipoVentaTRuck").selectpicker("refresh");
            $("#tipoVentaTRuck").val(0);
            $("#tipoVentaTRuck").selectpicker("refresh");
        }
    );
}

function cargaCliente() {
    $("#clienteVentaTruck").empty();
    $.post(
        "../modelos/pais.php?op=selecEmpresa&tabla=empresas&campo=Razons", {
            id: "id_empresa",
            tipoe: "CL",
        },
        function (data, status) {
            $("#clienteVentaTruck").html(data);
            $("#clienteVentaTruck").selectpicker("refresh");
            $("#clienteVentaTruck").val(0);
            $("#clienteVentaTruck").selectpicker("refresh");
        }
    );
}

function cargaProyectos(idproyecto) {
    $("#proyectosTruck").empty();
    var idpadre = $("#clienteVentaTruck").val();

    $.post(
        "../modelos/pais.php?op=Dependiente&tabla=evaluacion_proyecto&campo=codigo", {
            id: "id_evaluacion_proyecto",
            tipoe: "id_cliente",
            idpadre: idpadre,
        },
        function (data, status) {
            $("#proyectosTruck").html(data);
            $("#proyectosTruck").selectpicker("refresh");
            $("#proyectosTruck").val(idproyecto);
            $("#proyectosTruck").selectpicker("refresh");
        }
    );
}

function VentaInternacional() {
    var tipoventa = $("#tipoVentaTRuck").val();

    if (tipoventa == 2) {
        $("#idVentaInternacional").show();
    } else {
        $("#idVentaInternacional").hide();
    }
}

function listarTarifasNuevo() {
    var proyectosTruck = $("#proyectosTruck").val();
    var codigoPro = $("#proyectosTruck option:selected").html();
    $("#codigoProyectoVenta").val(codigoPro);

    listarServicioNuevo(proyectosTruck);
    listarFletesNuevo(proyectosTruck);
}

function listarServicioNuevo(proyectosTruck) {
    tablaServicio = $('#tServicioAdicionalesVenta').dataTable({
        "aProcessing": true, //Activamos el procesamiento del datatables
        "aServerSide": true, //Paginacion y fltrado realizado por el servidor
        dom: 'rtip', //Definimos los elementos de control de tabla
        buttons: ['copyHtml5', 'excelHtml5', 'pdfHtml5'],
        "ajax": {
            url: '../ajax/ventaTruck.php?op=listarServiosNuevo',
            type: "post",
            data: {
                proyectosTruck: proyectosTruck
            },
            dataType: "json",
            error: function (e) {
                console.log(e.responseText);
            }
        },
        "bDestroy": true,
        "iDisplayLenth": 10, //paginacion
        "order": [
            [0, "desc"]
        ], //order los datos
        "columnDefs": [{
            "targets": [0],
            "visible": false,
            "searchable": false
        }]
    });
}

function listarFletesNuevo(proyectosTruck) {
    tablaFletes = $('#tfletesVenta').dataTable({
        "aProcessing": true, //Activamos el procesamiento del datatables
        "aServerSide": true, //Paginacion y fltrado realizado por el servidor
        dom: 'rtip', //Definimos los elementos de control de tabla
        buttons: ['copyHtml5', 'excelHtml5', 'pdfHtml5'],
        "ajax": {
            url: '../ajax/ventaTruck.php?op=listarTarifaFleteNuevo',
            type: "post",
            data: {
                proyectosTruck: proyectosTruck
            },
            dataType: "json",
            error: function (e) {
                console.log(e.responseText);
            }
        },
        "bDestroy": true,
        "iDisplayLenth": 10, //paginacion
        "order": [
            [0, "desc"]
        ], //order los datos
        "columnDefs": [{
            "targets": [0],
            "visible": false,
            "searchable": false
        }]
    });
}

function grabarNuevaVenta() {
    var cantServicios = 0;
    var tipoventa = $("#tipoVentaTRuck").prop("selectedIndex");
    var clienteVentaTruck = $("#clienteVentaTruck").prop("selectedIndex");
    var proyecto = $("#proyectosTruck").prop("selectedIndex");
    var idventa = $("#idVentaTruck").val();

    if (tipoventa == 0 || tipoventa == -1) {
        alertify.alert("Debe de seleccionar tipo de Venta");
        return false;
    } else if (clienteVentaTruck == 0 || clienteVentaTruck == -1) {
        alertify.alert("Debe de seleccionar al cliente");
        return false;
    } else if (proyecto == 0 || proyecto == -1) {
        alertify.alert("Debe de seleccionar un Proyecto");
        return false;
    }
    if (idventa == 0) {
        $("input[name='grabaF[]']").each(function (indice, elemento) {
            //console.log('El elemento con el índice '+indice+' contiene '+$(elemento).val());
            if ($(elemento).prop("checked")) {
                cantServicios = cantServicios + 1;
            }
        });
        if (cantServicios == 0) {
            alertify.alert("Campo Vacio", "Debe de seleccionar al menos un Flete");
            return false;
        }
    }
    var codp = 0;
    $("input[name='codigosPVenta[]']").each(function (indice, elemento) {
        if ($(elemento).val() == "") {
            codp = codp + 1;
        }
    });

    if (codp > 0) {
        alertify.alert("Campo Vacio", "Debe de ingresar Codigo Producto");
        return false
    }

    var form = new FormData($("#frmVentaTruck")[0]);
    $.ajax({
        url: "../ajax/ventaTruck.php?op=guardarEditarVnt",
        type: "POST",
        data: form,
        cache: false,
        contentType: false,
        processData: false,
        success: function (data) {
            data = JSON.parse(data);
            if (data.idVentaTruck > 0) {
                $("#idVentaTruck").val(data.idVentaTruck);
                $("#btnGrabarVenta").prop("disabled", true);
                $("#codigoVentaTruck").val($codigoventa);
                Swal.fire({
                    icon: "success",
                    title: "",
                    text: data.mensaje,
                });
            } else {
                Swal.fire({
                    icon: "error",
                    title: "",
                    text: data.mensaje,
                });
                //alertify.error("Proceso no se pudo realizar") + " " + datos;
            }
        },
    });

}

function listarVentas() {
    tablaVentas = $('#tVentasTruck').dataTable({
        "aProcessing": true, //Activamos el procesamiento del datatables
        "aServerSide": true, //Paginacion y fltrado realizado por el servidor
        dom: 'Bfrtip', //Definimos los elementos de control de tabla
        buttons: ['copyHtml5', 'excelHtml5', 'pdfHtml5'],
        "ajax": {
            url: '../ajax/ventaTruck.php?op=listarVentas',
            type: "post",
            data: {

            },
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

function nuevaVenta() {
    habilitarCampos();
    limpiarVenta();
    $("#listadoVentasTRUCK").hide();
    $("#ventaTruck").show();

}

function limpiarVenta() {
    $("#btnGrabarVenta").prop("disabled", false);
    $("#btnNuevoFlete").hide();
    $("#btnNuevoServicioA").hide();
    $("#idVentaTruck").val(0);
    $("#codigoVentaTruck").val(0);
    $("#tipoVentaTRuck").val(0);
    $("#tipoVentaTRuck").selectpicker("refresh");
    $("#clienteVentaTruck").val(0);
    $("#clienteVentaTruck").selectpicker("refresh");
    cargaProyectos(0);
    $("#observacionesVenta").val("");
    $("#idVentaInternacional").hide();
    $("#embarcadorVenta").val(0);
    $("#embarcadorVenta").selectpicker("refresh");
    $("#notificaraVenta").val(0);
    $("#notificaraVenta").selectpicker("refresh");
    $("#agenteVenta").val(0);
    $("#agenteVenta").selectpicker("refresh");

    $("#tbodyServicioAdicionalesVenta tr").remove();
    $("#tbodyfletesVenta tr").remove();
    $("#tbodyProductoVenta tr").remove();
}

function cancelarVenta() {
    $("#listadoVentasTRUCK").show();
    $("#ventaTruck").hide();
    $('#tVentasTruck').DataTable().ajax.reload();

}

function anularVenta(idVentaTruck) {
    Swal.fire({
        title: 'Desea Anular Venta?',
        icon: 'warning',
        showDenyButton: true,
        showCancelButton: false,
        confirmButtonText: 'Si',
        denyButtonText: `No`,
    }).then((result) => {
        if (result.isConfirmed) {
            $.post(
                "../ajax/ventaTruck.php?op=anularVenta", {
                    idVentaTruck: idVentaTruck
                },
                function (data, status) {
                    data = JSON.parse(data);
                    if (data.idVentaTruck >= 1) {
                        $('#tVentasTruck').DataTable().ajax.reload();
                        Swal.fire({
                            icon: "success",
                            title: "",
                            text: data.mensaje,
                        });
                    } else {
                        Swal.fire({
                            icon: "error",
                            title: "",
                            text: data.mensaje,
                        });
                    }
                }
            );
        } else if (result.isDenied) {
    
        }
    })
}

function mostrarVenta(idVentaTruck) {
    limpiarVenta();
    $("#listadoVentasTRUCK").hide();
    $("#ventaTruck").show();
    $.post(
        "../ajax/ventaTruck.php?op=mostrarVenta", {
            idVentaTruck: idVentaTruck
        },
        function (data, status) {
            data = JSON.parse(data);
            if (data.id_venta_truck >= 1) {
                $("#btnGrabarVenta").prop("disabled", false);
                $("#idVentaTruck").val(data.id_venta_truck);
                $("#codigoVentaTruck").val(data.codigo);
                $("#tipoVentaTRuck").val(data.id_tipoventa);
                $("#tipoVentaTRuck").selectpicker("refresh");
                $("#clienteVentaTruck").val(data.id_cliente);
                $("#clienteVentaTruck").selectpicker("refresh");
                cargaProyectos(data.id_proyecto);
                $("#observacionesVenta").val(data.observaciones);
                $("#notificaraVenta").val(data.id_notificar);
                $("#notificaraVenta").selectpicker("refresh");

                $("#btnNuevoFlete").show();
                $("#btnNuevoServicioA").show();
                listaSevicioAdicional(data.id_venta_truck);
                listarFletes(data.id_venta_truck)
            } else {
                Swal.fire({
                    icon: "error",
                    title: "",
                    text: "Error al cargar los datos",
                });
            }
        }
    );
    desabilitaModiVenta();
}


function desabilitaModiVenta() {
    $("#tipoVentaTRuck").prop("disabled", true);
    $("#clienteVentaTruck").prop("disabled", true);
    $("#proyectosTruck").prop("disabled", true);
}

function habilitarCampos() {
    $("#tipoVentaTRuck").prop("disabled", false);
    $("#clienteVentaTruck").prop("disabled", false);
    $("#proyectosTruck").prop("disabled", false);
}

function listaSevicioAdicional(idVentaTruck) {
    $('#tServicioAdicionalesVenta').dataTable({
        "aProcessing": true, //Activamos el procesamiento del datatables
        "aServerSide": true, //Paginacion y fltrado realizado por el servidor
        dom: 'rtip', //Definimos los elementos de control de tabla
        buttons: ['copyHtml5', 'excelHtml5', 'pdfHtml5'],
        "ajax": {
            url: '../ajax/ventaTruck.php?op=listarServicioA',
            type: "post",
            data: {
                idVentaTruck: idVentaTruck
            },
            dataType: "json",
            error: function (e) {
                console.log(e.responseText);
            }
        },
        "bDestroy": true,
        "iDisplayLenth": 10, //paginacion
        "order": [
            [0, "desc"]
        ], //order los datos
        "columnDefs": [{
            "targets": [1],
            "visible": false,
            "searchable": false
        }]
    });
}

function listarFletes(idVentaTruck) {
    $('#tfletesVenta').dataTable({
        "aProcessing": true, //Activamos el procesamiento del datatables
        "aServerSide": true, //Paginacion y fltrado realizado por el servidor
        dom: 'rtip', //Definimos los elementos de control de tabla
        buttons: ['copyHtml5', 'excelHtml5', 'pdfHtml5'],
        "ajax": {
            url: '../ajax/ventaTruck.php?op=listarFletes',
            type: "post",
            data: {
                idVentaTruck: idVentaTruck
            },
            dataType: "json",
            error: function (e) {
                console.log(e.responseText);
            }
        },
        "bDestroy": true,
        "iDisplayLenth": 10, //paginacion
        "order": [
            [0, "desc"]
        ], //order los datos
        "columnDefs": [{
            "targets": [1],
            "visible": false,
            "searchable": false
        }]
    });
}

function listarProductos(idVentaTruck) {
    $.ajax({
        type: "POST",
        dataType: "html",
        url: "../ajax/ventaTruck.php?op=listarProdcutos",
        data: "idVentaTruck=" + idVentaTruck,
        success: function (resp) {
            $('#tbodyProductoVenta').append(resp);
        }
    });
}


function grabarEditarServicioAdicional() {
    var idservicioadicional = $("#idservicioadicional").val();
    var servicioVentaTruck = $("#servicioVentaTruck").prop("selectedIndex");
    var servicioTarifaVenta = $("#servicioTarifaVenta").val();
    var servicioTarifaCosto = $("#servicioTarifaCosto").val();
    var servicioMonedaVenta = $("#servicioMonedaVenta").prop("selectedIndex");
    var servicioCantidadVenta = $("#servicioCantidadVenta").val();
    var servicioOrigenVenta = $("#servicioOrigenVenta").val();
    var servicioDestinoVenta = $("#servicioDestinoVenta").val();

    var idVentaTruck = $("#idVentaTruck").val();

    if (servicioVentaTruck == 0 || servicioVentaTruck == -1) {
        alertify.alert("Campo Vacio", "Debe de seleccionar un Servicio");
        return false;
    } else if (servicioTarifaVenta == 0 || servicioTarifaVenta.trim() == "") {
        alertify.alert("Campo Vacio", "Debe ingresar Valor Venta");
        return false;
    } else if (servicioTarifaCosto == 0 || servicioTarifaCosto.trim() == "") {
        alertify.alert("Campo Vacio", "Debe ingresar Valor Costo");
        return false;
    } else if (servicioMonedaVenta == 0 || servicioMonedaVenta == -1) {
        alertify.alert("Campo Vacio", "Debe de seleccionar la moneda");
        return false;
    } else if (servicioCantidadVenta == 0 || servicioCantidadVenta.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de indicar cantidad");
        return false;
    } else if (servicioOrigenVenta.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de colocar origen");
        return false;
    } else if (servicioDestinoVenta.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de colocar Destino");
        return false;
    }

    servicioVentaTruck = $("#servicioVentaTruck").val();
    servicioMonedaVenta = $("#servicioMonedaVenta").val();

    $.ajax({
        url: "../ajax/ventaTruck.php?op=grabarEditarServicio",
        type: "POST",
        data: {
            "idVentaTruck": idVentaTruck,
            "idservicioadicional": idservicioadicional,
            "servicioVentaTruck": servicioVentaTruck,
            "servicioTarifaVenta": servicioTarifaVenta,
            "servicioTarifaCosto": servicioTarifaCosto,
            "servicioMonedaVenta": servicioMonedaVenta,
            "servicioCantidadVenta": servicioCantidadVenta,
            "servicioOrigenVenta": servicioOrigenVenta,
            "servicioDestinoVenta": servicioDestinoVenta
        },
        success: function (datos) {
            datos = JSON.parse(datos);
            if (datos.id_servicio_adicional > 0) {
                $('#tServicioAdicionalesVenta').DataTable().ajax.reload();
                $("#modalServicioAdicionalVentaTruck").modal("hide");
                Swal.fire({
                    icon: "success",
                    title: "",
                    text: datos.mensaje,
                });
            } else {
                Swal.fire({
                    icon: "error",
                    title: "",
                    text: datos.mensaje,
                });
                //alertify.error("Proceso no se pudo realizar") + " " + datos;
            }
        },
    });
}

function anulaServicioAdicional(idservicioadicional) {
    var idVentaTruck = $("#idVentaTruck").val();
    Swal.fire({
        title: 'Desea Eliminar Servicio?',
        icon: 'warning',
        showDenyButton: true,
        showCancelButton: false,
        confirmButtonText: 'Si',
        denyButtonText: `No`,
    }).then((result) => {
        if (result.isConfirmed) {
            $.post(
                "../ajax/ventaTruck.php?op=anularServicioAdicional", {
                    idservicioadicional: idservicioadicional
                },
                function (data, status) {
                    data = JSON.parse(data);
                    if (data.idservicioA >= 1) {
                        listaSevicioAdicional(idVentaTruck);
                        Swal.fire({
                            icon: "success",
                            title: "",
                            text: data.mensaje,
                        });
                    } else {
                        Swal.fire({
                            icon: "error",
                            title: "",
                            text: data.mensaje,
                        });
                    }
                }
            );
        } else if (result.isDenied) {
    
        }
    })
    
}

function mostrarServicioAdicional(idservicioadicional) {
    limpiaModalServicioVentaTruck();
    $.post(
        "../ajax/ventaTruck.php?op=listarServicio", {
            idservicioadicional: idservicioadicional
        },
        function (data, status) {
            data = JSON.parse(data);
            if (data.id_servicio_adicional >= 1) {

                $("#idservicioadicional").val(data.id_servicio_adicional);
                $("#servicioVentaTruck").val(data.id_catalogo);
                $("#servicioVentaTruck").selectpicker("refresh");
                $("#servicioTarifaVenta").val(data.tarifa_venta);
                $("#servicioTarifaCosto").val(data.tarifa_costo);
                $("#servicioMonedaVenta").val(data.id_moneda);
                $("#servicioMonedaVenta").selectpicker("refresh");
                $("#servicioCantidadVenta").val(data.cantidad);
                $("#servicioOrigenVenta").val(data.origen);
                $("#servicioDestinoVenta").val(data.destino);

                $("#modalServicioAdicionalVentaTruck").modal("show");
            } else {
                Swal.fire({
                    icon: "error",
                    title: "",
                    text: "Error al cargar los datos",
                });
            }
        }
    );
}

function nuevoServicioAdicional() {
    limpiaModalServicioVentaTruck()
    $("#modalServicioAdicionalVentaTruck").modal("show");
}

function catalogollama() {
    limpiarmodalCatalogo();
    $("#modalServicioAdicionalVentaTruck").modal("hide");
    $("#llamaCalculoA").val("ventaTruck");
    $("#modalCatalogo").modal("show");
    llenaCatalogoModal();
}

function modalEmbarcador() {
    $(".nav-tabs a:first").tab("show");
    nuevo("embarcador");
    $("#llama").val("ventaTruck");
    $("#tituloh").html("Embarcador");
    //cliente detalle almacen
    $("#queActualizar").val("embarcadorVenta");
    $("#modalempresa").modal("show");
}

function modalAgente() {
    $(".nav-tabs a:first").tab("show");
    nuevo("agentee");
    $("#llama").val("ventaTruck");
    $("#tituloh").html("Agente");
    //cliente detalle almacen
    $("#queActualizar").val("agenteVenta");
    $("#modalempresa").modal("show");
}

function modalNotificaA() {
    $(".nav-tabs a:first").tab("show");
    nuevo("cliente");
    $("#llama").val("ventaTruck");
    $("#tituloh").html("Notifica A");
    //cliente detalle almacen
    $("#queActualizar").val("notificaAVenta");
    $("#modalempresa").modal("show");
}

function limpiaModalServicioVentaTruck() {
    $("#idservicioadicional").val(0);
    $("#servicioTarifaVenta").val(0);
    $("#servicioVentaTruck").val(0);
    $("#servicioVentaTruck").selectpicker("refresh");
    $("#servicioTarifaCosto").val(0);
    $("#servicioMonedaVenta").val(0);
    $("#servicioMonedaVenta").selectpicker("refresh");
    $("#servicioCantidadVenta").val(1);
    $("#servicioOrigenVenta").val("");
    $("#servicioDestinoVenta").val("");
}


function calculaProfit(id_tarifa_servicio) {
    var venta = $("#tarifaVentaS" + id_tarifa_servicio).val();
    var costo = $("#tarifaCostoS" + id_tarifa_servicio).val();
    var cantidad = $("#cantidadS" + id_tarifa_servicio).val();
    var profit = 0;
    var comision = 0;
    profit = (parseFloat(venta) * parseFloat(cantidad)) - (parseFloat(costo) * parseFloat(cantidad));

    comision = parseFloat(profit) * .10;
    $("#comisions" + id_tarifa_servicio).val(comision);
    $("#profitS" + id_tarifa_servicio).val(parseFloat(profit) - parseFloat(comision));
}

function fleteAdicional() {
    $("#modalventafletetruck").modal("show");
}

function limpiarfleteModal() {
    $("#idfleteadicionalm").val(0);
    $("#tarifaVentaFleteMV").val(0);
    $("#tarifaCostoFleteMV").val(0);
    $("#monedaFleteMV").val(3);
    $("#monedaFleteMV").selectpicker("refresh");
    $("#unidadesFleteMV").val(1);
    $("#horaFleteMV").val("");
    $("#fechaPosFleteMV").val("");
    $("#diaslibreFleteMV").val(0);
    $("#origenFleteMV").val("");
    $("#desitinoFleteMV").val("");
    $("#tipocargaFleteMV").val(0);
    $("#tipocargaFleteMV").selectpicker("refresh");
    $("#tipounidadFleteVenta").val(0);
    $("#tipounidadFleteVenta").selectpicker("refresh");
}

function grabarEditarFleteAdicional() {
    var idfleteadicionalm = $("#idfleteadicionalm").val();
    var tarifaVentaFleteMV = $("#tarifaVentaFleteMV").val();
    var tarifaCostoFleteMV = $("#tarifaCostoFleteMV").val();
    var monedaFleteMV = $("#monedaFleteMV").prop("selectedIndex");
    var unidadesFleteMV = $("#unidadesFleteMV").val();
    var horaFleteMV = $("#horaFleteMV").val();
    var fechaPosFleteMV = $("#fechaPosFleteMV").val();
    var diaslibreFleteMV = $("#diaslibreFleteMV").val();
    var origenFleteMV = $("#origenFleteMV").val();
    var desitinoFleteMV = $("#desitinoFleteMV").val();
    var tipocargaFleteMV = $("#tipocargaFleteMV").prop("selectedIndex");
    var idVentaTruck = $("#idVentaTruck").val();

    var tipounidadFleteVenta = $("#tipounidadFleteVenta").prop("selectedIndex");
    
    if (tarifaVentaFleteMV == 0 || tarifaVentaFleteMV.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de colocar Tarifa Venta");
        return false;
    } else if (tarifaCostoFleteMV == 0 || tarifaCostoFleteMV.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de colocar Tarifa Costo");
        return false;
    } else if (monedaFleteMV == 0 || monedaFleteMV == -1) {
        alertify.alert("Campo Vacio", "Debe de seleccionar una moneda");
        return false;
    } else if (horaFleteMV.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de indicar la hora de posicionamiento");
        return false;
    } else if (fechaPosFleteMV.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de indicar la Fecha de posicionamiento");
        return false;
    
    }else if (tipounidadFleteVenta ==0 || tipounidadFleteVenta ==-1){
        alertify.alert("Campo Vacio", "Debe de seleccionar el tipo de unidad");
        return false;
    } else if (tipocargaFleteMV == 0 || tipocargaFleteMV == -1) {
        alertify.alert("Campo Vacio", "Debe de seleccionar tipo de Carga");
        return false;

    } else if (origenFleteMV.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de colocar el Origen");
        return false;

    } else if (desitinoFleteMV.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de colocar el Destino");
        return false;
    }

    monedaFleteMV = $("#monedaFleteMV").val();
    tipocargaFleteMV = $("#tipocargaFleteMV").val();
    tipounidadFleteVenta =$("#tipounidadFleteVenta").val();

    $.ajax({
        url: "../ajax/ventaTruck.php?op=grabarEditarFleteAdicional",
        type: "POST",
        data: {
            "idfleteadicionalm": idfleteadicionalm,
            "tarifaVentaFleteMV": tarifaVentaFleteMV,
            "tarifaCostoFleteMV": tarifaCostoFleteMV,
            "monedaFleteMV": monedaFleteMV,
            "unidadesFleteMV": unidadesFleteMV,
            "horaFleteMV": horaFleteMV,
            "fechaPosFleteMV": fechaPosFleteMV,
            "diaslibreFleteMV": diaslibreFleteMV,
            "tipocargaFleteMV": tipocargaFleteMV,
            "origenFleteMV": origenFleteMV,
            "desitinoFleteMV": desitinoFleteMV,
            "idVentaTruck": idVentaTruck,
            "tipounidadFleteVenta":tipounidadFleteVenta
        },
        success: function (datos) {
            datos = JSON.parse(datos);
            if (datos.id_servicio_flete > 0) {
                limpiarfleteModal();
                $('#tfletesVenta').DataTable().ajax.reload();
                $("#modalventafletetruck").modal("hide");
                Swal.fire({
                    icon: "success",
                    title: "",
                    text: datos.mensaje,
                });
            } else {
                Swal.fire({
                    icon: "error",
                    title: "",
                    text: datos.mensaje,
                });
                //alertify.error("Proceso no se pudo realizar") + " " + datos;
            }
        },
    });
}

function mostrarFlete(idfleteadicionalm) {
    limpiarfleteModal();
    $.post(
        "../ajax/ventaTruck.php?op=listarFlete", {
            idfleteadicionalm: idfleteadicionalm
        },
        function (data, status) {
            data = JSON.parse(data);
            if (data.id_servicio_flete >= 1) {
                $("#idfleteadicionalm").val(data.id_servicio_flete);
                $("#tarifaVentaFleteMV").val(data.tarifa_venta);
                $("#tarifaCostoFleteMV").val(data.tarifa_costo);
                $("#monedaFleteMV").val(data.id_moneda);
                $("#monedaFleteMV").selectpicker("refresh");
                $("#unidadesFleteMV").val(data.unidades);
                $("#horaFleteMV").val(data.hora_posicionamiento);
                $("#fechaPosFleteMV").val(data.fecha_posicion);
                $("#diaslibreFleteMV").val(data.dias_libres);
                $("#origenFleteMV").val(data.origen);
                $("#desitinoFleteMV").val(data.destino);
                $("#tipounidadFleteVenta").val(data.id_tipo_unidad);
                $("#tipounidadFleteVenta").selectpicker("refresh");
                $("#tipocargaFleteMV").val(data.id_tipo_carga);
                $("#tipocargaFleteMV").selectpicker("refresh");
                $("#modalventafletetruck").modal("show");
            } else {
                Swal.fire({
                    icon: "error",
                    title: "",
                    text: "Error al cargar los datos",
                });
            }
        }
    );
}

function anularFlete(idfleteadicionalm) {
    var idVentaTruck = $("#idVentaTruck").val();
    Swal.fire({
        title: 'Desea Eliminar Flete?',
        icon: 'warning',
        showDenyButton: true,
        showCancelButton: false,
        confirmButtonText: 'Si',
        denyButtonText: `No`,
    }).then((result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            $.post(
                "../ajax/ventaTruck.php?op=anularFlete", {
                    idfleteadicionalm: idfleteadicionalm
                },
                function (data, status) {
                    data = JSON.parse(data);
                    if (data.id_servicio_flete >= 1) {
                        listarFletes(idVentaTruck);
                        Swal.fire({
                            icon: "success",
                            title: "",
                            text: data.mensaje,
                        });
                    } else {
                        Swal.fire({
                            icon: "error",
                            title: "",
                            text: data.mensaje,
                        });
                    }
                }
            );
        } else if (result.isDenied) {

        }
    })
}
function calculaProfitflete(idtarifaflete) {
    var venta = $("#tarifaVentaIF" + idtarifaflete).val();
    var costo = $("#tarifaCostoIF" + idtarifaflete).val();
    var ventatotal=0;
    var costototal=0;

    var cantidad = $("#unidadesF" + idtarifaflete).val();
    var profit = 0;
    var comision = 0;
    ventatotal = parseFloat(venta)* parseInt(cantidad);
    costototal = parseFloat(costo)* parseInt(cantidad);
    $("#totalVentaF"+idtarifaflete).val(ventatotal);
    $("#totalCostoF"+idtarifaflete).val(costototal);
    profit = parseFloat(ventatotal) - parseFloat(costototal);

    comision = parseFloat(profit) * .10;
    $("#comisionf" + idtarifaflete).val(comision);
    $("#profitF" + idtarifaflete).val(parseFloat(profit) - parseFloat(comision));
}



function reporteVentaTruck(tipo) {
    var idVentaTruck = $("#idVentaTruck").val();

    if (tipo ==1){
        const ruta = '../reportes/ventaTruck.php?idVentaTruck='+idVentaTruck;
        //const ruta1 = "<iframe id='' src='../reportes/tarifarioProyecto.php?idproyecto='"+idproyecto+"'&codigo='"+codigo+"'> </iframe>";
        window.open(ruta);
    }else{
        $.post(
            '../reportes/ventaTruck.php?idVentaTruck='+idVentaTruck, {
                tipo: tipo
            },
            function (data,status) {
                data = JSON.parse(data);
                if (data.estado == 1) {
                    Swal.fire({
                        icon: "success",
                        title: "",
                        text: data.mensaje,
                    });
                } else {
                    Swal.fire({
                        icon: "error",
                        title: "",
                        text: data.mensaje,
                    });
                }
            }
        );
    }
}

init();

/* $("#txtConvBusFch").on('keyup', function (e) {
    var keycode = e.keyCode || e.which;
        if (keycode == 13) {
            alert("Enter!");
        }
}); */

/* Swal.fire({
    title: 'Desea Eliminar Flete?',
    icon: 'warning',
    showDenyButton: true,
    showCancelButton: false,
    confirmButtonText: 'Si',
    denyButtonText: `No`,
}).then((result) => {
   
    if (result.isConfirmed) {
    
    } else if (result.isDenied) {

    }
}) */