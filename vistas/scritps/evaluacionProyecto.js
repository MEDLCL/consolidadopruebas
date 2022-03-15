var tablaunidades;
var tablatarget;
var tablaserviciost;
var tablaProyectos;
var contadorTransporte = 0;
var contadorTarifaFlete = 0;
var contadorServicioT = 0;

function init() {
    llenatipoCargaTransporte();
    tipoUnidadTransporte();
    fechaInicio();
    fechaFinal();
    fianzaTransporte();
    unidadMedida();
    tipoEquipo();
    cajillaSeguridad();
    marchamo();
    gps();
    canalDistribucionPro();
    llenaClienteProyeto();
    seCargaOperacion();
    seDescargaOperacion();
    efectivoOperacion();
    tipoUnidadTarget();
    fianzaTarget();
    servicios();
    $("#listadoEvaluacionesProyecto").show();
    $("#nuevaEvaluacion").hide();
    listarProyectos();
    llenaMoneda("monedaTargetProyecto");
    llenaMoneda("monedaServicioT");

}

function llenaMoneda(selecMoneda) {
    $("#" + selecMoneda).empty();
    $.post("../modelos/pais.php?op=llenaMoneda", {}, function (data, status) {
        $("#" + selecMoneda).html(data);
        $("#" + selecMoneda).selectpicker("refresh");
        $("#" + selecMoneda).val(0);
        $("#" + selecMoneda).selectpicker("refresh");
    });
}

function servicios() {
    $("#servicioTarget").empty();
    $.post(
        "../modelos/pais.php?op=selectN&tabla=catalogo&campo=nombre", {
            id: "id_catalogo",
            tipoe: "",
        },
        function (data, status) {
            $("#servicioTarget").html(data);
            $("#servicioTarget").selectpicker("refresh");
            $("#servicioTarget").val(0);
            $("#servicioTarget").selectpicker("refresh");
        }
    );
}

function fianzaTarget() {
    $("#FianzaTarget").empty();
    $.post(
        "../modelos/pais.php?op=General&tabla=sino&campo=nombre", {
            id: "id_sino",
            tipoe: "",
        },
        function (data, status) {
            $("#FianzaTarget").html(data);
            $("#FianzaTarget").selectpicker("refresh");
            $("#FianzaTarget").val(0);
            $("#FianzaTarget").selectpicker("refresh");
        }
    );
}

function tipoUnidadTarget() {
    $("#tipounidadTarget").empty();
    $.post(
        "../modelos/pais.php?op=selectN&tabla=tipo_unidades_truc&campo=nombre", {
            id: "idtipo_unidades",
            tipoe: "",
        },
        function (data, status) {
            $("#tipounidadTarget").html(data);
            $("#tipounidadTarget").selectpicker("refresh");
            $("#tipounidadTarget").val(0);
            $("#tipounidadTarget").selectpicker("refresh");
        }
    );
}

function efectivoOperacion() {
    $("#manejoEfectivoPro").empty();
    $.post(
        "../modelos/pais.php?op=General&tabla=sino&campo=nombre", {
            id: "id_sino",
            tipoe: "",
        },
        function (data, status) {
            $("#manejoEfectivoPro").html(data);
            $("#manejoEfectivoPro").selectpicker("refresh");
            $("#manejoEfectivoPro").val(0);
            $("#manejoEfectivoPro").selectpicker("refresh");
        }
    );
}

function seDescargaOperacion() {
    $("#seDescargaPro").empty();
    $.post(
        "../modelos/pais.php?op=General&tabla=sino&campo=nombre", {
            id: "id_sino",
            tipoe: "",
        },
        function (data, status) {
            $("#seDescargaPro").html(data);
            $("#seDescargaPro").selectpicker("refresh");
            $("#seDescargaPro").val(0);
            $("#seDescargaPro").selectpicker("refresh");
        }
    );
}

function seCargaOperacion() {

    $("#seCargaPro").empty();
    $.post(
        "../modelos/pais.php?op=General&tabla=sino&campo=nombre", {
            id: "id_sino",
            tipoe: "",
        },
        function (data, status) {
            $("#seCargaPro").html(data);
            $("#seCargaPro").selectpicker("refresh");
            $("#seCargaPro").val(0);
            $("#seCargaPro").selectpicker("refresh");
        }
    );
}

function nuevoClienteProyecto() {
    $(".nav-tabs a:first").tab("show");
    nuevo("cliente");
    $("#llama").val("evaluaProyecto");
    $("#tituloh").html("Cliente");
    //cliente detalle almacen
    $("#queActualizar").val("clienteEva");
    $("#modalempresa").modal("show");
}

function llenaClienteProyeto() {
    $("#clienteEva").empty();
    $.post(
        "../modelos/pais.php?op=selecEmpresa&tabla=empresas&campo=Razons", {
            id: "id_empresa",
            tipoe: "CL",
        },
        function (data, status) {
            $("#clienteEva").html(data);
            $("#clienteEva").selectpicker("refresh");
            $("#clienteEva").val(0);
            $("#clienteEva").selectpicker("refresh");
        }
    );
}

function fechaInicio() {
    $("#finicioPro").datepicker({
        autoclose: true,
    });
    // $("#finicioPro").datepicker("setDate", "0");
}

function fechaFinal() {
    $("#fFinalPro").datepicker({
        autoclose: true,
    });
    // $("#finicioPro").datepicker("setDate", "0");
}

