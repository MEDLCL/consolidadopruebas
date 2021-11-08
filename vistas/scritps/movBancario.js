var tablaCuentas;
var tablamovimientos;

function init() {
    $("#divBanco").hide();
    fechamovBancario();
    llenaMoneda();
    llenaBancos("movBanco");
    llenatipooperacion();
    listarMovimientosBancarios();
    $("#btngrabaMovimiento").prop("disabled", true);
}

function llenatipooperacion() {
    $("#tipoOperacion").empty();
    $.post(
        "../modelos/pais.php?op=General&tabla=tipo_operacion_bancos&campo=nombre", {
            id: "id_tipo_operacion",
            tipoe: "",
        },
        function (data, status) {
            $("#tipoOperacion").html(data);
            $("#tipoOperacion").selectpicker("refresh");
            $("#tipoOperacion").val(0);
            $("#tipoOperacion").selectpicker("refresh");
        }
    );
}

function cargaCuentasMov(idcuenta) {
    $("#movcuentaBancaria").empty();
    var idpadre = $("#movBanco").val();
    $.post(
        "../modelos/pais.php?op=cuentaBanco", {
            id: "id_ciudad",
            tipoe: "",
            idpadre: idpadre,
        },
        function (data, status) {
            $("#movcuentaBancaria").html(data);
            $("#movcuentaBancaria").selectpicker("refresh");
            $("#movcuentaBancaria").val(idcuenta);
            $("#movcuentaBancaria").selectpicker("refresh");
        }
    );
}

function llenaBancos(banco) {
    $("#" + banco).empty();
    $.post(
        "../modelos/pais.php?op=selectN&tabla=banco&campo=nombre", {
            id: "id_banco",
            tipoe: "",
        },
        function (data, status) {
            $("#" + banco).html(data);
            $("#" + banco).selectpicker("refresh");
            $("#" + banco).val(0);
            $("#" + banco).selectpicker("refresh");
        }
    );
}

function fechamovBancario() {
    $("#movFechaOperacion").datepicker({
        autoclose: true,
    });
    $("#movFechaOperacion").datepicker("setDate", "0");
}

function mostrarNuevaCuenta() {
    $("#divCuentas").show();
    $("#divListadoCuentas").hide();
    limpiarCuenta();
    $("#btnGrabarCuenta").removeClass("btn-warning");
    $("#btnGrabarCuenta").addClass("btn-primary");
    $("#btnGrabarCuenta").html("Graba");
}

function limpiarCuenta() {
    $("#nombreCuentaNuevo").val("");
    $("#numeroCuentaNuevo").val("");
    $("#monedaCuentaBanco").val(0);
    $("#monedaCuentaBanco").selectpicker("refresh");
    $("#idcuenta").val(0);
}

function nuevaCuenta() {
    limpiarCuenta();
    $("#btnGrabarCuenta").removeClass("btn-warning");
    $("#btnGrabarCuenta").addClass("btn-primary");
    $("#btnGrabarCuenta").html("Graba");
    $("#btnGrabarCuenta").prop("disabled", false);
}

function cancelarBanco() {
    $("#divBanco").hide();
    $("#divMovBancarios").show();
    $("#divTblMovBancarios").show();
}

function nuevoBanco() {
    limpiarBanco();
    $("#slcBanco").val(0);
    $("#slcBanco").selectpicker("refresh");
    $("#btnGrabarBanco").prop("disabled", false);
    $("#btnGrabarBanco").removeClass("btn-warning");
    $("#btnGrabarBanco").addClass("btn-primary");
    $("#btnGrabarBanco").html("Graba");
}

function habilitarNuevoBanco() {
    limpiarBanco();
    $("#divBanco").show();
    $("#divMovBancarios").hide();
    $("#divTblMovBancarios").hide();
    $("#divCuentas").hide();

    llenaBancos("slcBanco");
    $("#btnGrabarBanco").prop("disabled", true);
    $("#btnGrabarCuenta").prop("disabled", true);
}

