var tablaunidades;
var tablatarget;
var tablaserviciost;
var tablaProyectos;
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

}
function servicios(){
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

function fianzaTarget(){
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
function tipoUnidadTarget(){
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

function efectivoOperacion(){
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

function seDescargaOperacion(){
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

function seCargaOperacion(){
    
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
    crearCodigo();
    limpiaTarifasTarget();
    limpiaServicioTarget();
    $("#listadoEvaluacionesProyecto").hide();
    $("#nuevaEvaluacion").show();
    $("#btnGrabarProyecto").prop("disabled",false);
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
}

function grabarProyecto(){

    var codigoProyecto=  $('#codigoProyecto').val();
    var idproyecto = $("#idproyecto").val();
    var idcliente = $('#clienteEva').prop("selectedIndex");
    var fechainicio =   $('#finicioPro').val();
    var fechafinal = $('#fFinalPro').val();
    var tipocargaProyecto =  $('#tipocargaProyecto').prop("selectedIndex");
    var pesopromedio =   $('#pesoPromedioPro').val();
    var fianzaProyecto = $('#fianzaPro').val();
    var unidadMedida =  $('#unidadPesoPro').prop("selectedIndex");
    var piesCubico= $('#piesCubicosPro').val(); 
    var mercaderia =  $('#mercaderiaPro').val();
    var permisos =  $('#permisosEspecialesPro').val();
    var  entregasPromedio = $('#entregasPromedioPro').val();
    var kilometrosPromedio=$('#kilometrosPromedioPro').val();
    var frecuenciaViajes=$('#frecuenciaViajes').val();
    var seCargaPro = $('#seCargaPro').val();
    var seDescargaPro=$('#seDescargaPro').val();
    var manejoEfectivoPro=$('#manejoEfectivoPro').val();


    if (idcliente == 0 || idcliente == -1){
        alertify.alert("Campo Vacio","Debe de indicar el Cliente");
        return false;
    }else if(fechainicio.trim() == ""){
        alertify.alert("Campo Vacio","Debe de indicar Fecha Inicio");
        return false;
    }else if (fechafinal.trim()==""){
        alertify.alert("Campo Vacio","Debe de indicar Fecha Final");
    }else if (tipocargaProyecto == 0 || tipocargaProyecto ==-1){
        alertify.alert("Campo Vacio","Debe de indicar Tipo de Carga");
        return false;
    }else if (pesopromedio == 0 || pesopromedio.trim() ==""){
        alertify.alert("Campo Vacio","Debe de indicar el Peso Promedio");
        return false;
    }else if(unidadMedida ==0 | unidadMedida ==-1){
        alertify.alert("Campo Vacio","Debe indicar Unidad de medida");
        return false;
    }else if (mercaderia.trim() ==""){
        alertify.alert("Campo Vacio","Debe indicar Descripción de la Mercaderia");
        return false;
    }

    tipocargaProyecto = $('#tipocargaProyecto').val();
    idcliente = $('#clienteEva').val();
    unidadMedida =  $('#unidadPesoPro').val();

    $.ajax({
        url: "../ajax/evaluacionProyecto.php?op=guardaryeditarProyecto",
        type: "POST",
        data: {
                "codigoProyecto":codigoProyecto,
                "idproyecto":idproyecto,
                "idcliente":idcliente,
                "fechainicio":fechainicio,
                "fechafinal":fechafinal,
                "tipocargaProyecto":tipocargaProyecto,
                "fianzaProyecto":fianzaProyecto,
                "pesopromedio":pesopromedio,
                "unidadMedida":unidadMedida,
                "piesCubico":piesCubico,
                "mercaderia":mercaderia,
                "permisos":permisos,
                "entregasPromedio":entregasPromedio,
                "kilometrosPromedio":kilometrosPromedio,
                "frecuenciaViajes":frecuenciaViajes,
                "seCargaPro":seCargaPro,
                "seDescargaPro":seDescargaPro,
                "manejoEfectivoPro":manejoEfectivoPro
        },
        success: function (datos) {
            datos = JSON.parse(datos);
            if (datos.id_evaluacion_proyecto > 0) {
                $("#btnGrabarProyecto").prop("disabled",true);
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

function cancelarProyecto(){
    $("#listadoEvaluacionesProyecto").show();
    $("#nuevaEvaluacion").hide(); 
    $('#tProyectos').DataTable().ajax.reload();
}
function listarProyectos(){
    tablaProyectos = $('#tProyectos').dataTable({
        "aProcessing": true, //Activamos el procesamiento del datatables
        "aServerSide": true, //Paginacion y fltrado realizado por el servidor
        dom: 'Bfrtip', //Definimos los elementos de control de tabla
        buttons: ['copyHtml5', 'excelHtml5', 'pdfHtml5'],
        "ajax": {
            url: '../ajax/evaluacionProyecto.php?op=listarProyectos',
            type: "post",
            data: { },
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
function listarProyecto(idproyecto){
    $.post(
        "../ajax/evaluacionProyecto.php?op=listarProyecto", {
            idproyecto: idproyecto
        },
        function (data,status) {
            data = JSON.parse(data);
            if (data.idproyecto >= 1) {
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
                listarUnidadesTransporte(data.idproyecto);
                listarTarifasTarget(data.idproyecto);
                listarServiciosTArget(data.idproyecto);
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
    
    tipoUnidaPro = $("#tipoUnidaPro").val();
    tipoEquipoPro = $("#tipoEquipoPro").val();
    canalDistribucionPro = $("#canalDistribucionPro").val();

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
}

function listarUnidadesTransporte(idproyecto) {
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
        function (data,status) {
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

    $("#lugarCargaTarget").val("");
    $("#lugarDescargaTarget").val("");

    $("#tipounidadTarget").val(0);
    $("#tipounidadTarget").selectpicker("refresh");

}

function registraTarifasTarget() {
    var idproyecto = $("#idproyecto").val();
    var idtarifatarget = $("#idtarifatarget").val();   
    var tipounidadTarget = $("#tipounidadTarget").prop("selectedIndex");
    var lugarCargaTarget= $("#lugarCargaTarget").val();
    var lugardescargaTarget = $("#lugarDescargaTarget").val();
    var fianzaTarget = $("#FianzaTarget").val();

    if (tipounidadTarget== -1 || tipounidadTarget == 0) {
        alertify.alert("Campo Vacio", "Debe de indicar el Tipo de Unidad");
        return false;
    }  
    tipounidadTarget = $("#tipounidadTarget").val();

    $.ajax({
        url: "../ajax/evaluacionProyecto.php?op=guardaTarifasT",
        type: "POST",
        data: {
            "idproyecto":idproyecto,
            "idtarifatarget": idtarifatarget,  
            "tipounidadTarget": tipounidadTarget,
            "lugarCargaTarget": lugarCargaTarget,
            "lugardescargaTarget": lugardescargaTarget,
            "fianzaTarget": fianzaTarget
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
}

function listarTarifasTarget(idproyecto) {
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

function listaTarifa(idtarifatarget) {
    
    $.post(
        "../ajax/evaluacionProyecto.php?op=listarTarifa", {
            idtarifatarget: idtarifatarget
        },
        function (data,status) {
            data = JSON.parse(data);
            if (data.idtarifa_target >= 1) {
                $("#idtarifatarget").val(data.idtarifa_target);   
                $("#tipounidadTarget").val(data.id_tipo_unidad);
                $("#tipounidadTarget").selectpicker("refresh");
                $("#lugarCargaTarget").val(data.lugar_carga);
                $("#lugarDescargaTarget").val(data.lugar_descarga);
                $("#FianzaTarget").val(data.id_fianza);
                $("#FianzaTarget").selectpicker("refresh");
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

function listarTarifasTarget(idproyecto){
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
}
function limpiaServicioTarget(){
    $("#idserviciotarget").val(0);
    $("#servicioTarget").val(0);
    $("#servicioTarget").selectpicker("refresh");
    $("#lugarCargaTargetServicios").val("");
    $("#lugarDescargaTargetServicios").val("");
}
function  grabaServicioTarget(){
    var idproyecto = $("#idproyecto").val();
    var idserviciotarget = $("#idserviciotarget").val();   
    var servicioTarget = $("#servicioTarget").prop("selectedIndex");
    var lugarCargaTargetServicios= $("#lugarCargaTargetServicios").val();
    var lugarDescargaTargetServicios = $("#lugarDescargaTargetServicios").val();

    if (servicioTarget== -1 || servicioTarget == 0) {
        alertify.alert("Campo Vacio", "Debe de indicar el Tipo de Servicio");
        return false;
    }  
    servicioTarget = $("#servicioTarget").val();

    $.ajax({
        url: "../ajax/evaluacionProyecto.php?op=grabaServicioTarget",
        type: "POST",
        data: {
            "idproyecto":idproyecto,
            "idserviciotarget": idserviciotarget,
            "servicioTarget":servicioTarget,  
            "lugarCargaTargetServicios": lugarCargaTargetServicios,
            "lugarDescargaTargetServicios": lugarDescargaTargetServicios,
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
}
function listarServicio(idserviciotarget){
    $.post(
        "../ajax/evaluacionProyecto.php?op=listarServicoTarget", {
            idserviciotarget: idserviciotarget
        },
        function (data,status) {
            data = JSON.parse(data);
            if (data.idtarifa_target >= 1) {
                $("#idserviciotarget").val(data.id_servicio_target);
                $("#servicioTarget").val(data.id_servicio);
                $("#servicioTarget").selectpicker("refresh");
                $("#lugarCargaTargetServicios").val(data.lugar_carga);
                $("#lugarDescargaTargetServicios").val(data.lugar_descarga);
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
function listarServiciosTArget(idproyecto){
    tablaserviciost = $('#tServcioTarget').dataTable({
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
init();

