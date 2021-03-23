var tablaK = "";
var tablaDA = "";

function init() {
    $("#fechaI").datepicker({
        autoclose: true,
        dateFormat: "yy-mm-dd"
    });
    //$('#Tkardex').DataTable();

    llenaconsignado();
    llenaCliente();
    nuevoDetalle("false");
    ocultaAlma("false");
    llenaEmpaqueModal();
    llenaEmpaqueDetalle();
    listarKardex();
}


function llenaconsignado() {
    $("#consignado").empty();
    $.post(
        "../modelos/pais.php?op=selecEmpresa&tabla=empresas&campo=Razons", {
            id: "id_empresa",
            tipoe: "CO",
        },
        function(data, status) {
            $("#consignado").html(data);
            $("#consignado").selectpicker("refresh");
            $("#consignado").val(0);
            $("#consignado").selectpicker("refresh");
        }
    );
}

function llenaCliente() {
    $.post(
        "../modelos/pais.php?op=selecEmpresa&tabla=empresas&campo=Razons", {
            id: "id_empresa",
            tipoe: "CL",
        },
        function(data, status) {
            $("#cliente").html(data);
            $("#cliente").selectpicker("refresh");
            $("#cliente").val(0);
            $("#cliente").selectpicker("refresh");
        }
    );
}

function nuevoDetalle(deta) {
    if (deta == "true") {
        $("#datosDetalleA").show();
        $("#tablaDetalleAlmacen").hide();
    } else {
        $("#datosDetalleA").hide();
        $("#tablaDetalleAlmacen").show();
    }
    limpiaDetalle();
}

function limpiaDetalle() {
    $("#iddetallealmacen").val(0);
    $("#cliente").val(0);
    $("#cliente").selectpicker("refresh");
    $("#nohbl").val("");
    $("#peso").val(0);
    $("#ubicacion").val("");
    $("#volumen").val(0);
    $("#dut").val("");
    $("#bultos").val(0);
    $("#embalajeD").val(0);
    $("#embalajeD").selectpicker("refresh");
    $("#liberado").prop("checked", false);
    $("#resa").val("");
    $("#dti").val("");
    $("#ncancel").val("");
    $("#norden").val("");
    $("#mercaderia").val("");
    $("#observaciones").val("");
    $("#linea").val("");
}

function ocultaAlma(alma) {
    if (alma == true) {
        $("#Almacen").show();
    } else {
        $("#Almacen").hide();
    }
    nuevoAlma();
}

function nuevoAlma() {
    $("#codigoAlmacen").val("");
    $("#consignado").val(0);
    $("#consignado").selectpicker("refresh");
    $("#contenedor").val("");
    $("#poliza").val("");
    $("#referencia").val("");
    $("#pesoT").val(0);
    $("#volumenT").val(0);
    $("#bultosT").val(0);
    $("#cntClientes").val(1);
    $("#fechaI").val("");
    $("#btnNuevoDetalle").attr("disabled", "false");
    $("#grabaAlmacen").removeAttr("disabled");
}

function llenaEmpaqueModal() {
    $.post(
        "../modelos/pais.php?op=selectN&tabla=empaque&campo=nombre", {
            id: "id_empaque",
            tipoe: "",
        },
        function(data, status) {
            $("#empaqueB").html(data);
            $("#empaqueB").selectpicker("refresh");

        }
    );
}

function llenaEmpaqueDetalle() {
    $.post(
        "../modelos/pais.php?op=selectN&tabla=empaque&campo=nombre", {
            id: "id_empaque",
            tipoe: "",
        },
        function(data, status) {
            $("#embalajeD").html(data);
            $("#embalajeD").selectpicker("refresh");
        }
    );
}

function grabaEmpaque() {
    var nombre = $('#nombreE').val();
    var id_empaque = $("#id_empaque").val();
    if (nombre.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de ingresar campo nombre Empaque");
        return false;
    }
    $.post(
        "../ajax/empaque.php?op=guardaryeditar", { id_empaque: id_empaque, nombre: nombre },
        function(data) {
            if (data == 1) {
                llenaEmpaqueDetalle();
                $("#modalEmaqpue").modal("hide");
            }

        }
    );

}

function nuevoConsignado() {
    $('.nav-tabs a:first').tab('show')
    $("#titulomodale").text("Consignado");
    nuevo("consignado");
    $("#tituloh").html("Consignado");
    $("#llama").val("kardex");
    //consignado ingreso almacen
    $("#queActualizar").val("conAL")

}

function nuevoCliente() {
    $('.nav-tabs a:first').tab('show')
    nuevo("cliente");
    $("#llama").val("kardex");
    $("#tituloh").html("Cliente");
    //cliente detalle almacen
    $("#queActualizar").val("cliDA")
    $("#modalempresa").modal("show");


}