function limpiarBanco() {
    $("#idbanco").val(0);
    $("#nombreBanco").val("");
    $("#ejecutivo").val("");
    $("#telefonobanco").val("");
    $("#extensionBanco").val("");
    $("#correo").val("");
    $("#bancoObser").val("");
}

function llenaMoneda() {
    $("#monedaCuentaBanco").empty();
    $.post("../modelos/pais.php?op=llenaMoneda", {}, function (data, status) {
        $("#monedaCuentaBanco").html(data);
        $("#monedaCuentaBanco").selectpicker("refresh");
        $("#monedaCuentaBanco").val(0);
        $("#monedaCuentaBanco").selectpicker("refresh");
    });
}

function grabaEditaBanco() {
    var nombre = $("#nombreBanco").val();
    var correo = $("#correo").val();

    if (nombre.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de colocar el nombre del Banco");
        return false;
    }
    if (correo.trim() != "") {
        if (validaCorreo(correo) == false) {
            alertify.alert("Validando", "Debe de ingresar un correo valido");
            return false;
        }
    }
    var form = new FormData($("#frmbanco")[0]);
    $.ajax({
        url: "../ajax/banco.php?op=guardaryeditar",
        type: "POST",
        data: form,
        cache: false,
        contentType: false,
        processData: false,
        success: function (data) {
            data = JSON.parse(data);
            if (data.idbanco > 0) {
                $("#idbanco").val(data.idbanco);
                $("#btnGrabarBanco").prop("disabled", true);
                llenaBancos("movBanco");
                llenaBancos("slcBanco");
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

function grabaEditaCuenta() {
    var nombre = $("#nombreCuentaNuevo").val();
    var numeroC = $("#numeroCuentaNuevo").val();
    var moneda = $("#monedaCuentaBanco").prop("selectedIndex");

    var banco = $("#slcBanco").prop("selectedIndex");

    if (banco == -1 || banco == 0) {
        alertify.alert("Campo Vacio", "Debe de Seleccionar un Banco");
        return false;
    }
    if (nombre.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de colocar el nombre del la Cuenta");
        return false;
    }

    if (numeroC.trim() == "" || numeroC.trim() == 0) {
        alertify.alert("Campo Vacio", "Debe de ingresar un No. de Cuenta");
        return false;
    }
    if (moneda == -1 || moneda == -0) {
        alertify.alert("Campo Vacio", "Debe de seleccionar la moneda");
        return false;
    }

    var form = new FormData($("#frmbanco")[0]);
    $.ajax({
        url: "../ajax/cuentaBanco.php?op=guardaryeditar",
        type: "POST",
        data: form,
        cache: false,
        contentType: false,
        processData: false,
        success: function (data) {
            data = JSON.parse(data);
            if (data.idcuenta > 0) {
                $("#idcuenta").val(data.idcuenta);
                $("#divListadoCuentas").show();
                $("#divCuentas").hide();
                listarCuentas();
                $("#btnGrabarCuenta").prop("disabled", true);
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

function cancelarCuenta() {
    $("#divListadoCuentas").show();
    $("#divCuentas").hide();
}

function mostrarBanco() {
    var idbanco = $("#slcBanco").val();
    limpiarBanco();
    $.post(
        "../ajax/banco.php?op=mostarBanco", {
            idbanco: idbanco,
        },
        function (data, status) {
            data = JSON.parse(data);
            if (data.id_banco > 0) {
                $("#idbanco").val(data.id_banco);
                $("#nombreBanco").val(data.nombre);
                $("#ejecutivo").val(data.ejecutivo);
                $("#telefonobanco").val(data.telefono);
                $("#extensionBanco").val(data.extension);
                $("#correo").val(data.correo);
                $("#bancoObser").val(data.observaciones);
                listarCuentas();
                $("#bancoObser").val(data.observaciones);
                $("#btnGrabarBanco").removeClass("btn-primary");
                $("#btnGrabarBanco").addClass("btn-warning");
                $("#btnGrabarBanco").html("Actualizar Cambios");
                $("#btnGrabarBanco").prop("disabled", false);
            }
        }
    );
}

function listarCuentas() {
    var slcBanco = $("#slcBanco").val();
    $("#idbanco").val(slcBanco);
    tablaCuentas = $("#tblCuentasBancos").dataTable({
        aProcessing: true, //Activamos el procesamiento del datatables
        aServerSide: true, //Paginacion y fltrado realizado por el servidor
        dom: "Bfrtip", //Definimos los elementos de control de tabla
        buttons: ["copyHtml5", "excelHtml5", "pdfHtml5"],
        ajax: {
            url: "../ajax/cuentaBAnco.php?op=listarCuentas",
            type: "post",
            data: {
                slcBanco: slcBanco,
            },
            dataType: "json",
            error: function (e) {
                console.log(e.responseText);
            },
        },
        bDestroy: true,
        iDisplayLenth: 5, //paginacion
        order: [
            [0, "desc"]
        ], //order los datos
    });
}

function mostrarCuenta(idcuenta) {
    limpiarCuenta();
    $.post(
        "../ajax/cuentaBanco.php?op=mostarCuenta", {
            idcuenta: idcuenta,
        },
        function (data, status) {
            data = JSON.parse(data);
            if (data.idcuenta_bancaria > 0) {
                $("#divCuentas").show();
                $("#divListadoCuentas").hide();
                $("#idcuenta").val(data.idcuenta_bancaria);
                $("#nombreCuentaNuevo").val(data.nombre);
                $("#numeroCuentaNuevo").val(data.numero_cuenta);
                $("#monedaCuentaBanco").val(data.id_moneda);
                $("#monedaCuentaBanco").selectpicker("refresh");
                $("#btnGrabarCuenta").removeClass("btn-primary");
                $("#btnGrabarCuenta").addClass("btn-warning");
                $("#btnGrabarCuenta").html("Actualizar Cambios");
                $("#btnGrabarCuenta").prop("disabled", false);
            }
        }
    );
}

function nuevoMoviemintoBancario() {
    $("#idmovbancario").val(0);
    $("#movBanco").val(0);
    $("#movBanco").selectpicker("refresh");
    $("#movcuentaBancaria").val(0);
    $("#movcuentaBancaria").selectpicker("refresh");
    $("#tipoOperacion").val(0);
    $("#tipoOperacion").selectpicker("refresh");
    $("#movMonto").val(0);
    $("#movChequeCaja").val(0);
    $("#movFechaOperacion").datepicker("setDate", "0");
    $("#movNoOperacion").val(0);
    $("#movAnombreDe").val("");
    $("#movObservaciones").val("");
    $("#btngrabaMovimiento").removeClass("btn-waraning");
    $("#btngrabaMovimiento").addClass("btn-primary");
    $("#btngrabaMovimiento").html("Grabar");
    $("#btngrabaMovimiento").prop("disabled", false);
}

function grabarEditarMovbancario() {
    var banco = $("#movBanco").prop("selectedIndex");
    var cuenta = $("#movcuentaBancaria").prop("selectedIndex");
    var tipo = $("#tipoOperacion").prop("selectedIndex");

    var monto = $("#movMonto").val();
    var nooperacion = $("#movNoOperacion").val();
    var beneficiario = $("#movAnombreDe").val();
    var fecha = $("#movFechaOperacion").val();

    if (banco == 0 || banco == -1) {
        alertify.alert("Campo Vacio", "Debe de seleccionar un Banco");
        return false;
    } else if (cuenta == 0 || cuenta == -1) {
        alertify.alert("Campo Vacio", "Debe de seleccionar una Cuenta");
        return false;
    } else if (tipo == 0 || tipo == -1) {
        alertify.alert("Campo Vacio", "Debe de seleccionar Tipo de Operacion");
        return false;
    } else if (monto.trim() == "" || monto == 0) {
        alertify.alert("Campo Vacio", "Debe de colocar el Monto");
        return false;
    } else if (nooperacion.trim() == "" || nooperacion == 0) {
        alertify.alert("Campo Vacio", "Debe de colocar el numero de Operacion");
        return false;
    } else if (beneficiario.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de indicar el Beneficiario");
        return false;
    } else if (fecha.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de indicar la Fecha");
        return false;
    }
    var form = new FormData($("#frmMovBancario")[0]);
    $.ajax({
        url: "../ajax/movBancario.php?op=guardaryeditar",
        type: "POST",
        data: form,
        cache: false,
        contentType: false,
        processData: false,
        success: function (data) {
            data = JSON.parse(data);
            if (data.idmovimiento > 0) {
                $("#idmovbancario").val(data.idmovimiento);
                $("#btngrabaMovimiento").prop("disabled", true);
                $("#tblMovBancario").DataTable().ajax.reload();
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

function listarMovimientosBancarios() {
    tablamovimientos = $("#tblMovBancario").dataTable({
        aProcessing: true, //Activamos el procesamiento del datatables
        aServerSide: true, //Paginacion y fltrado realizado por el servidor
        dom: "Bfrtip", //Definimos los elementos de control de tabla
        buttons: ["copyHtml5", "excelHtml5", "pdfHtml5"],
        ajax: {
            url: "../ajax/movBancario.php?op=listarMov",
            type: "post",
            dataType: "json",
            error: function (e) {
                console.log(e.responseText);
            },
        },
        bDestroy: true,
        iDisplayLenth: 5, //paginacion
        order: [
            [0, "desc"]
        ], //order los datos
    });
}

function mostrarMovimientobancario(idmovbancario) {
    nuevoMoviemintoBancario();
    $.post(
        "../ajax/movbancario.php?op=mostrarMov", {
            idmovbancario: idmovbancario,
        },
        function (data, status) {
            data = JSON.parse(data);
            if (data.id_movimiento >= 1) {
                $("#movBanco").val(data.id_banco);
                $("#movBanco").selectpicker("refresh");
                $("#movcuentaBancaria").val(data.id_banco);
                $("#movcuentaBancaria").selectpicker("refresh");
                cargaCuentasMov(data.id_cuenta);
                $("#tipoOperacion").val(data.id_tipo_operacion);
                $("#movMonto").val(data.monto);
                $("#movChequeCaja").val(data.comision);
                $("#movFechaOperacion").val(data.fecha_operacion);
                $("#movNoOperacion").val(data.no_operacion);
                $("#movAnombreDe").val(data.beneficiario);
                $("#movObservaciones").val(data.observaciones);

                $("#btngrabaMovimiento").removeClass("btn-primary");
                $("#btngrabaMovimiento").addClass("btn-warning");
                $("#btngrabaMovimiento").html("Actualizar Cambios");
                $("#btngrabaMovimiento").prop("disabled", false);
            } else {
                Swal.fire({
                    icon: "error",
                    title: "",
                    text: "Error al Mostrar los datos",
                });
            }
        });
}

function anularMovimiento(idmovbancario) {
    Swal.fire({
        title: 'Esta seguro de Anular?',
        showDenyButton: true,
        showCancelButton: true,
        confirmButtonText: 'si',
        denyButtonText: `No`,
    }).then((result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            $.post(
                "../ajax/movbancario.php?op=AnularMov", {
                    idmovbancario: idmovbancario,
                },
                function (data, status) {
                    data = JSON.parse(data);
                    if (data.idmovbancario >= 1) {
                        Swal.fire({
                            icon: "success",
                            title: "",
                            text: data.mensaje,
                        });
                        $("#tblMovBancario").DataTable().ajax.reload();
                    } else {
                        Swal.fire({
                            icon: "error",
                            title: "",
                            text: "Error al Mostrar los datos",
                        });
                    }
                });

        } else if (result.isDenied) {
            Swal.fire('No se Anulo', '', 'info')
        }
    })


}
init();