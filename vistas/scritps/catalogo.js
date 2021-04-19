function init() {}

function llenaCatalogoModal() {
  $("#bCatalogo").empty();
  $.post(
    "../modelos/pais.php?op=selectN&tabla=catalogo&campo=nombre",
    {
      id: "id_catalogo",
      tipoe: "",
    },
    function (data, status) {
      $("#bCatalogo").html(data);
      $("#bCatalogo").selectpicker("refresh");
      $("#bCatalogo").val(0);
      $("#bCatalogo").selectpicker("refresh");
    }
  );
}

function grabarcatalogo() {
  var nombreDescripcion = $("#nombreDescripcion").val();

  if (nombreDescripcion.trim() == "") {
    alertify.alert("Campo Vacio", "Debe de colocar el nombre");
    return false;
  }
  var frmCatalogo = new FormData($("#frmCatalogo")[0]);
  $.ajax({
    url: "../ajax/catalogo.php?op=guardaryeditar",
    type: "POST",
    data: frmCatalogo,
    contentType: false,
    processData: false,
    success: function (datos) {
      if (datos > 0) {
        alertify.success("Proceso Realizado con exito");
        $("#btnGrabaCatalogo").prop("disabled", true);
        quienLLamaCatalogo($("#llamaCalculoA").val());
        llenaCatalogoModal();
      } else {
        alertify.error("Proceso no se pudo realizar") + " " + datos;
      }
    },
  });
}

function quienLLamaCatalogo(opcion) {
  if (opcion == "calculoA") {
    llenaCatalogoCalculoA();
  }
}

function mostrarCatalogo() {
  limpiarmodalCatalogo();
  var idcatalogo = $("#bCatalogo").val();
  $.post(
    "../ajax/catalogo.php?op=mostrarC",
    {
      idcatalogo: idcatalogo,
    },
    function (data, status) {
        data = JSON.parse(data);
        if (data.id_catalogo >= 1) {
        $("#codigoCatalogo").val(data.codigo);
        $("#idcatalogo").val(data.id_catalogo);
        $("#nombreDescripcion").val(data.nombre);
        $("#nombreDescripcionIngles").val(data.nombre_ingles);
        $("#btnGrabaCatalogo").removeAttr("disabled");
      }
    }
  );
}

function mostratCatalogo() {}

function limpiarmodalCatalogo() {
  $("#codigoCatalogo").val("");
  $("#idcatalogo").val(0);
  $("#nombreDescripcion").val("");
  $("#nombreDescripcionIngles").val("");
  $("#btnGrabaCatalogo").prop("disabled");

}

function NuevoCatalogo() {
  limpiarmodalCatalogo();
  $("#bCatalogo").val(0);
  $("#bCatalogo").selectpicker("refresh");
  $("#btnGrabaCatalogo").removeAttr("disabled");
}
init();
