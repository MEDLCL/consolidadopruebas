function validaCorreo(email) {
    var regex = (/^([a-zA-Z0-9_+-])+\@(([a-zZ-a0-9])+\.)+([a-zA-Z0-9]{2,4})+/);
    return regex.test(email);

}

function validaCheck(check) {
    var cont;
    cont = 0;
    check.each(function () {
        if (this.checked) {
            cont = cont + 1;
        }
    });
    return cont;
}

function mayusculas(e) {
    return e.value = e.value.toUpperCase();
}

function salir() {
    $.ajax({
        type: "POST",
        url: "../ajax/login.php?op=salir",
        data: '',
        contentType: false,
        processData: false,
        success: function (data) {
            if (data == 1) {
                $(location).attr("href", "../../index.php");
            } else {
                $(location).attr("href", "../../index.php");
            }
        },
        error: function () {

        }
    });
}

function numeroTelefono(string) {
    var out = '';
    var filtro = '1234567890()-'; //Caracteres validos

    //Recorrer el texto y verificar si el caracter se encuentra en la lista de validos 
    for (var i = 0; i < string.length; i++)
        if (filtro.indexOf(string.charAt(i)) != -1)
            //Se añaden a la salida los caracteres validos
            out += string.charAt(i);
    //Retornar valor filtrado
    return out;
}

function numerosDecimal(numero) {
    if (numero.indexOf('.') != -1) {
        if (numero.split(".")[1].length > 2) {
            if (isNaN(parseFloat(numero))) return;
            numero = parseFloat(numero).toFixed(2);
        }
    }
    return numero; //for chaining
}