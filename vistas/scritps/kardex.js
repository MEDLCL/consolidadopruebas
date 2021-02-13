function init() {
    llenaconsignado();
}


function llenaconsignado() {
    $.post(
        '../modelos/pais.php?op=selecEmpresa&tabla=empresas&campo=Razons', {
            id: "id_empresa",
            tipoe: "CO"
        },
        function(data, status) {
            $('#consiganado').html(data);
            $("#consiganado").selectpicker('refresh');
        }
    );
}



init();