function limpiaEmpaque() {
    llenaEmpaqueModal();
    $("#nombreE").val("");
    $("#id_empaque").val(0);
    /*  $("#empaqueB").val(0);
        $("#empaqueB").selectpicker("refresh"); */
}

function grabarAlmacen() {
    var consignado = $("#consignado").prop("selectedIndex");
    var contenedor = $("#contenedor").val();
    var poliza = $("#poliza").val();
    var referencia = $("#referencia").val();
    var pesoT = $("#pesoT").val();
    var volumenT = $("#volumenT").val();
    var bultosT = $("#bultosT").val();
    var fechaI = $("#fechaI").val();
    var cntClientes = $("#cntClientes").val();
    if (consignado == -1 || consignado == 0) {
        alertify.alert("Campo Vacio", "Debe de Seleccionar consignado");
        return false;
    } else if (contenedor.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de ingresar Contenedor/Placa");
        return false;
    } else if (poliza.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de ingresar Poliza");
        return false;
    } else if (referencia.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de ingresar Referencia");
        return false;
    } else if (pesoT.trim() == "" || pesoT == 0) {
        alertify.alert("Campo Vacio", "Debe de ingresar Peso");
        return false;
    } else if (volumenT.trim() == "" || volumenT == 0) {
        alertify.alert("Campo Vacio", "Debe de ingresar Volumen");
        return false;
    } else if (bultosT.trim() == "" || bultosT == 0) {
        alertify.alert("Campo Vacio", "Debe de ingresar Bultos");
        return false;
    } else if (cntClientes.trim() == "" || cntClientes == 0) {
        alertify.alert("Campo Vacio", "Debe de ingresar Cantidad de Clientes");
        return false;
    } else if (fechaI.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de ingresar Fecha Ingreso Almacen");
        return false;
    }
    var formAlmacen = new FormData($("#formAlmacen")[0]);
    $.post(
        "../ajax/kardex.php?op=codigo", {},
        function(data, status) {
            if (status == "success") {
                $("#codigoAlmacen").val(data);
                formAlmacen = new FormData($("#formAlmacen")[0]);
                $.ajax({

                    url: "../ajax/kardex.php?op=guardaryeditar",
                    type: "POST",
                    data: formAlmacen,
                    contentType: false,
                    processData: false,
                    success: function(datos) {
                        if (datos > 0) {
                            //limpiar();
                            // $('#listadosucursal').DataTable().ajax.reload();
                            $('#Tkardex').DataTable().ajax.reload();
                            $("#idAlmacenD").val(datos);
                            alertify.success("Proceso Realizado con exito");
                            $("#btnNuevoDetalle").removeAttr("disabled");
                            $("#grabaAlmacen").attr("disabled", "false");

                        } else {
                            alertify.error("Proceso no se pudo realizar") + " " + datos;
                        }
                    }
                });
            } else {
                alertify.alert("Error al Genera el Codigo");
            }
        }
    );
}

function listarKardex() {
    tablaK = $('#Tkardex').dataTable({
        "aProcessing": true, //Activamos el procesamiento del datatables
        "aServerSide": true, //Paginacion y fltrado realizado por el servidor
        dom: 'Bfrtip', //Definimos los elementos de control de tabla
        buttons: ['copyHtml5', 'excelHtml5', 'pdfHtml5'],
        "ajax": {
            url: '../ajax/kardex.php?op=listarK',
            type: "get",
            dataType: "json",
            error: function(e) {
                console.log(e.responseText);
            }
        },
        "bDestroy": true,
        "iDisplayLenth": 10, //paginacion
        "order": [
                [8, "desc"]
            ] //order los datos
    });
}

function ListarAlmacen(idAlmacen) {
    nuevoAlma();
    $.post("../ajax/kardex.php?op=mostrarA", { idAlmacen: idAlmacen },

        function(data, status) {
            data = JSON.parse(data);
            if (data.id_almacen > 0) {
                ocultaAlma(true);
                $("#idAlmacen").val(data.id_almacen);
                $("#idAlmacenD").val(data.id_almacen);
                $("#codigoAlmacen").val(data.codigo);
                $("#consignado").val(data.id_consignado);
                $("#consignado").selectpicker("refresh");
                $("#contenedor").val(data.contenedor_placa);
                $("#poliza").val(data.poliza);
                $("#referencia").val(data.referencia);
                $("#pesoT").val(data.peso);
                $("#volumenT").val(data.volumen);
                $("#bultosT").val(data.bultos);
                $("#cntClientes").val(data.cant_clientes);
                $("#fechaI").val(data.fechaI);
                $("#btnNuevoDetalle").removeAttr("disabled");
                $("#grabaAlmacen").removeAttr("disabled");
                nuevoDetalle("false");
                listarTablaDA(idAlmacen);
            } else {
                alertify.alert("Error", "Ha ocurrido un error");
            }

        })
}

