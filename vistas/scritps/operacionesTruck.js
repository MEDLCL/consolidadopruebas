
function init() {
    llenaSelect("ventaOperaciones");
}

function llenaSelect(selec){
    $("#" + selec).empty();
    $.post("../modelos/pais.php?op=venta", {}, function (data, status) {
        $("#" + selec).html(data);
        $("#" + selec).selectpicker("refresh");
        $("#" + selec).val(0);
        $("#" + selec).selectpicker("refresh");
    });
}

function llenarFletesOP(){
var  ventaOperaciones = $('#ventaOperaciones').val();

$('#tfleteoperaciones').dataTable({
        "aProcessing": true, //Activamos el procesamiento del datatables
        "aServerSide": true, //Paginacion y fltrado realizado por el servidor
        dom: 'rtip', //Definimos los elementos de control de tabla
        buttons: ['copyHtml5', 'excelHtml5', 'pdfHtml5'],
        "ajax": {
            url: '../ajax/operacionesTruck.php?op=listarFletes',
            type: "post",
            data: {
                ventaOperaciones: ventaOperaciones
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
        ], //order los datos
        /* "columnDefs": [{
            "targets": [0],
            "visible": false,
            "searchable": false
        }] */
    });
}

init();
