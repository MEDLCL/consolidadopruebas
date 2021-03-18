var tablaK = "";

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
    //llenaEmpaqueModal();
    //llenaEmpaqueDetalle();
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
    $("#btnNuevoDetalle").attr("disabled", "false")
    $("#grabaAlmacen").removeAttr("disabled");
}

function llenaEmpaqueModal() {
    $.post(
        "../modelos/pais.php?op=selectP&tabla=empaque&campo=nombre", {
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
        "../modelos/pais.php?op=selectP&tabla=empaque&campo=nombre", {
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
                [0, "desc"]
            ] //order los datos
    });
}
init();