function grabaDetalle() {
    var cliente = $("#cliente").prop("selectedIndex");
    var peso = $("#peso").val();
    var volumen = $("#volumen").val();
    var bultos = $("#bultos").val();
    var embalaje = $("#embalajeD").prop("selectedIndex");
    var merca = $("#mercaderia").val();

    if (cliente == -1 || cliente == 0) {
        alertify.alert("Campo Vacio", "Debe de seleccionar el Cliente");
        return false;
    } else if (peso == 0) {
        alertify.alert("Campo Vacio", "Debe de colocar el Peso");
        return false;
    } else if (volumen == 0) {
        alertify.alert("Campo Vacio", "Debe de colocar el Volumen");
        return false;
    } else if (bultos == 0) {
        alertify.alert("Campo Vacio", "Debe de colocar los bultos");
        return faslse;
    } else if (embalaje == -1 || embalaje == 0) {
        alertify.alert("Campo Vacio", "Debe de seleccionar Embalaje");
        return false;
    } else if (merca.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de Ingresar Mercaderia");
        return false;
    }
    formDAlmacen = new FormData($("#formAlmacenDetalle")[0]);
    $.ajax({
        url: "../ajax/detalleAlmacen.php?op=guardaryeditar",
        type: "POST",
        data: formDAlmacen,
        contentType: false,
        processData: false,
        success: function(datos) {
            if (datos > 0) {
                $('#Tdetalle').DataTable().ajax.reload();
                $('#Tkardex').DataTable().ajax.reload();
                alertify.success("Proceso Realizado con exito");
                $("#btnNuevoDetalle").removeAttr("disabled");
                nuevoDetalle("false");
            } else {
                alertify.error("Proceso no se pudo realizar") + " " + datos;
            }
        }
    });

}

function listarTablaDA(idAlmacenD) {
    tablaDA = $('#Tdetalle').dataTable({
        "aProcessing": true, //Activamos el procesamiento del datatables
        "aServerSide": true, //Paginacion y fltrado realizado por el servidor
        dom: 'Bfrtip', //Definimos los elementos de control de tabla
        buttons: ['copyHtml5', 'excelHtml5', 'pdfHtml5'],
        "ajax": {
            url: '../ajax/detalleAlmacen.php?op=listarDA',
            type: "post",
            data: { idAlmacenD: idAlmacenD },
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

function listarDetalleA(iddetallealmacen) {
    nuevoDetalle("true");
    $.post("../ajax/detalleAlmacen.php?op=mostrarDetalleA", { iddetallealmacen: iddetallealmacen },

        function(data, status) {
            data = JSON.parse(data);
            if (data.id_detalle > 0) {
                $("#iddetallealmacen").val(data.id_detalle);

                $("#idAlmacenD").val(data.id_almacen);
                $("#cliente").val(data.id_cliente);
                $("#cliente").selectpicker("refresh");

                $("#nohbl").val(data.nohbl);
                $("#peso").val(data.peso);
                $("#volumen").val(data.volumen);
                $("#bultos").val(data.bultos);
                $("#ubicacion").val(data.ubicacion);
                $("#dut").val(data.dut);
                $("#embalajeD").val(data.id_embalaje);
                $("#embalajeD").selectpicker("refresh");
                if (data.liberado == "1") {
                    $("#liberado").prop("checked", "true");

                } else {
                    $("#liberado").removeAttr("checked");
                }
                $("#resa").val(data.resa);
                $("#dti").val(data.dti);
                $("#ncancel").val(data.no_cancel);
                $("#norden").val(data.no_orden);
                $("#linea").val(data.linea);
                $("#mercaderia").val(data.mercaderia);
                $("#observaciones").val(data.observaciones);

            } else {
                alertify.alert("Error", "Ha ocurrido un error");
            }

        })
}

function anulaDetalle(iddetallealmacen) {
    var confirm = alertify.confirm('', 'Desea Anular Detalle', null, null).set('labels', { ok: 'Anular', cancel: 'Cancelar' });

    confirm.set({ transition: 'slide' });

    confirm.set('onok', function() {
        $.post(
            "../ajax/detalleAlmacen.php?op=anularDetalle", { iddetallealmacen: iddetallealmacen },
            function(data) {
                if (data > 0) {
                    $('#Tkardex').DataTable().ajax.reload();
                    alertify.alert("", "Detalle Anulado");
                }

            }
        );
    });

}
init();