function canalDistribucionPro() {
    //canalDistribucionPro
    $("#canalDistribucionPro").empty();
    $.post(
        "../modelos/pais.php?op=General&tabla=canal_distribucion&campo=nombre", {
            id: "id_canal_distribucion",
            tipoe: "",
        },
        function (data, status) {
            $("#canalDistribucionPro").html(data);
            $("#canalDistribucionPro").selectpicker("refresh");
            $("#canalDistribucionPro").val(0);
            $("#canalDistribucionPro").selectpicker("refresh");
        }
    );
}

function llenatipoCargaTransporte() {
    $("#tipocargaProyecto").empty();
    $.post(
        "../modelos/pais.php?op=selectN&tabla=tipo_carga_empresa&campo=nombre", {
            id: "id_tipo_carga_empresa",
            tipoe: "",
        },
        function (data, status) {
            $("#tipocargaProyecto").html(data);
            $("#tipocargaProyecto").selectpicker("refresh");
            $("#tipocargaProyecto").val(0);
            $("#tipocargaProyecto").selectpicker("refresh");
        }
    );
}

function tipoUnidadTransporte() {
    $("#tipoUnidaPro").empty();
    $.post(
        "../modelos/pais.php?op=selectN&tabla=tipo_unidades_truc&campo=nombre", {
            id: "idtipo_unidades",
            tipoe: "",
        },
        function (data, status) {
            $("#tipoUnidaPro").html(data);
            $("#tipoUnidaPro").selectpicker("refresh");
            $("#tipoUnidaPro").val(0);
            $("#tipoUnidaPro").selectpicker("refresh");
        }
    );
}

function fianzaTransporte() {
    $("#fianzaPro").empty();
    $.post(
        "../modelos/pais.php?op=General&tabla=sino&campo=nombre", {
            id: "id_sino",
            tipoe: "",
        },
        function (data, status) {
            $("#fianzaPro").html(data);
            $("#fianzaPro").selectpicker("refresh");
            $("#fianzaPro").val(0);
            $("#fianzaPro").selectpicker("refresh");
        }
    );
}

function unidadMedida() {
    $("#unidadPesoPro").empty();
    $.post(
        "../modelos/pais.php?op=General&tabla=unidad_medida&campo=nombre", {
            id: "id_unidad_medida",
            tipoe: "",
        },
        function (data, status) {
            $("#unidadPesoPro").html(data);
            $("#unidadPesoPro").selectpicker("refresh");
            $("#unidadPesoPro").val(0);
            $("#unidadPesoPro").selectpicker("refresh");
        }
    );
}

function tipoEquipo() {
    $("#tipoEquipoPro").empty();
    $.post(
        "../modelos/pais.php?op=General&tabla=tipo_equipo_truc&campo=nombre", {
            id: "idtipo_equipo_truc",
            tipoe: "",
        },
        function (data, status) {
            $("#tipoEquipoPro").html(data);
            $("#tipoEquipoPro").selectpicker("refresh");
            $("#tipoEquipoPro").val(0);
            $("#tipoEquipoPro").selectpicker("refresh");
        }
    );
}

function cajillaSeguridad() {
    $("#cajillaSeguridadPro").empty();
    $.post(
        "../modelos/pais.php?op=General&tabla=sino&campo=nombre", {
            id: "id_sino",
            tipoe: "",
        },
        function (data, status) {
            $("#cajillaSeguridadPro").html(data);
            $("#cajillaSeguridadPro").selectpicker("refresh");
            $("#cajillaSeguridadPro").val(0);
            $("#cajillaSeguridadPro").selectpicker("refresh");
        }
    );
}

function marchamo() {
    $("#marchamoPro").empty();
    $.post(
        "../modelos/pais.php?op=General&tabla=sino&campo=nombre", {
            id: "id_sino",
            tipoe: "",
        },
        function (data, status) {
            $("#marchamoPro").html(data);
            $("#marchamoPro").selectpicker("refresh");
            $("#marchamoPro").val(0);
            $("#marchamoPro").selectpicker("refresh");
        }
    );
}

function gps() {
    $("#gpsPro").empty();
    $.post(
        "../modelos/pais.php?op=General&tabla=sino&campo=nombre", {
            id: "id_sino",
            tipoe: "",
        },
        function (data, status) {
            $("#gpsPro").html(data);
            $("#gpsPro").selectpicker("refresh");
            $("#gpsPro").val(0);
            $("#gpsPro").selectpicker("refresh");
        }
    );
}

function nuevoProyecto() {
    limpiaTipoUnidadesTransporte();
    limpiaDatosGenerales();
    //crearCodigo();
    limpiaTarifasTarget();
    limpiaServicioTarget();
    $("#listadoEvaluacionesProyecto").hide();
    $("#nuevaEvaluacion").show();
    $("#btnGrabarProyecto").prop("disabled", false);
    $("#tbodytipounidadtransporte tr").remove();
    $("#tbodytarifastarget tr").remove();
    $("#tbodytarifasserviciosadicional tr").remove();
}

