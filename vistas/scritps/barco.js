function init() {

}

function llenaBarcoModal() {
    $("#bBarco").empty();
    $.post(
        "../modelos/pais.php?op=selectN&tabla=barco&campo=nombre", {
            id: "id_barco",
            tipoe: "",
        },
        function (data, status) {
            $("#bBarco").html(data);
            $("#bBarco").selectpicker("refresh");
            $("#bBarco").val(0);
            $("#bBarco").selectpicker("refresh");
        }
    );
}

function nuevoBarco() {
    limpiaBarco();
    $("#btnGrabaBarco").removeAttr("disabled");
}

function grabarBarco() {
    var nombrebarco = $("#nombreBarco").val();

    if (nombrebarco.trim() == "") {
        alertify.alert("Campo vacio", "Debe de colocar nombre del Barco");
        return false;
    }

    var formBarco = new FormData($("#frmBarco")[0]);

    $.ajax({
        url: "../ajax/barco.php?op=guardaryeditar",
        type: "POST",
        data: formBarco,
        contentType: false,
        processData: false,
        success: function (datos) {
            if (datos > 0) {
                alertify.success("Proceso Realizado con exito");
                $("#btnGrabaBarco").prop("disabled", true);
                quienLLamaBarco();
                $("#modalBarco").modal("hide");
            } else {
                alertify.error("Proceso no se pudo realizar") + " " + datos;
            }
        },
    });
}

function limpiaBarco() {
    $("#nombreBarco").val("");
    $("#bandera").val("");
    $("#idbarco").val(0);
}

function quienLLamaBarco() {
var quienLLama = $("#quienllamaBarco").val();
    if (quienLLama =='CreaMar'){
        llenaBarcoM();
    }else if (quienLLama== "asignaBOP") {
        llenaBarcoAsignOP();
    }
}

function buscarBarco() {
    limpiaBarco();
    var idbarco = $("#bBarco").val();
    $.post(
        "../ajax/barco.php?op=mostrarB", {
            idbarco: idbarco,
        },
        function (data, status) {
            data = JSON.parse(data);
            if (data.id_barco >= 1) {
                $("#idbarco").val(data.id_barco);
                $("#nombreBarco").val(data.nombre);
                $("#bandera").val(data.bandera);
                $("#btnGrabaBarco").removeAttr("disabled");
            }
        }
    );
}
init();