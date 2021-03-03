function init() {
    $("#fechaI").datepicker({
        autoclose: true,
    });
    $('#Tkardex').DataTable();
    
    llenaconsignado();
    llenaCliente();
    nuevoDetalle("false");
    ocultaAlma("false");
}

function llenaconsignado() {
    $.post(
        "../modelos/pais.php?op=selecEmpresa&tabla=empresas&campo=Razons", {
            id: "id_empresa",
            tipoe: "CO",
        },
        function (data, status) {
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
        function (data, status) {
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
    $("#embalaje").val(0);
    $("#embalaje").selectpicker("refresh");
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
init();