function limpiaDatosGenerales() {
    $('#idproyecto').val(0);
    $('#codigoProyecto').val("");
    $('#clienteEva').val(0);
    $('#clienteEva').selectpicker("refresh");
    $('#finicioPro').val("");
    $('#fFinalPro').val("");
    $('#tipocargaProyecto').val(0);
    $('#tipocargaProyecto').selectpicker("refresh");
    $('#fianzaPro').val(2);
    $('#fianzaPro').selectpicker("refresh");
    $('#pesoPromedioPro').val(0);
    $('#unidadPesoPro').val(1);
    $('#unidadPesoPro').selectpicker("refresh");
    $('#piesCubicosPro').val(0);
    $('#piesCubicosPro').selectpicker("refresh")
    $('#mercaderiaPro').val("");
    $('#permisosEspecialesPro').val("");
    $('#entregasPromedioPro').val("");
    $('#kilometrosPromedioPro').val("");
    $('#frecuenciaViajes').val("");

    $('#seCargaPro').val(2);
    $('#seCargaPro').selectpicker("refresh");

    $('#seDescargaPro').val(2);
    $('#seDescargaPro').selectpicker("refresh");

    $('#manejoEfectivoPro').val(2);
    $('#manejoEfectivoPro').selectpicker("refresh");
    $("#descripcionProyecto").val("");
    $("#diasLibresProyecto").val(0);
    $("#comentarioOperacionPro").val("");

    $("#botasVenta").prop("checked", false);
    $("#chalecoVenta").prop("checked", false);
    $("#lentesVenta").prop("checked", false);
    $("#guantesVenta").prop("checked", false);
    $("#mascarillaVenta").prop("checked", false);
    $("#caretaVenta").prop("checked", false);
    $("#otrosVenta").val("");
    $("#CreaMPreviw").html("");
    $("#tbodyarchivosEvaP tr").remove();
    $("#archivosEvaProyecto").val("");

}

