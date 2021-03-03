function init() {
    $("#fechaI").datepicker({
        autoclose: true,
    });

    llenaconsignado();
    llenaCliente();
    nuevoDetalle("false");
    ocultaAlma("false");
    //llenaEmpaqueModal();
    llenaEmpaqueDetalle();
    //listarAlmacen();
}

function listarAlmacen() {
    $('#Tkardex').DataTable({

    });
}

function llenaconsignado() {
    $("#consiganado").empty();
    $.post(
        "../modelos/pais.php?op=selecEmpresa&tabla=empresas&campo=Razons", {
            id: "id_empresa",
            tipoe: "CO",
        },
        function(data, status) {
            $("#consiganado").html(data);
            $("#consiganado").selectpicker("refresh");
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
    $("#codigo").val("");
    $("#consiganado").val(0);
    $("#consiganado").selectpicker("refresh");
    $("#contenedor").val("");
    $("#poliza").val("");
    $("#referencia").val("");
    $("#pesoT").val(0);
    $("#volumenT").val(0);
    $("#bultosT").val(0);
    $("#fechaI").val("");
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
    $("#titulomodale").html("Consignado");
    nuevo("consignado");
    $("#llama").val("kardex");

}

function limpiaEmpaque() {
    llenaEmpaqueModal();
    $("#nombreE").val("");
    $("#id_empaque").val(0);
    /*     $("#empaqueB").val(0);
        $("#empaqueB").selectpicker("refresh"); */
}

init();