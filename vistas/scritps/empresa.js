function init() {

}
var cont = 0;

function registrarc() {
    var nombre = $("#Nombre").val();
    var apellido = $("#Apellido").val();
    var correo = $("#Correo").val();
    var telefono = $("#telefonoc").val();
    var puesto = $("#puesto").val();

    <<
    <<
    << < HEAD
    var fila = '<tr class="filas" id ="fila' + cont + '">' +
        '<td><button type="button" class="btn btn-danger" onclick="eliminarfila(' + cont + ')"><span class="fa fa-trash-o"></span></button></td>' +
        '<td >' + nombre + '</td>' +
        '<td >' + apellido + '</td>' +
        '<td >' + correo + '</td>' +
        '<td >' + telefono + '</td>' +
        '<td >' + puesto + '</td>' +
        '</tr>'; ===
    ===
    =
    var fila = '<tr class="filas" id ="fila' + cont + '">' +
        <<
        <<
        << < HEAD '<td><button type="button" class="btn btn-danger" onclick="eliminarfila(' + cont + ')"><span class="fa fa-trash-o"></span></button></td>' +
        ===
        ===
        =
        '<td><button type="button" class="btn btn-danger" onclick="eliminarDetalle(' + cont + ')">X</button></td>' +
        >>>
        >>>
        > develop '<td >' + nombre + '</td>' +
        '<td >' + apellido + '</td>' +
        '<td >' + correo + '</td>' +
        '<td >' + telefono + '</td>' +
        '<td >' + puesto + '</td>' +
        '</tr>'; <<
    <<
    << < HEAD
        >>>
        >>>
        > dceaf5fde70a5b4fbcf70228946d260ffc9d663f

    cont++;
    $('#Tcontactos').append(fila);
}
//funcion para eliminar fila de la tabla contactos
function eliminarfila(cont) {
    $("#fila" + cont).remove();
}

function limpiar() {
    $("#codigo").val("");
    $("#idempresa").val("0");
    $("#Razons").val("");
    $("#Nombrec").val("");
    $("#identificacion").val("");
    $("#telefono").val("");
    $("#direccion").val("");
    $("#Nombre").val("");
    $("#Apellido").val("");
    $("#Correo").val("");
    $("#telefonoc").val("");
    $("#puesto").val("");
    $("tbody").children().remove()
}

function nuevo() {
    limpiar();
} ===
===
=
$('#Tcontactos').append(fila);
}

>>>
>>>
> develop
init();