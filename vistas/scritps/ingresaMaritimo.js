var tablaEmbarqueOP = '';

function init() {
    $("#tabIngresoMaritimo a:first").tab("show");
    listaEmbarqueOP();
    $("#btnActualizarOPEmbarque").show();
}

function listaEmbarqueOP() {
    tablaEmbarqueOP = $("#tblDetalleEmbarquesOP").dataTable({
        "aProcessing": true, //Activamos el procesamiento del datatables
        "aServerSide": true, //Paginacion y fltrado realizado por el servidor
        dom: "Bfrtip", //Definimos los elementos de control de tabla
        buttons: ["copyHtml5", "excelHtml5", "pdfHtml5"],
        "ajax": {
            url: "../ajax/ingresoMaritimo.php?op=listarEmbarqueOP",
            type: "get",
            dataType: "json",
            error: function (e) {
                console.log(e.responseText);
            },
        },
        "bDestroy": true,
        "pageLength": 15,
        "lengthMenu": [
            [10, 25, 50, -1],
            [10, 25, 50, "All"]
        ],
        //"iDisplayLenth": 25, //paginacion
        "order": [
            [1, "desc"]
        ], //order los datos
    });
}

function EditarMaritimo() {
    var tipocarga = $("#tipocarga").prop("selectedIndex");
    var tiposervicio = $("#tipoServicio").prop("selectedIndex");
    var barco = $("#barco").prop("selectedIndex");
    var Viaje = $("#Viaje").val();
    var cantClientes = $("#cntClientes").val();
    var agente = $("#agente").prop("selectedIndex");
    var naviera = $("#naviera").prop("selectedIndex");
    var paisorigen = $("#PaisOrigen").prop("selectedIndex");
    var origen = $("#Origen").prop("selectedIndex");
    var paisdestino = $("#PaisDestino").prop("selectedIndex");
    var destino = $("#Destino").prop("selectedIndex");
    var usuarioAsignado = $("#usuarioAsignado").prop("selectedIndex");
    var idembarquemaritimo = $("#idembarquemaritimo").val();

    if (tipocarga == -1 || tipocarga == 0) {
        alertify.alert("Campo Vacio", "Debe de seleccionar el Tipo de Carga");
        return false;
    } else if (tiposervicio == -1 || tiposervicio == 0) {
        alertify.alert("Campo Vacio", "Debe de seleccionar el Tipo de Servicio");
        return false;
    } else if (barco == -1 || barco == 0) {
        alertify.alert("Campo Vacio", "Debe de seleccionar el Barco");
        return false;
    } else if (Viaje.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de ingresar Viaje");
        return false;
    } else if (cantClientes.trim() == "" || cantClientes == 0) {
        alertify.alert("Campo Vacio", "Debe de ingresar Cantidad de Clientes");
        return false;
    } else if (agente == -1 || agente == 0) {
        alertify.alert("Campo Vacio", "Debe de seleccionar Agente");
        return false;
    } else if (naviera == -1 || naviera == 0) {
        if (tipocarga == 1) {
            alertify.alert("Campo Vacio", "Debe de seleccionar Agencia de Carga");
            return false;
        } else {
            alertify.alert("Campo Vacio", "Debe de seleccionar Naviera");
            return false;
        }
    } else if (paisorigen == -1 || paisorigen == 0) {
        alertify.alert("Campo Vacio", "Debe de seleccionar Pais Origen");
        return false;
    } else if (origen == -1 || origen == 0) {
        alertify.alert("Campo Vacio", "Debe de seleccionar Origen");
        return false;
    } else if (paisdestino == -1 || paisdestino == 0) {
        alertify.alert("Campo Vacio", "Debe de seleccionar Pais Destino");
        return false;
    } else if (destino == -1 || destino == 0) {
        alertify.alert("Campo Vacio", "Debe de seleccionar Destino");
        return false;
    } else if (usuarioAsignado == -1 || usuarioAsignado == 0) {
        alertify.alert("Campo Vacio", "Debe de seleccionar Usuario Asignado");
        return false;
    }

    tipocarga = $("tipocarga").val();
    barco = $("#barco").val();
    naviera = $("#naviera").val();
    usuarioAsignado = $("#usuarioAsignado").val();
    tiposervicio = $("#tipoServicio").val();
    fechaingreso = $("#fechaingreso").val();
    codigoMaritimo = $("#codigoMaritimo").val();

    $.ajax({
        url: "../ajax/creaMaritimo.php?op=guardaryeditar",
        type: "POST",
        data: {
            "idembarquemaritimo" : idembarquemaritimo,
            "tipocarga" : tipocarga,
            "barco" : barco,
            "Viaje" : Viaje,
            "naviera" : naviera,
            "usuarioAsignado" : usuarioAsignado,
            "tiposervicio" : tiposervicio,
            "fechaingreso" : fechaingreso,
            "codigoMaritimo" : codigoMaritimo
        },
        success: function (datos) {
            datos = JSON.parse(datos);
            if (datos.idembarque > 0) {
                //habilitar boton para imprimir caratula
                $("#codigoMaritimo").val(datos.codigo);
                $("#consecutivo").val(datos.consecutivo);
                $("#btnGrabarCreaM").prop("disabled", true);
                //alertify.success("Proceso Realizado con exito");
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
init();