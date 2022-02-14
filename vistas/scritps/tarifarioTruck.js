var tablaTarifaFlete;
var tablaServicios;
function init(){
    llenaSelect("tipoUnidadTarifa","tipo_unidades_truc","idtipo_unidades");
    llenaSelect("tipoCargaTarifa","tipo_carga_empresa","id_tipo_carga_empresa");
    pilotoSelect();
    fechaValidez();
    limpiaTarifaFlete();
    llenaProyecto();
    llenaMoneda("monedaTarifaFlete");
    llenaMoneda("monedaServicioTarifa");
    limpiaTarifaFlete();
    servicios();
    limpiarServiciosTarifa();
    validezServiofecha();
}

function validezServiofecha() {
    $("#validezServicio").datepicker({
        autoclose: true,
    });
    // $("#finicioPro").datepicker("setDate", "0");
}
function servicios(){
    $("#servicioTarifa").empty();
    $.post(
        "../modelos/pais.php?op=selectN&tabla=catalogo&campo=nombre", {
            id: "id_catalogo",
            tipoe: "",
        },
        function (data, status) {
            $("#servicioTarifa").html(data);
            $("#servicioTarifa").selectpicker("refresh");
            $("#servicioTarifa").val(0);
            $("#servicioTarifa").selectpicker("refresh");
        }
    );
}
function llenaProyecto(){
    $("#codigoProyecto").empty();
    $.post(
        "../modelos/pais.php?op=selPro&tabla=evaluacion_proyecto&campo=codigo", {
            id: "id_evaluacion_proyecto",
            tipoe: "",
        },
        function (data, status) {
            $("#codigoProyecto").html(data);
            $("#codigoProyecto").selectpicker("refresh");
            $("#codigoProyecto").val(0);
            $("#codigoProyecto").selectpicker("refresh");
        }
    );
}
function llenaMoneda(selecMoneda){
    $("#"+selecMoneda).empty();
    $.post("../modelos/pais.php?op=llenaMoneda", {}, function (data, status) {
        $("#"+selecMoneda).html(data);
        $("#"+selecMoneda).selectpicker("refresh");
        $("#"+selecMoneda).val(0);
        $("#"+selecMoneda).selectpicker("refresh");
    });
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

function pilotoSelect(){
    $("#pilotoTarifa").empty();
    $.post(
        "../modelos/pais.php?op=General&tabla=sino&campo=nombre", {
            id: "id_sino",
            tipoe: "",
        },
        function (data, status) {
            $("#pilotoTarifa").html(data);
            $("#pilotoTarifa").selectpicker("refresh");
            $("#pilotoTarifa").val(0);
            $("#pilotoTarifa").selectpicker("refresh");
        }
    );
}
function fechaValidez() {
    $("#validezTarifaFlete").datepicker({
        autoclose: true,
    });
   // $("#validezTarifaFlete").datepicker("setDate", "0");
}

function limpiaTarifaFlete(){
    $('#origenTarifa').val("");
    $('#destinoTarifa').val("");
    $('#tipoUnidadTarifa').val(0);
    $('#tipoUnidadTarifa').selectpicker("refresh");
    $('#pilotoTarifa').val(2);
    $('#pilotoTarifa').selectpicker("refresh");
    $('#numeroPilotos').val(0);
    $('#idtarifaflete').val(0);
    $('#validezTarifaFlete').datepicker("setDate","0");
    $('#tipoCargaTarifa').val(0);
    $('#tipoCargaTarifa').selectpicker("refresh");
    $('#tarifaVentaFlete').val(0);
    $('#tarifaCostoFlete').val(0);
    $('#monedaTarifaFlete').val(0);
    $('#monedaTarifaFlete').selectpicker("refresh");
}
function grabarEditarTarifaFlete(){
    var origenTarifa = $('#origenTarifa').val();
    var destinoTarifa = $('#destinoTarifa').val();
    var tipoUnidadTarifa = $('#tipoUnidadTarifa').prop("selectedIndex");
    var tipoCargaTarifa =  $('#tipoCargaTarifa').prop("seletedIndex");
    var tarifaVentaFlete =  $('#tarifaVentaFlete').val();
    var tarifaCostoFlete = $('#tarifaCostoFlete').val();
    var monedaTarifaFlete = $('#monedaTarifaFlete').prop("selectedIndex");
    var idproyecto = $("#codigoProyecto").prop("selectedIndex");

    if (idproyecto == 0 || idproyecto ==-1){
        alertify.alert("Campo vacio","Debe de seleccionar un Proyecto");
        return false;
    } else if (origenTarifa.trim()==""){
        alertify.alert("Campo Vacio","Debe de colocar el Origen");
        return false;
    }else if(destinoTarifa.trim()==""){
        alertify.alert("Campo Vacio","Debe de colocar el Destino");
        return false;
    }else if (tipoUnidadTarifa==-1 || tipoUnidadTarifa ==0){
        alertify.alert("Campo Vacio","Debe de seleccionar la Unidad");
        return false;
    }else if (tipoCargaTarifa ==0 || tipoCargaTarifa ==-1){
        alertify.alert("Campo Vacio","Debe de indicar tipo de Carga");
        return false;
    }else if (tarifaVentaFlete ==0 || tarifaVentaFlete.trim() ==""){
        alertify.alert("Campo Vacio","Debe de indicar el valor Venta");
        return false;
    }else if (tarifaCostoFlete ==0 || tarifaCostoFlete.trim()==""){
        alertify.alert("Campo Vacio","Debe de indicar el valor Costo");
        return false;
    }else if (monedaTarifaFlete ==0 || monedaTarifaFlete ==-1){
        aler.alert("Campo Vacio","Debe de indicar la moneda");
        return false;
    }
    idproyecto = $("#codigoProyecto").val();
    tipoUnidadTarifa = $('#tipoUnidadTarifa').val();
    var pilotoTarifa = $('#pilotoTarifa').val();
    var numeroPilotos=$('#numeroPilotos').val();
    var idtarifaflete=$('#idtarifaflete').val();
    var validezTarifaFlete = $('#validezTarifaFlete').val();
    tipoCargaTarifa=$('#tipoCargaTarifa').val();
    tarifaVentaFlete=$('#tarifaVentaFlete').val();
    tarifaCostoFlete =$('#tarifaCostoFlete').val();
    monedaTarifaFlete =$('#monedaTarifaFlete').val();

    $.ajax({
        url: "../ajax/tarifaTruck.php?op=grabarEditarTarifaF",
        type: "POST",
        data: { "origenTarifa":origenTarifa,
                "destinoTarifa":destinoTarifa,
                "tipoUnidadTarifa":tipoUnidadTarifa,
                "pilotoTarifa":pilotoTarifa,
                "numeroPilotos":numeroPilotos,
                "idtarifaflete":idtarifaflete,
                "validezTarifaFlete":validezTarifaFlete,
                "tipoCargaTarifa":tipoCargaTarifa,
                "tarifaVentaFlete":tarifaVentaFlete,
                "tarifaCostoFlete":tarifaCostoFlete,
                "monedaTarifaFlete":monedaTarifaFlete,
                "idproyecto":idproyecto
        },
        success: function (datos) {
            datos = JSON.parse(datos);
            if (datos.id_tarifario_truck > 0) {
                listarTarifasFlete(idproyecto);
                limpiaTarifaFlete();
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
function listarTarifaflete(idtarifaflete){
    $.post(
        "../ajax/tarifaTruck.php?op=listarTarifaFlete", {
            idtarifaflete: idtarifaflete
        },
        function (data,status) {
            data = JSON.parse(data);
            if (data.id_tarifario_truck >= 1) {
                $('#origenTarifa').val(data.origen);
                $('#destinoTarifa').val(data.destino);
                $('#tipoUnidadTarifa').val(data.id_tipo_unidad);
                $('#tipoUnidadTarifa').selectpicker("refresh");
                $('#pilotoTarifa').val(data.id_piloto);
                $('#pilotoTarifa').selectpicker("refresh");
                $('#numeroPilotos').val(data.ayudantes);
                $('#idtarifaflete').val(data.id_tarifario_truck);
                $('#validezTarifaFlete').val(data.validez);
                $('#tipoCargaTarifa').val(data.id_tipo_carga);
                $('#tipoCargaTarifa').selectpicker("refresh");
                $('#tarifaVentaFlete').val(data.tarifa_venta);
                $('#tarifaCostoFlete').val(data.tarifa_costo);
                $('#monedaTarifaFlete').val(data.id_moneda);
                $('#monedaTarifaFlete').selectpicker("refresh");
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
function listarTarifasFlete(idproyecto){
    tablaTarifaFlete = $('#TuniadesAsignadas').dataTable({
        "aProcessing": true, //Activamos el procesamiento del datatables
        "aServerSide": true, //Paginacion y fltrado realizado por el servidor
        dom: 'Bfrtip', //Definimos los elementos de control de tabla
        buttons: ['copyHtml5', 'excelHtml5', 'pdfHtml5'],
        "ajax": {
            url: '../ajax/tarifaTruck.php?op=listarTarifasFlete',
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

function limpiarServiciosTarifa(){
    $('#servicioTarifa').val(0);
    $('#servicioTarifa').selectpicker("refresh");
    $('#origenServicioTarifa').val("");
    $('#destinoServicioTarifa').val("");
    $('#tarifaVentaServicio').val(0);
    $('#idtarifaservicio').val(0);
    $('#tarifaCostoServicio').val(0);
    $('#monedaServicioTarifa').val(0);
    $('#monedaServicioTarifa').selectpicker("refresh");
    $("#validezServicio").datepicker("setDate", "0");
}
function registrarServiciosTarifa(){
    var  servicioTarifa=   $('#servicioTarifa').prop("selectedIndex");
    var idproyecto = $("#codigoProyecto").prop("selectedIndex");
    var origenServicioTarifa=  $('#origenServicioTarifa').val();
    var destinoServicioTarifa = $('#destinoServicioTarifa').val();
    var tarifaVentaServicio = $('#tarifaVentaServicio').val();
    var idtarifaservicio = $('#idtarifaservicio').val();
    var tarifaCostoServicio=$('#tarifaCostoServicio').val();
    var monedaServicioTarifa =$('#monedaServicioTarifa').prop("selectedIndex");
    var validezServicio = $("#validezServicio").val();
    
    if(idproyecto ==0 || idproyecto ==-1){
        alertify.alert("Campo Vacio","Debe de seleccionar un Proyecto");
        return false;
    }else if (servicioTarifa == 0 || servicioTarifa ==-1){
        alertify.alert("Campo Vacio","Debe de seleccionar un Servicio");
        return false;
    }else if(origenServicioTarifa.trim() ==""){
        alertify.alert ("Campo Vacio","Debe de indicar el Origen");
        return false;
    }else if (destinoServicioTarifa.trim()==""){
        alertify.alert("Campo Vacio","Debe de indicar el Destino");
        return false;
    }else if (tarifaVentaServicio == 0 || tarifaVentaServicio.trim() ==""){
        alertify.alert("Campo Vacio","Debe de indicar Valor Venta");
        return false;
    }else if (tarifaCostoServicio ==0 || tarifaCostoServicio.trim()==""){
        alertify.alert("Campo Vacio","Debe de indicar Valor Costo");
        return false;
    }else if (monedaServicioTarifa ==0 || monedaServicioTarifa ==-1){
        alertify.alert("Campo Vacio","Debe de seleccionar la moneda");
        return false;
    }
    
    idproyecto = $("#codigoProyecto").val();
    servicioTarifa=   $('#servicioTarifa').val();
    monedaServicioTarifa =$('#monedaServicioTarifa').val();

    $.ajax({
        url: "../ajax/tarifaTruck.php?op=grabarServcioTarifa",
        type: "POST",
        data: {
            "servicioTarifa":servicioTarifa,
            "idproyecto":idproyecto, 
            "origenServicioTarifa":origenServicioTarifa,
            "destinoServicioTarifa":destinoServicioTarifa,
            "tarifaVentaServicio":tarifaVentaServicio,
            "idtarifaservicio":idtarifaservicio,
            "tarifaCostoServicio":tarifaCostoServicio,
            "monedaServicioTarifa":monedaServicioTarifa,
            "validezServicio":validezServicio
        },
        success: function (datos) {
            datos = JSON.parse(datos);
            if (datos.idtarifaservicio > 0) {
                listarServiciosTarifa(idproyecto);
                limpiarServiciosTarifa();
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

function listarServiciosTarifa(idproyecto){
    tablaServicios = $('#tServiciosTarifas').dataTable({
        "aProcessing": true, //Activamos el procesamiento del datatables
        "aServerSide": true, //Paginacion y fltrado realizado por el servidor
        dom: 'Bfrtip', //Definimos los elementos de control de tabla
        buttons: ['copyHtml5', 'excelHtml5', 'pdfHtml5'],
        "ajax": {
            url: '../ajax/tarifaTruck.php?op=listarServiciosTarifa',
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
function listarServicioTarifa(idtarifaservicio){
    $.post(
        "../ajax/tarifaTruck.php?op=listarServicioTarifa", {
            idtarifaservicio: idtarifaservicio
        },
        function (data,status) {
            data = JSON.parse(data);
            if (data.id_tarifa_servicio >= 1) {
                $('#servicioTarifa').val(data.id_servicio);
                $('#servicioTarifa').selectpicker("refresh");
                $('#origenServicioTarifa').val(data.origen);
                $('#destinoServicioTarifa').val(data.destino);
                $('#tarifaVentaServicio').val(data.tarifa_venta);
                $('#idtarifaservicio').val(data.id_tarifa_servicio);
                $('#tarifaCostoServicio').val(data.tarifa_costo);
                $('#monedaServicioTarifa').val(data.id_moneda);
                $('#monedaServicioTarifa').selectpicker("refresh");
                $("#validezServicio").val(data.validez);
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

function llenaTarifasFleteServicio(){
    var idproyecto = $("#codigoProyecto").prop("selectedIndex");
    if (idproyecto == 0 || idproyecto == -1){
        alertify.alert("Campo Vacio","Debe de seleccionar un Codigo de proyecto");
        return false;
    }
    var idproyecto = $("#codigoProyecto").val();

    listarTarifasFlete(idproyecto);
    listarServiciosTarifa(idproyecto);

}
init();