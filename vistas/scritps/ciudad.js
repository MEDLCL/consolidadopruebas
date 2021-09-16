function init() {

}

function llenaCiudadModal() {
    $("#bCiudad").empty();
    var idpadre = $("#bPaisCiudad").val();
    
    $.post(
        "../modelos/pais.php?op=Dependiente&tabla=ciudad&campo=nombre", {
            id: "id_ciudad",
            tipoe: "",
            idpadre:idpadre
        },
        function (data, status) {
            $("#bCiudad").html(data);
            $("#bCiudad").selectpicker("refresh");
            $("#bCiudad").val(0);
            $("#bCiudad").selectpicker("refresh");
        }
    );
}

function llenaPaisModalBusqueda(){
    $("#bPaisCiudad").empty();
    $.post(
        "../modelos/pais.php?op=pais", {
            id: "",
            tipoe: "",
        },
        function (data, status) {
            $("#bPaisCiudad").html(data);
            $("#bPaisCiudad").selectpicker("refresh");
            $("#bPaisCiudad").val(0);
            $("#bPaisCiudad").selectpicker("refresh");
        }
    );
}

function llenaPaisModal(idpais){
    $("#paisCiudad").empty();
    $.post(
        "../modelos/pais.php?op=pais", {
            id: "",
            tipoe: "",
        },
        function (data, status) {
            $("#paisCiudad").html(data);
            $("#paisCiudad").selectpicker("refresh");
            $("#paisCiudad").val(idpais);
            $("#paisCiudad").selectpicker("refresh");
        }
    );
}

function nuevaCiudad() {
    limpiaCiudad();
    $("#btnGrabaCiudad").removeAttr("disabled");
}

function limpiaCiudad() {
    $("#nombreCiudad").val("");
    $("#idciudad").val(0);
}

function grabarCiudad() {
    var nombreciudad = $("#nombreCiudad").val();
    var pais = $("#paisCiudad").prop("selectedIndex");
    
    if (pais == -1 || pais == 0){
        alertify.alert("Campo Vacio","Debe de Seleccionar un Pais");
        return false;
    }else  if (nombreciudad.trim() == "") {
        alertify.alert("Campo vacio", "Debe de colocar nombre del Lugar");
        return false;
    }

    var formCiudad = new FormData($("#frmCiudad")[0]);

    $.ajax({
        url: "../ajax/ciudad.php?op=guardaryeditar",
        type: "POST",
        data: formCiudad,
        contentType: false,
        processData: false,
        success: function (datos) {
            if (datos > 0) {
                alertify.success("Proceso Realizado con exito");
                $("#btnGrabaCiudad").prop("disabled", true);
                quienLLamaCiudad();
                $("#modalCiudad").modal("hide");
            } else {
                alertify.error("Proceso no se pudo realizar") + " " + datos;
            }
        },
    });
}

function quienLLamaCiudad() {
var quienLLama = $("#quienLLamaCiudad").val();
    if (quienLLama =='CreaMarOrigen'){
        llenaCiudadOrigenMar();
    }else if (quienLLama =='CreaMarDestino'){
        llenaciudadDestinoMar();
    }
}

function buscaCiudad() {
    limpiaCiudad();
    var idciudad = $("#bCiudad").val();
    $.post(
        "../ajax/ciudad.php?op=mostrarC", {
            idciudad: idciudad,
        },
        function (data, status) {
            data = JSON.parse(data);
            if (data.id_ciudad >= 1) {
                $("#idciudad").val(data.id_ciudad);
                $("#nombreCiudad").val(data.nombre);
                $("#btnGrabaCiudad").removeAttr("disabled");
            }
        }
    );
}

init();