function grabarProyecto() {

    //var codigoProyecto = $('#codigoProyecto').val();
    //var idproyecto = $("#idproyecto").val();
    var idcliente = $('#clienteEva').prop("selectedIndex");
    var fechainicio = $('#finicioPro').val();
    var fechafinal = $('#fFinalPro').val();
    var tipocargaProyecto = $('#tipocargaProyecto').prop("selectedIndex");
    var pesopromedio = $('#pesoPromedioPro').val();
    //var fianzaProyecto = $('#fianzaPro').val();
    var unidadMedida = $('#unidadPesoPro').prop("selectedIndex");
    //var piesCubico = $('#piesCubicosPro').val();
    var mercaderia = $('#mercaderiaPro').val();
    var descripcionProyecto = $("#descripcionProyecto").val();
    //var permisos = $('#permisosEspecialesPro').val();
    //var entregasPromedio = $('#entregasPromedioPro').val();
    //var kilometrosPromedio = $('#kilometrosPromedioPro').val();
    //var frecuenciaViajes = $('#frecuenciaViajes').val();
    //var seCargaPro = $('#seCargaPro').val();
    //var seDescargaPro = $('#seDescargaPro').val();
    //var manejoEfectivoPro = $('#manejoEfectivoPro').val();


    if (idcliente == 0 || idcliente == -1) {
        alertify.alert("Campo Vacio", "Debe de indicar el Cliente");
        return false;
    } else if (fechainicio.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de indicar Fecha Inicio");
        return false;
    } else if (fechafinal.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de indicar Fecha Final");
    } else if (tipocargaProyecto == 0 || tipocargaProyecto == -1) {
        alertify.alert("Campo Vacio", "Debe de indicar Tipo de Carga");
        return false;
    } else if (pesopromedio == 0 || pesopromedio.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de indicar el Peso Promedio");
        return false;
    } else if (unidadMedida == 0 | unidadMedida == -1) {
        alertify.alert("Campo Vacio", "Debe indicar Unidad de medida");
        return false;
    } else if (mercaderia.trim() == "") {
        alertify.alert("Campo Vacio", "Debe indicar Descripción de la Mercaderia");
        return false;
    } else if (descripcionProyecto.trim() == "") {
        alertify.alert("Campo Vacio", "Debe indicar Descripción del Proyecto");
        return false;
    }

    tipocargaProyecto = $('#tipocargaProyecto').val();
    idcliente = $('#clienteEva').val();
    unidadMedida = $('#unidadPesoPro').val();

    var form = new FormData($("#frmEvaluacionProyectoTruck")[0]);

    $.ajax({
        url: "../ajax/evaluacionProyecto.php?op=guardaryeditarProyecto",
        type: "POST",
        data: form,
        cache: false,
        contentType: false,
        processData: false,
        success: function (datos) {
            datos = JSON.parse(datos);
            if (datos.id_evaluacion_proyecto > 0) {
                $("#btnGrabarProyecto").prop("disabled", true);

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

function crearCodigo() {
    var idproyecto = $("#idproyecto").val();
    $.post(
        "../ajax/evaluacionProyecto.php?op=guardaryeditarProyecto", {
            idproyecto: idproyecto,
        },
        function (data) {
            data = JSON.parse(data);
            if (data.id_evaluacion_proyecto >= 1) {
                $("#codigoProyecto").val(data.codigo)
                $('#idproyecto').val(data.id_evaluacion_proyecto);
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

function cancelarProyecto() {
    $("#listadoEvaluacionesProyecto").show();
    $("#nuevaEvaluacion").hide();
    $('#tProyectos').DataTable().ajax.reload();
}

function listarProyectos() {
    tablaProyectos = $('#tProyectos').dataTable({
        "aProcessing": true, //Activamos el procesamiento del datatables
        "aServerSide": true, //Paginacion y fltrado realizado por el servidor
        dom: 'Bfrtip', //Definimos los elementos de control de tabla
        buttons: ['copyHtml5', 'excelHtml5', 'pdfHtml5'],
        "ajax": {
            url: '../ajax/evaluacionProyecto.php?op=listarProyectos',
            type: "post",
            data: {},
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

function listarProyecto(idproyecto) {
    limpiaDatosGenerales();
    $.post(
        "../ajax/evaluacionProyecto.php?op=listarProyecto", {
            idproyecto: idproyecto
        },
        function (data, status) {
            data = JSON.parse(data);
            if (data.idproyecto >= 1) {
                $("#btnGrabarProyecto").prop("disabled", false);
                $('#codigoProyecto').val(data.codigo);
                $("#idproyecto").val(data.idproyecto);
                $('#clienteEva').val(data.id_cliente);
                $('#clienteEva').selectpicker("refresh");
                $('#finicioPro').val(data.fechainicio);
                $('#fFinalPro').val(data.fechafinal);
                $('#tipocargaProyecto').val(data.id_tipo_carga);
                $('#tipocargaProyecto').selectpicker("refresh")
                $('#pesoPromedioPro').val(data.peso);
                $('#fianzaPro').val(data.id_fianza);
                $('#fianzaPro').selectpicker("refresh");
                $('#unidadPesoPro').val(data.id_unidad_media);
                $('#unidadPesoPro').selectpicker("refresh");
                $('#piesCubicosPro').val(data.pies_cubicos);
                $('#mercaderiaPro').val(data.descripcion_mercaderia);
                $('#permisosEspecialesPro').val(data.permisos);
                $('#entregasPromedioPro').val(data.entregas);
                $('#kilometrosPromedioPro').val(data.recorrido);
                $('#frecuenciaViajes').val(data.frecuencua);
                $('#seCargaPro').val(data.id_sercarga);
                $('#seCargaPro').selectpicker("refresh");
                $('#seDescargaPro').val(data.id_serdescarga);
                $('#seDescargaPro').selectpicker("refresh");
                $('#manejoEfectivoPro').val(data.id_efectivo);
                $('#manejoEfectivoPro').selectpicker("refresh");
                $("#descripcionProyecto").val(data.descripcionProyecto);
                $("#diasLibresProyecto").val(data.dias_libres);
                $("#comentarioOperacionPro").val(data.comentario_operacion);
                if (data.botas == 1) {
                    $("#botasVenta").prop("checked", true)
                }
                if (data.chaleco == 1) {
                    $("#chalecoVenta").prop("checked", true);
                }
                if (data.lentes == 1) {
                    $("#lentesVenta").prop("checked", true);
                }
                if (data.guantes == 1) {
                    $("#guantesVenta").prop("checked", true);
                }
                if (data.mascarilla == 1) {
                    $("#mascarillaVenta").prop("checked", true);
                }
                if (data.careta == 1) {
                    $("#caretaVenta").prop("checked", true);
                }
                if (data.id_tipoventa == 2) {
                    $("#idVentaInternacional").show();
                } else {
                    $("#idVentaInternacional").hide();
                }
                $("#otrosVenta").val(data.otros);
                listarUnidadesTransporte(data.idproyecto);
                listarTarifasTarget(data.idproyecto);
                listarServiciosTArget(data.idproyecto);
                listarArchivos(data.idproyecto)
                $("#listadoEvaluacionesProyecto").hide();
                $("#nuevaEvaluacion").show();

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
//unidades de transporte
function limpiaTipoUnidadesTransporte() {
    $("#idtipounidadtransporte").val(0);
    $("#numeroUnidadesPro").val(0);

    $("#tipoUnidaPro").val(0);
    $("#tipoUnidaPro").selectpicker("refresh");

    $("#tipoEquipoPro").val(0);
    $("#tipoEquipoPro").selectpicker("refresh");

    $("#temperaturaPro").val("");
    $("#caracEquipoPro").val("");

    $("#cajillaSeguridadPro").val(2);
    $("#cajillaSeguridadPro").selectpicker("refresh");

    $("#marchamoPro").val(2);
    $("#marchamoPro").selectpicker("refresh");

    $("#gpsPro").val(2);
    $("#gpsPro").selectpicker("refresh");

    $("#lugarCargaPro").val("");
    $("#lugarDescargaPro").val("");
    $("#canalDistribucionPro").val(0);
    $("#canalDistribucionPro").selectpicker("refresh");
}


function registrarUnidadesTransporte() {
    var idproyecto = $("#idproyecto").val();
    var idtipounidadtransporte = $("#idtipounidadtransporte").val();
    var numeroUnidadesPro = $("#numeroUnidadesPro").val();
    var tipoUnidaPro = $("#tipoUnidaPro").prop("selectedIndex");
    var tipoEquipoPro = $("#tipoEquipoPro").prop("selectedIndex");

    var temperaturaPro = $("#temperaturaPro").val();
    var caracEquipoPro = $("#caracEquipoPro").val();

    var cajillaSeguridadPro = $("#cajillaSeguridadPro").val();
    var marchamoPro = $("#marchamoPro").val();
    var gpsPro = $("#gpsPro").val();
    var lugarCargaPro = $("#lugarCargaPro").val();
    var lugarDescargaPro = $("#lugarDescargaPro").val();
    var canalDistribucionPro = $("#canalDistribucionPro").prop("selectedIndex");

    if (numeroUnidadesPro.trim() == "" || numeroUnidadesPro == 0) {
        alertify.alert("Campo Vacio", "Debe de indicar el No. de Unidades");
        return false;
    } else if (tipoUnidaPro == -1 || tipoUnidaPro == 0) {
        alertify.alert("Campo Vacio", "Debe de seleccionar el tipo de Unidad");
        return false;
    } else if (tipoEquipoPro == -1 || tipoEquipoPro == 0) {
        alertify.alert("Campo Vacio", "Debe de seleccionar el tipo de Equipo");
        return false;
    } else if (caracEquipoPro.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de indicar Caracteristicas del Equipo");
        return false;
    } else if (lugarCargaPro.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de indicar Lugar de Carga");
        return false;
    } else if (lugarDescargaPro.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de indicar lugar de Descarga");
        return false;
    } else if (canalDistribucionPro == 0 || canalDistribucionPro == -1) {
        alertify.alert("Campo Vacio", "Debe de indicar Canal de Distribucion");
        return false;
    }
    var fila = 0;

    tipoUnidaPro = $("#tipoUnidaPro").val();
    tipoEquipoPro = $("#tipoEquipoPro").val();
    canalDistribucionPro = $("#canalDistribucionPro").val();

    if (idproyecto > 0) {
        $.ajax({
            url: "../ajax/evaluacionProyecto.php?op=guardaUnidades",
            type: "POST",
            data: {
                "idtipounidadtransporte": idtipounidadtransporte,
                "numeroUnidadesPro": numeroUnidadesPro,
                "tipoUnidaPro": tipoUnidaPro,
                "tipoEquipoPro": tipoEquipoPro,
                "temperaturaPro": temperaturaPro,
                "caracEquipoPro": caracEquipoPro,
                "cajillaSeguridadPro": cajillaSeguridadPro,
                "marchamoPro": marchamoPro,
                "gpsPro": gpsPro,
                "lugarCargaPro": lugarCargaPro,
                "lugarDescargaPro": lugarDescargaPro,
                "canalDistribucionPro": canalDistribucionPro,
                "idproyecto": idproyecto
            },
            success: function (datos) {
                datos = JSON.parse(datos);
                if (datos.idunidadasingada > 0) {
                    limpiaTipoUnidadesTransporte();
                    listarUnidadesTransporte(idproyecto);
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
    } else {

        var tipoUnidaPro1 = $("#tipoUnidaPro option:selected").html();
        var tipoEquipoPro1 = $("#tipoEquipoPro option:selected").html();
        var cajillaSeguridadPro1 = $("#cajillaSeguridadPro option:selected").html();
        var marchamoPro1 = $("#marchamoPro option:selected").html();
        var gpsPro1 = $("#gpsPro option:selected").html();
        var canalDistribucionPro1 = $("#canalDistribucionPro option:selected").html();

        var fila =
            '<tr class="filas" id ="fila' + contadorTransporte + '">' +
            '<td><button type="button" class="btn btn-danger btn-sm" onclick="eliminarTransporte(' + contadorTransporte + ')"><span class="fa fa-trash-o"></span></button>' +
            '<input type="hidden" name="numeroUnidadesProM[]" value= "' + numeroUnidadesPro + '"></td>' +
            '<input type="hidden" name="tipoUnidaProM[]" value= "' + tipoUnidaPro + '"></td>' +
            '<input type="hidden" name="tipoEquipoProM[]" value= "' + tipoEquipoPro + '"></td>' +
            '<input type="hidden" name="temperaturaProM[]" value= "' + temperaturaPro + '"></td>' +
            '<input type="hidden" name="caracEquipoProM[]" value= "' + caracEquipoPro + '"></td>' +
            '<input type="hidden" name="cajillaSeguridadProM[]" value= "' + cajillaSeguridadPro + '"></td>' +
            '<input type="hidden" name="marchamoProM[]" value= "' + marchamoPro + '"></td>' +
            '<input type="hidden" name="gpsProM[]" value= "' + gpsPro + '"></td>' +
            '<input type="hidden" name="lugarCargaProM[]" value= "' + lugarCargaPro + '"></td>' +
            '<input type="hidden" name="lugarDescargaProM[]" value= "' + lugarDescargaPro + '"></td>' +
            '<input type="hidden" name="canalDistribucionProM[]" value= "' + canalDistribucionPro + '"></td>' +

            '<td >' + numeroUnidadesPro + '</td>' +
            '<td >' + tipoUnidaPro1 + '</td>' +
            '<td >' + tipoEquipoPro1 + '</td>' +
            '<td >' + temperaturaPro + '</td>' +
            '<td >' + caracEquipoPro + '</td>' +
            '<td >' + cajillaSeguridadPro1 + '</td>' +
            '<td >' + marchamoPro1 + '</td>' +
            '<td >' + gpsPro1 + '</td>' +
            '<td >' + lugarCargaPro + '</td>' +
            '<td >' + lugarDescargaPro + '</td>' +
            '<td >' + canalDistribucionPro1 + '</td>' +
            '</tr>';
        contadorTransporte++;

        $('#tbodytipounidadtransporte').append(fila);
        limpiaTipoUnidadesTransporte();
    }
}

function listarUnidadesTransporte(idproyecto) {
    limpiaTipoUnidadesTransporte();
    tablaunidades = $('#TuniadesAsignadas').dataTable({
        "aProcessing": true, //Activamos el procesamiento del datatables
        "aServerSide": true, //Paginacion y fltrado realizado por el servidor
        dom: 'Bfrtip', //Definimos los elementos de control de tabla
        buttons: ['copyHtml5', 'excelHtml5', 'pdfHtml5'],
        "ajax": {
            url: '../ajax/evaluacionProyecto.php?op=listarUnidades',
            type: "post",
            data: {
                idproyecto: idproyecto
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

function listarUnidad(idtipounidadtransporte) {

    $.post(
        "../ajax/evaluacionProyecto.php?op=listarUnidad", {
            idtipounidadtransporte: idtipounidadtransporte
        },
        function (data, status) {
            data = JSON.parse(data);
            if (data.id_asigna_unidad >= 1) {
                $("#idtipounidadtransporte").val(data.id_asigna_unidad);
                $("#numeroUnidadesPro").val(data.cantidad_unidad);
                $("#tipoUnidaPro").val(data.id_tipo_unidad);
                $("#tipoUnidaPro").selectpicker("refresh");

                $("#tipoEquipoPro").val(data.id_tipo_equipo);
                $("#tipoEquipoPro").selectpicker("refresh");

                $("#temperaturaPro").val(data.temperatura);
                $("#caracEquipoPro").val(data.especificacion);

                $("#cajillaSeguridadPro").val(data.id_seguridad);
                $("#cajillaSeguridadPro").selectpicker("refresh");

                $("#marchamoPro").val(data.id_marchamo);
                $("#marchamoPro").selectpicker("refresh");

                $("#gpsPro").val(data.id_gps);
                $("#gpsPro").selectpicker("refresh");

                $("#lugarCargaPro").val(data.lugar_carga);
                $("#lugarDescargaPro").val(data.lugar_descarga);
                $("#canalDistribucionPro").val(data.id_canal_distribucion);
                $("#canalDistribucionPro").selectpicker("refresh");
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
// tarifas target
function limpiaTarifasTarget() {
    $("#idtarifatarget").val(0);
    $("#FianzaTarget").val(2);
    $("#FianzaTarget").selectpicker("refresh");
    $("#tarifaVentaFleteProyecto").val(0);
    $("#tarifaCostoFleteProyecto").val(0);

    $("#monedaTargetProyecto").val(3);
    $("#monedaTargetProyecto").selectpicker("refresh");

    $("#lugarCargaTarget").val("");
    $("#lugarDescargaTarget").val("");

    $("#tipounidadTarget").val(0);
    $("#tipounidadTarget").selectpicker("refresh");


}

function registraTarifasTarget() {
    var idproyecto = $("#idproyecto").val();
    var idtarifatarget = $("#idtarifatarget").val();
    var tipounidadTarget = $("#tipounidadTarget").prop("selectedIndex");
    var tarifaVentaFleteProyecto = $("#tarifaVentaFleteProyecto").val();
    var tarifaCostoFleteProyecto = $("#tarifaCostoFleteProyecto").val();

    var monedaTargetProyecto = $("#monedaTargetProyecto").prop("selectedIndex");

    var lugarCargaTarget = $("#lugarCargaTarget").val();
    var lugardescargaTarget = $("#lugarDescargaTarget").val();
    var fianzaTarget = $("#FianzaTarget").val();
    var fila = "";

    if (tipounidadTarget == -1 || tipounidadTarget == 0) {
        alertify.alert("Campo Vacio", "Debe de indicar el Tipo de Unidad");
        return false;
    }

    tipounidadTarget = $("#tipounidadTarget").val();
    monedaTargetProyecto = $("#monedaTargetProyecto").val();

    if (idproyecto > 0) {
        $.ajax({
            url: "../ajax/evaluacionProyecto.php?op=guardaTarifasT",
            type: "POST",
            data: {
                "idproyecto": idproyecto,
                "idtarifatarget": idtarifatarget,
                "tipounidadTarget": tipounidadTarget,
                "lugarCargaTarget": lugarCargaTarget,
                "lugardescargaTarget": lugardescargaTarget,
                "fianzaTarget": fianzaTarget,
                "tarifaVentaFleteProyecto": tarifaVentaFleteProyecto,
                "tarifaCostoFleteProyecto": tarifaCostoFleteProyecto,
                "monedaTargetProyecto": monedaTargetProyecto

            },
            success: function (datos) {
                datos = JSON.parse(datos);
                if (datos.idtarifa_target > 0) {
                    limpiaTarifasTarget();
                    listarTarifasTarget(idproyecto);
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
    } else {

        var idtipounidadTarget = $("#tipounidadTarget").val();
        tipounidadTarget = $("#tipounidadTarget option:selected").html();
        var moneda = $("#monedaTargetProyecto option:selected").html();
        var idfianzaTarget = $("#FianzaTarget").val();
        fianzaTarget = $("#FianzaTarget option:selected").html();

        fila =
            '<tr class="filas" id ="filaTF' + contadorTarifaFlete + '">' +
            '<td><button type="button" class="btn btn-danger btn-sm" onclick="eliminarTargetFlete(' + contadorTarifaFlete + ')"><span class="fa fa-trash-o"></span></button>' +
            '<input type="hidden" name="tipounidadTargetM[]" value= "' + idtipounidadTarget + '"></td>' +
            '<input type="hidden" name="fianzaTargetM[]" value= "' + idfianzaTarget + '"></td>' +
            '<input type="hidden" name="tarifaVentaFleteProyectoM[]" value= "' + tarifaVentaFleteProyecto + '"></td>' +
            '<input type="hidden" name="tarifaCostoFleteProyectoM[]" value= "' + tarifaCostoFleteProyecto + '"></td>' +
            '<input type="hidden" name="monedaTargetProyectoM[]" value= "' + monedaTargetProyecto + '"></td>' +
            '<input type="hidden" name="lugarCargaTargetM[]" value= "' + lugarCargaTarget + '"></td>' +
            '<input type="hidden" name="lugardescargaTargetM[]" value= "' + lugardescargaTarget + '"></td>' +

            '<td >' + tipounidadTarget + '</td>' +
            '<td >' + fianzaTarget + '</td>' +
            '<td >' + tarifaVentaFleteProyecto + '</td>' +
            '<td >' + tarifaCostoFleteProyecto + '</td>' +
            '<td >' + moneda + '</td>' +
            '<td >' + lugarCargaTarget + '</td>' +
            '<td >' + lugardescargaTarget + '</td>' +
            '</tr>';
        contadorTarifaFlete++;

        $('#tbodytarifastarget').append(fila);
        limpiaTarifasTarget();
    }
}

function eliminarTargetFlete(idtarifatarget) {
    var idproyecto = $("#idproyecto");
    if (idproyecto == 0) {
        $('#filaTF' + idtarifatarget).remove();
    } else {
        $.post("../ajax/evaluacionProyecto.php?op=eliminaTarifaTF", {
                idproyecto: idproyecto,
                idtarifatarget: idtarifatarget
            },
            function (data) {
                if (data == 1) {
                    $('#filaTF' + idtarifatarget).remove();
                    alertify.warning("Tarifa eliminado");
                } else {
                    alertify.error("Tarifa no se pudo eliminar");
                }
            }
        );
    }
}

function listarTarifasTarget(idproyecto) {
    limpiaTarifasTarget();
    $('#tTarifasTarget').dataTable({
        "aProcessing": true, //Activamos el procesamiento del datatables
        "aServerSide": true, //Paginacion y fltrado realizado por el servidor
        dom: 'Bfrtip', //Definimos los elementos de control de tabla
        buttons: ['copyHtml5', 'excelHtml5', 'pdfHtml5'],
        "ajax": {
            url: '../ajax/evaluacionProyecto.php?op=listarTarifasT',
            type: "post",
            data: {
                idproyecto: idproyecto
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

function listaTarifa(idtarifatarget) {

    $.post(
        "../ajax/evaluacionProyecto.php?op=listarTarifa", {
            idtarifatarget: idtarifatarget
        },
        function (data, status) {
            data = JSON.parse(data);
            if (data.idtarifa_target >= 1) {
                $("#idtarifatarget").val(data.idtarifa_target);
                $("#tipounidadTarget").val(data.id_tipo_unidad);
                $("#tipounidadTarget").selectpicker("refresh");
                $("#lugarCargaTarget").val(data.lugar_carga);
                $("#lugarDescargaTarget").val(data.lugar_descarga);
                $("#FianzaTarget").val(data.id_fianza);
                $("#FianzaTarget").selectpicker("refresh");
                $("#tarifaVentaFleteProyecto").val(data.venta);
                $("#tarifaCostoFleteProyecto").val(data.costo);
                $("#monedaTargetProyecto").val(data.id_moneda);
                $("#monedaTargetProyecto").selectpicker("refresh");

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
/* 
function listarTarifasTarget(idproyecto) {
    tablatarget = $('#tTarifasTarget').dataTable({
        "aProcessing": true, //Activamos el procesamiento del datatables
        "aServerSide": true, //Paginacion y fltrado realizado por el servidor
        dom: 'Bfrtip', //Definimos los elementos de control de tabla
        buttons: ['copyHtml5', 'excelHtml5', 'pdfHtml5'],
        "ajax": {
            url: '../ajax/evaluacionProyecto.php?op=listarTarifasT',
            type: "post",
            data: {
                idproyecto: idproyecto
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
} */

function limpiaServicioTarget() {
    $("#idserviciotarget").val(0);
    $("#servicioTarget").val(0);
    $("#servicioTarget").selectpicker("refresh");
    $("#lugarCargaTargetServicios").val("");
    $("#lugarDescargaTargetServicios").val("");
    $("#tarifaVentaServicioT").val(0);
    $("#tarifaCostoServicioT").val(0);
    $("#monedaServicioT").val(3);
    $("#monedaServicioT").selectpicker("refresh");
}

function grabaServicioTarget() {
    var idproyecto = $("#idproyecto").val();
    var idserviciotarget = $("#idserviciotarget").val();
    var servicioTarget = $("#servicioTarget").prop("selectedIndex");
    var lugarCargaTargetServicios = $("#lugarCargaTargetServicios").val();
    var tarifaVentaServicioT = $("#tarifaVentaServicioT").val();
    var tarifaCostoServicioT = $("#tarifaCostoServicioT").val();
    var lugarDescargaTargetServicios = $("#lugarDescargaTargetServicios").val();
    var idmonedaServicioT = $("#monedaServicioT").val();

    var fila = '';

    if (servicioTarget == -1 || servicioTarget == 0) {
        alertify.alert("Campo Vacio", "Debe de indicar el Tipo de Servicio");
        return false;
    }
    servicioTarget = $("#servicioTarget").val();

    if (idproyecto > 0) {
        $.ajax({
            url: "../ajax/evaluacionProyecto.php?op=grabaServicioTarget",
            type: "POST",
            data: {
                "idproyecto": idproyecto,
                "idserviciotarget": idserviciotarget,
                "servicioTarget": servicioTarget,
                "lugarCargaTargetServicios": lugarCargaTargetServicios,
                "lugarDescargaTargetServicios": lugarDescargaTargetServicios,
                "tarifaVentaServicioT": tarifaVentaServicioT,
                "tarifaCostoServicioT": tarifaCostoServicioT,
                "idmonedaServicioT": idmonedaServicioT
            },
            success: function (datos) {
                datos = JSON.parse(datos);
                if (datos.id_servicio_target > 0) {
                    limpiaServicioTarget()
                    listarServiciosTArget(idproyecto)
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
    } else {

        var servicio = $("#servicioTarget option:selected").html();
        var moneda = $("#monedaServicioT option:selected").html();

        fila =
            '<tr class="filas" id ="filaTS' + contadorServicioT + '">' +
            '<td><button type="button" class="btn btn-danger btn-sm" onclick="eliminarServicioTarget(' + contadorServicioT + ')"><span class="fa fa-trash-o"></span></button>' +
            '<input type="hidden" name="idserviciotargetM[]" value= "' + idserviciotarget + '"></td>' +
            '<input type="hidden" name="tarifaVentaServicioTM[]" value= "' + tarifaVentaServicioT + '"></td>' +
            '<input type="hidden" name="tarifaCostoServicioTM[]" value= "' + tarifaCostoServicioT + '"></td>' +
            '<input type="hidden" name="idmonedaServicioTM[]" value= "' + idmonedaServicioT + '"></td>' +
            '<input type="hidden" name="lugarCargaTargetServiciosM[]" value= "' + lugarCargaTargetServicios + '"></td>' +
            '<input type="hidden" name="lugarDescargaTargetServiciosM[]" value= "' + lugarDescargaTargetServicios + '"></td>' +

            '<td >' + servicio + '</td>' +
            '<td >' + tarifaVentaServicioT + '</td>' +
            '<td >' + tarifaCostoServicioT + '</td>' +
            '<td >' + moneda + '</td>' +
            '<td >' + lugarCargaTargetServicios + '</td>' +
            '<td >' + lugarDescargaTargetServicios + '</td>' +
            '</tr>';
        contadorServicioT++;

        $('#tbodytarifasserviciosadicional').append(fila);
        limpiaServicioTarget();
    }
}

function eliminarServicioTarget(idserviciotarget) {
    var idproyecto = $("#idproyecto");
    if (idproyecto == 0) {
        $('#filaTS' + idserviciotarget).remove();
    } else {
        $.post("../ajax/evaluacionProyecto.php?op=eliminaTarifaTF", {
                idproyecto: idproyecto,
                idserviciotarget: idserviciotarget
            },
            function (data) {
                if (data == 1) {
                    $('#filaTS' + idserviciotarget).remove();
                    alertify.warning("Servicio Target eliminado");
                } else {
                    alertify.error("Servicio Target no se pudo eliminar");
                }
            }
        );
    }
}

function listarServicio(idserviciotarget) {
    limpiaServicioTarget();
    $.post(
        "../ajax/evaluacionProyecto.php?op=listarServicoTarget", {
            idserviciotarget: idserviciotarget
        },
        function (data, status) {
            data = JSON.parse(data);
            if (data.id_servicio_target >= 1) {
                $("#idserviciotarget").val(data.id_servicio_target);
                $("#servicioTarget").val(data.id_servicio);
                $("#servicioTarget").selectpicker("refresh");
                $("#lugarCargaTargetServicios").val(data.lugar_carga);
                $("#lugarDescargaTargetServicios").val(data.lugar_descarga);
                $("#monedaServicioT").val(data.id_moneda);
                $("#monedaServicioT").selectpicker("refresh");
                $("#tarifaVentaServicioT").val(data.venta);
                $("#tarifaCostoServicioT").val(data.costo);
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

function listarServiciosTArget(idproyecto) {
    $('#tServcioTarget').dataTable({
        "aProcessing": true, //Activamos el procesamiento del datatables
        "aServerSide": true, //Paginacion y fltrado realizado por el servidor
        dom: 'Bfrtip', //Definimos los elementos de control de tabla
        buttons: ['copyHtml5', 'excelHtml5', 'pdfHtml5'],
        "ajax": {
            url: '../ajax/evaluacionProyecto.php?op=listarServiosTarget',
            type: "post",
            data: {
                idproyecto: idproyecto
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

function modalCalogoEvaluacion() {
    limpiarmodalCatalogo();
    $("#llamaCalculoA").val("evaluaProyectoTruck");
    $("#modalCatalogo").modal("show");
    llenaCatalogoModal();
}

function agregaPreviuw(archivos) {
    $("#CreaMPreviw").html("");
    for (var i = 0; i < archivos.files.length; i++) {
        if (archivos.files[i]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                var img = $('<img id="dynamic"  width = "50px" height = "50px">');
                img.attr("src", e.target.result);
                img.appendTo("#CreaMPreviw");
            };
            reader.readAsDataURL(archivos.files[i]);
        }
    }
}

function listarArchivos(idproyecto) {
    $.post(
        "../ajax/evaluacionProyecto.php?op=listarArchivos", {
            idproyecto: idproyecto,
        },
        function (data, status) {
            $('#tbodyarchivosEvaP').append(data);
        }
    );
}

function reporteEvaluacion(tipo) {
    var idproyecto = $("#idproyecto").val();
    if (tipo ==1){
        const ruta = '../reportes/evaluacionProyecto.php?idproyecto='+idproyecto;
        //const ruta1 = "<iframe id='' src='../reportes/tarifarioProyecto.php?idproyecto='"+idproyecto+"'&codigo='"+codigo+"'> </iframe>";
        window.open(ruta);
    }else{
        $.post(
            '../reportes/evaluacionProyecto.php?idproyecto='+idproyecto, {
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

function reporteTarifario(tipo) {
    var idproyecto = $("#codigoProyecto").prop("selectedIndex");
    if (idproyecto == 0 || idproyecto == -1){
        alertify.alert("Campo Vacio","Debe de seleccionar un Codigo de proyecto");
        return false;
    }
    var idproyecto = $("#codigoProyecto").val();
    var codigo = $("#codigoProyecto option:selected").html();
    idproyecto = $("#codigoProyecto").val();
    //alertify.alert("mensaje", data.mensaje);
    if (tipo ==1){
        const ruta = '../reportes/tarifarioProyecto.php?idproyecto='+idproyecto+'&codigo='+codigo;
        //const ruta1 = "<iframe id='' src='../reportes/tarifarioProyecto.php?idproyecto='"+idproyecto+"'&codigo='"+codigo+"'> </iframe>";
        window.open(ruta);
    }else{
        $.post(
            '../reportes/tarifarioProyecto.php?idproyecto='+idproyecto+'&codigo='+codigo, {
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