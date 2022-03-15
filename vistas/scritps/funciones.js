function validaCorreo(email) {
    var regex = /^([a-zA-Z0-9_+-])+\@(([a-zZ-a0-9])+\.)+([a-zA-Z0-9]{2,4})+/;
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
    return (e.value = e.value.toUpperCase());
}

function salir() {
    $.ajax({
        type: "POST",
        url: "../ajax/login.php?op=salir",
        data: "",
        contentType: false,
        processData: false,
        success: function (data) {
            if (data == 1) {
                $(location).attr("href", "../../index.php");
            } else {
                $(location).attr("href", "../../index.php");
            }
        },
        error: function () {},
    });
}

function numeroTelefono(string) {
    var out = "";
    var filtro = "1234567890()-"; //Caracteres validos

    //Recorrer el texto y verificar si el caracter se encuentra en la lista de validos
    for (var i = 0; i < string.length; i++)
        if (filtro.indexOf(string.charAt(i)) != -1)
            //Se añaden a la salida los caracteres validos
            out += string.charAt(i);
    //Retornar valor filtrado
    return out;
}

function numerosDecimal(numero) {
    if (numero.indexOf(".") != -1) {
        if (numero.split(".")[1].length > 2) {
            if (isNaN(parseFloat(numero))) return;
            numero = parseFloat(numero).toFixed(2);
        }
    }
    return numero; //for chaining
}

function htmlEntities(str) {
    return String(str)
        .replace("&ntilde;", "ñ")
        .replace("&Ntilde;", "Ñ")
        .replace("&amp;", "&")
        .replace("&Ntilde;", "Ñ")
        .replace("&ntilde;", "ñ")
        .replace("&Ntilde;", "Ñ")
        .replace("&Agrave;", "À")
        .replace("&Aacute;", "Á")
        .replace("&Acirc;", "Â")
        .replace("&Atilde;", "Ã")
        .replace("&Auml;", "Ä")
        .replace("&Aring;", "Å")
        .replace("&AElig;", "Æ")
        .replace("&Ccedil;", "Ç")
        .replace("&Egrave;", "È")
        .replace("&Eacute;", "É")
        .replace("&Ecirc;", "Ê")
        .replace("&Euml;", "Ë")
        .replace("&Igrave;", "Ì")
        .replace("&Iacute;", "Í")
        .replace("&Icirc;", "Î")
        .replace("&Iuml;", "Ï")
        .replace("&ETH;", "Ð")
        .replace("&Ntilde;", "Ñ")
        .replace("&Ograve;", "Ò")
        .replace("&Oacute;", "Ó")
        .replace("&Ocirc;", "Ô")
        .replace("&Otilde;", "Õ")
        .replace("&Ouml;", "Ö")
        .replace("&Oslash;", "Ø")
        .replace("&Ugrave;", "Ù")
        .replace("&Uacute;", "Ú")
        .replace("&Ucirc;", "Û")
        .replace("&Uuml;", "Ü")
        .replace("&Yacute;", "Ý")
        .replace("&THORN;", "Þ")
        .replace("&szlig;", "ß")
        .replace("&agrave;", "à")
        .replace("&aacute;", "á")
        .replace("&acirc;", "â")
        .replace("&atilde;", "ã")
        .replace("&auml;", "ä")
        .replace("&aring;", "å")
        .replace("&aelig;", "æ")
        .replace("&ccedil;", "ç")
        .replace("&egrave;", "è")
        .replace("&eacute;", "é")
        .replace("&ecirc;", "ê")
        .replace("&euml;", "ë")
        .replace("&igrave;", "ì")
        .replace("&iacute;", "í")
        .replace("&icirc;", "î")
        .replace("&iuml;", "ï")
        .replace("&eth;", "ð")
        .replace("&ntilde;", "ñ")
        .replace("&ograve;", "ò")
        .replace("&oacute;", "ó")
        .replace("&ocirc;", "ô")
        .replace("&otilde;", "õ")
        .replace("&ouml;", "ö")
        .replace("&oslash;", "ø")
        .replace("&ugrave;", "ù")
        .replace("&uacute;", "ú")
        .replace("&ucirc;", "û")
        .replace("&uuml;", "ü")
        .replace("&yacute;", "ý")
        .replace("&thorn;", "þ")
        .replace("&yuml;", "ÿ");
}