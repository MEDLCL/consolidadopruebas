var tablaK = "";
var tablaDA = "";
var tablaDetalleP = "";

function init() {
    $("#fechaI").datepicker({
        autoclose: true
    });
    $("#delCalculoA").datepicker({
        autoclose: true
    });
    $("#alCalculoA").datepicker({
        autoclose: true
    });
    //$('#Tkardex').DataTable();
    nuevoDetalle("false");
    ocultaAlma("false");
    llenaconsignado();
    llenaCliente();

    llenaEmpaqueModal();
    llenaEmpaqueDetalle();
    listarKardex();
    llenaPlantillaBM("#agregarPlantilla");
    llenaCatalogoCalculoA();
    listarDetallePlantillaA();
    limpiarDetallePlantilla();
    $('#plantillaCalculoAlmacen').hide();
}


function llenaconsignado() {
    $("#consignado").empty();
    $.post(
        "../modelos/pais.php?op=selecEmpresa&tabla=empresas&campo=Razons", {
            id: "id_empresa",
            tipoe: "CO",
        },
        function(data, status) {
            $("#consignado").html(data);
            $("#consignado").selectpicker("refresh");
            $("#consignado").val(0);
            $("#consignado").selectpicker("refresh");
        }
    );
}


function llenaCliente() {
    $.post(
        "../modelos/pais.php?op=selecEmpresa&tabla=empresas&campo=Razons", {
            id: "id_empresa",
            tipoe: "CL",
        },
        function(data, status) {
            $("#cliente").html(data);
            $("#cliente").selectpicker("refresh");
            $("#cliente").val(0);
            $("#cliente").selectpicker("refresh");
        }
    );
}

function nuevoDetalle(deta) {
    if (deta == "true") {
        $("#datosDetalleA").show();
        $("#tablaDetalleAlmacen").hide();
    } else {
        $("#datosDetalleA").hide();
        $("#tablaDetalleAlmacen").show();
    }
    limpiaDetalle();
}

function limpiaDetalle() {
    $("#iddetallealmacen").val(0);
    $("#cliente").val(0);
    $("#cliente").selectpicker("refresh");
    $("#nohbl").val("");
    $("#peso").val(0);
    $("#ubicacion").val("");
    $("#volumen").val(0);
    $("#dut").val("");
    $("#bultos").val(0);
    $("#embalajeD").val(0);
    $("#embalajeD").selectpicker("refresh");
    $("#liberado").prop("checked", false);
    $("#resa").val("");
    $("#dti").val("");
    $("#ncancel").val("");
    $("#norden").val("");
    $("#mercaderia").val("");
    $("#observaciones").val("");
    $("#linea").val("");
}

function ocultaAlma(alma) {
    if (alma == true) {
        $("#Almacen").show();
    } else {
        $("#Almacen").hide();
    }
    nuevoAlma();
}

function nuevoAlma() {
    $("#codigoAlmacen").val("");
    $("#consignado").val(0);
    $("#consignado").selectpicker("refresh");
    $("#contenedor").val("");
    $("#poliza").val("");
    $("#referencia").val("");
    $("#pesoT").val(0);
    $("#volumenT").val(0);
    $("#bultosT").val(0);
    $("#cntClientes").val(1);
    $("#fechaI").val("");
    $("#btnNuevoDetalle").attr("disabled", "false");
    $("#grabaAlmacen").removeAttr("disabled");
}

function llenaEmpaqueModal() {
    $.post(
        "../modelos/pais.php?op=selectN&tabla=empaque&campo=nombre", {
            id: "id_empaque",
            tipoe: "",
        },
        function(data, status) {
            $("#empaqueB").html(data);
            $("#empaqueB").selectpicker("refresh");

        }
    );
}

function llenaEmpaqueDetalle() {
    $.post(
        "../modelos/pais.php?op=selectN&tabla=empaque&campo=nombre", {
            id: "id_empaque",
            tipoe: "",
        },
        function(data, status) {
            $("#embalajeD").html(data);
            $("#embalajeD").selectpicker("refresh");
        }
    );
}

function grabaEmpaque() {
    var nombre = $('#nombreE').val();
    var id_empaque = $("#id_empaque").val();
    if (nombre.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de ingresar campo nombre Empaque");
        return false;
    }
    $.post(
        "../ajax/empaque.php?op=guardaryeditar", {
            id_empaque: id_empaque,
            nombre: nombre
        },
        function(data) {
            if (data == 1) {
                llenaEmpaqueDetalle();
                $("#modalEmaqpue").modal("hide");
            }

        }
    );

}

function nuevoConsignado() {
    $('.nav-tabs a:first').tab('show')
    $("#titulomodale").text("Consignado");
    nuevo("consignado");
    $("#tituloh").html("Consignado");
    $("#llama").val("kardex");
    //consignado ingreso almacen
    $("#queActualizar").val("conAL")

}

function nuevoCliente() {
    $('.nav-tabs a:first').tab('show')
    nuevo("cliente");
    $("#llama").val("kardex");
    $("#tituloh").html("Cliente");
    //cliente detalle almacen
    $("#queActualizar").val("cliDA")
    $("#modalempresa").modal("show");


}

function limpiaEmpaque() {
    llenaEmpaqueModal();
    $("#nombreE").val("");
    $("#id_empaque").val(0);
    /*  $("#empaqueB").val(0);
        $("#empaqueB").selectpicker("refresh"); */
}

function grabarAlmacen() {
    var consignado = $("#consignado").prop("selectedIndex");
    var contenedor = $("#contenedor").val();
    var poliza = $("#poliza").val();
    var referencia = $("#referencia").val();
    var pesoT = $("#pesoT").val();
    var volumenT = $("#volumenT").val();
    var bultosT = $("#bultosT").val();
    var fechaI = $("#fechaI").val();
    var cntClientes = $("#cntClientes").val();
    if (consignado == -1 || consignado == 0) {
        alertify.alert("Campo Vacio", "Debe de Seleccionar consignado");
        return false;
    } else if (contenedor.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de ingresar Contenedor/Placa");
        return false;
    } else if (poliza.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de ingresar Poliza");
        return false;
    } else if (referencia.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de ingresar Referencia");
        return false;
    } else if (pesoT.trim() == "" || pesoT == 0) {
        alertify.alert("Campo Vacio", "Debe de ingresar Peso");
        return false;
    } else if (volumenT.trim() == "" || volumenT == 0) {
        alertify.alert("Campo Vacio", "Debe de ingresar Volumen");
        return false;
    } else if (bultosT.trim() == "" || bultosT == 0) {
        alertify.alert("Campo Vacio", "Debe de ingresar Bultos");
        return false;
    } else if (cntClientes.trim() == "" || cntClientes == 0) {
        alertify.alert("Campo Vacio", "Debe de ingresar Cantidad de Clientes");
        return false;
    } else if (fechaI.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de ingresar Fecha Ingreso Almacen");
        return false;
    }
    var formAlmacen = new FormData($("#formAlmacen")[0]);
    $.post(
        "../ajax/kardex.php?op=codigo", {},
        function(data, status) {
            if (status == "success") {
                $("#codigoAlmacen").val(data);
                formAlmacen = new FormData($("#formAlmacen")[0]);
                $.ajax({

                    url: "../ajax/kardex.php?op=guardaryeditar",
                    type: "POST",
                    data: formAlmacen,
                    contentType: false,
                    processData: false,
                    success: function(datos) {
                        if (datos > 0) {
                            //limpiar();
                            // $('#listadosucursal').DataTable().ajax.reload();
                            $('#Tkardex').DataTable().ajax.reload();
                            $("#idAlmacenD").val(datos);
                            alertify.success("Proceso Realizado con exito");
                            $("#btnNuevoDetalle").removeAttr("disabled");
                            $("#grabaAlmacen").attr("disabled", "false");

                        } else {
                            alertify.error("Proceso no se pudo realizar") + " " + datos;
                        }
                    }
                });
            } else {
                alertify.alert("Error al Genera el Codigo");
            }
        }
    );
}

function listarKardex() {
    tablaK = $('#Tkardex').dataTable({
        "aProcessing": true, //Activamos el procesamiento del datatables
        "aServerSide": true, //Paginacion y fltrado realizado por el servidor
        dom: 'Bfrtip', //Definimos los elementos de control de tabla
        buttons: ['copyHtml5', 'excelHtml5', 'pdfHtml5'],
        "ajax": {
            url: '../ajax/kardex.php?op=listarK',
            type: "get",
            dataType: "json",
            error: function(e) {
                console.log(e.responseText);
            }
        },
        "bDestroy": true,
        "iDisplayLenth": 10, //paginacion
        "order": [
                [8, "desc"]
            ] //order los datos
    });
}

function ListarAlmacen(idAlmacen) {
    nuevoAlma();
    $.post("../ajax/kardex.php?op=mostrarA", {
            idAlmacen: idAlmacen
        },

        function(data, status) {
            data = JSON.parse(data);
            if (data.id_almacen > 0) {
                ocultaAlma(true);
                $("#idAlmacen").val(data.id_almacen);
                $("#idAlmacenD").val(data.id_almacen);
                $("#codigoAlmacen").val(data.codigo);
                $("#consignado").val(data.id_consignado);
                $("#consignado").selectpicker("refresh");
                $("#contenedor").val(data.contenedor_placa);
                $("#poliza").val(data.poliza);
                $("#referencia").val(data.referencia);
                $("#pesoT").val(data.peso);
                $("#volumenT").val(data.volumen);
                $("#bultosT").val(data.bultos);
                $("#cntClientes").val(data.cant_clientes);
                $("#fechaI").val(data.fechaI);
                $("#btnNuevoDetalle").removeAttr("disabled");
                $("#grabaAlmacen").removeAttr("disabled");
                nuevoDetalle("false");
                listarTablaDA(idAlmacen);
            } else {
                alertify.alert("Error", "Ha ocurrido un error");
            }

        })
}

function grabaDetalle() {
    var cliente = $("#cliente").prop("selectedIndex");
    var peso = $("#peso").val();
    var volumen = $("#volumen").val();
    var bultos = $("#bultos").val();
    var embalaje = $("#embalajeD").prop("selectedIndex");
    var merca = $("#mercaderia").val();

    if (cliente == -1 || cliente == 0) {
        alertify.alert("Campo Vacio", "Debe de seleccionar el Cliente");
        return false;
    } else if (peso == 0) {
        alertify.alert("Campo Vacio", "Debe de colocar el Peso");
        return false;
    } else if (volumen == 0) {
        alertify.alert("Campo Vacio", "Debe de colocar el Volumen");
        return false;
    } else if (bultos == 0) {
        alertify.alert("Campo Vacio", "Debe de colocar los bultos");
        return faslse;
    } else if (embalaje == -1 || embalaje == 0) {
        alertify.alert("Campo Vacio", "Debe de seleccionar Embalaje");
        return false;
    } else if (merca.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de Ingresar Mercaderia");
        return false;
    }
    formDAlmacen = new FormData($("#formAlmacenDetalle")[0]);
    $.ajax({
        url: "../ajax/detalleAlmacen.php?op=guardaryeditar",
        type: "POST",
        data: formDAlmacen,
        contentType: false,
        processData: false,
        success: function(datos) {
            if (datos > 0) {
                $('#Tdetalle').DataTable().ajax.reload();
                $('#Tkardex').DataTable().ajax.reload();
                alertify.success("Proceso Realizado con exito");
                $("#btnNuevoDetalle").removeAttr("disabled");
                nuevoDetalle("false");
            } else {
                alertify.error("Proceso no se pudo realizar") + " " + datos;
            }
        }
    });

}

function listarTablaDA(idAlmacenD) {
    tablaDA = $('#Tdetalle').dataTable({
        "aProcessing": true, //Activamos el procesamiento del datatables
        "aServerSide": true, //Paginacion y fltrado realizado por el servidor
        dom: 'Bfrtip', //Definimos los elementos de control de tabla
        buttons: ['copyHtml5', 'excelHtml5', 'pdfHtml5'],
        "ajax": {
            url: '../ajax/detalleAlmacen.php?op=listarDA',
            type: "post",
            data: {
                idAlmacenD: idAlmacenD
            },
            dataType: "json",
            error: function(e) {
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

function mostrarDetalleA(iddetallealmacen) {
    nuevoDetalle("true");
    $.post("../ajax/detalleAlmacen.php?op=mostrarDetalleA", {
            iddetallealmacen: iddetallealmacen
        },
        function(data, status) {
            data = JSON.parse(data);
            if (data.id_detalle > 0) {
                $("#iddetallealmacen").val(data.id_detalle);

                $("#idAlmacenD").val(data.id_almacen);
                $("#cliente").val(data.id_cliente);
                $("#cliente").selectpicker("refresh");

                $("#nohbl").val(data.nohbl);
                $("#peso").val(data.peso);
                $("#volumen").val(data.volumen);
                $("#bultos").val(data.bultos);
                $("#ubicacion").val(data.ubicacion);
                $("#dut").val(data.dut);
                $("#embalajeD").val(data.id_embalaje);
                $("#embalajeD").selectpicker("refresh");
                if (data.liberado == "1") {
                    $("#liberado").prop("checked", "true");

                } else {
                    $("#liberado").removeAttr("checked");
                }
                $("#resa").val(data.resa);
                $("#dti").val(data.dti);
                $("#ncancel").val(data.no_cancel);
                $("#norden").val(data.no_orden);
                $("#linea").val(data.linea);
                $("#mercaderia").val(data.mercaderia);
                $("#observaciones").val(data.observaciones);

            } else {
                alertify.alert("Error", "Ha ocurrido un error");
            }

        })
}

function anulaDetalle(iddetallealmacen) {
    var confirm = alertify.confirm('', 'Desea Anular Detalle', null, null).set('labels', {
        ok: 'Anular',
        cancel: 'Cancelar'
    });

    confirm.set({
        transition: 'slide'
    });

    confirm.set('onok', function() {
        $.post(
            "../ajax/detalleAlmacen.php?op=anularDetalle", {
                iddetallealmacen: iddetallealmacen
            },
            function(data) {
                if (data > 0) {
                    $('#Tkardex').DataTable().ajax.reload();
                    alertify.alert("", "Detalle Anulado");
                }

            }
        );
    });

}

function sumaCifImpuesto() {
    var cif = $("#cifCalculo").val();
    var impuesto = $("#impuestoCalculo").val();
    var baseS = 0;

    if (cif.trim() == "") {
        cif = 0;
    }
    if (impuesto.trim() == "") {
        impuesto = 0;
    }
    baseS = parseFloat(cif) + parseFloat(impuesto);
    $("#bSeguroCalculo").val(baseS);

}

function CargaCalculoNuevo(iddetalleAlmacen) {
    $('#plantillaCalculoAlmacen').hide();
    nuevoCalculo();
    $.post("../ajax/calculoAlmacen.php?op=MostrarCalculoNuevo", {
            iddetalleAlmacen: iddetalleAlmacen
        },

        function(data, status) {
            data = JSON.parse(data);
            if (data.id_detalle > 0) {
                // $("#idAlmacen").val(data.id_almacen);
                $("#id_detalleA_calculo").val(data.id_detalle);
                $("#polizaEntradaCalculo").val(data.poliza);
                $("#pesoCalculo").val(data.peso);
                $("#VolumenCalculo").val(data.volumen);
                $("#bultosCalculoTotal").val(data.bultos);
                $("#clientesCuadrilla").val(data.cant_clientes);
                $("#CantClientes").val(data.cant_clientes);
                $("#delCalculoA").val(data.fechaI);
                listarClienteCalculo(data.id_detalle);
                $("#clienteCalculoA").prop("selectedIndex", 2);
                $("#clienteCalculoA").selectpicker("refresh");
                llenaPlantillaBM("#plantilla");

            } else {
                alertify.alert("Error", "Ha ocurrido un error");
            }

        })
}


function listarClienteCalculo(iddetalleAlmacen) {
    $.post("../ajax/calculoAlmacen.php?op=listarCliente", {
            iddetalleAlmacen: iddetalleAlmacen
        },
        function(data, status) {
            $("#clienteCalculoA").html(data);
            $("#clienteCalculoA").selectpicker("refresh");
            $("#clienteCalculoA").prop("selectedIndex", 2);
            $("#clienteCalculoA").selectpicker("refresh");
        }
    );
}

function nuevoCalculo() {
    $("#clienteCalculoA").val(0);
    $("#clienteCalculoA").selectpicker("refresh");
}

function calcularDias() {
    var delCalculo = $("#delCalculoA").val();
    var alcalculo = $("#alCalculoA").val();
    $("#totalDias").val(0);

    $.post("../ajax/calculoAlmacen.php?op=contarDias", {
            delCalculo: delCalculo,
            alcalculo: alcalculo
        },
        function(data, status) {
            $("#totalDias").val(data);
        }
    );
}

function calcularCifDolares() {
    var tc = $("#tipoCambioCalculo").val();
    var cif = $("#cifgtdolar").val();
    var res = 0;
    if (tc.trim() == "") {
        tc = 0;
    }
    if (cif.trim() == "") {
        cif = 0
    }
    res = parseFloat(tc) * parseFloat(cif);
    res = res.toFixed(3);
    $("#cifCalculo").val(res);
    sumaCifImpuesto();
}


function limpiarPlantillaG() {
    $("#nombrePlantillaG").val("");
    $("#tarifaMinimaG").val(0);
    $("#diasLibresPlantillaG").val(0);
    $("#grabarNuevaP").removeAttr("disabled");
    $("#idplantillaG").val(0);
    $("#omitirDiasLibre").removeAttr("checked");
    $("#monedaPlantillaG").val(0);
    $("#monedaPlantillaG").selectpicker("refresh");
}

function grabarPlnatillaAlmacen() {
    var nombre = $("#nombrePlantillaG").val();
    var tarifa = $("#tarifaMinimaG").val();
    var diaslibres = $("#diasLibresPlantillaG").val();
    var moneda = $("#monedaPlantillaG").prop("selectedIndex");

    if (nombre.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de colocar el nombre");
        return false;
    } else if (tarifa.trim() == "" || tarifa == 0) {
        alertify.alert("Campo Vacio", "Debe de colocar Tarifa Minima");
        return false;
    } else if (moneda == -1 || moneda == 0) {
        alertify.alert("Campo Vacio", "Debe de seleccionar la Moneda");
        return false;
    } else if (diaslibres.trim() == "" || diaslibres == 0) {
        alertify.alert("Campo Vacio", "Debe de colocar Dias Libres de Almacenaje");
        return false;
    }
    var frmPlantilla = new FormData($("#frmNuevaPlantillaA")[0]);
    $.ajax({
        url: "../ajax/plantillaCalculoAlmacen.php?op=guardaryeditar",
        type: "POST",
        data: frmPlantilla,
        contentType: false,
        processData: false,
        success: function(datos) {
            if (datos > 0) {
                alertify.success("Proceso Realizado con exito");
                $("#grabarNuevaP").prop("disabled", "true");
                llenaPlantillaBM("#plantillaBG");
                llenaPlantillaBM("#plantilla");
                llenaPlantillaBM("#agregarPlantilla");
            } else {
                alertify.error("Proceso no se pudo realizar") + " " + datos;
            }
        }
    });

}
//

function llenaPlantillaBM(selecPlantilla) {
    $(selecPlantilla).empty();
    $.post(
        "../modelos/pais.php?op=selectN&tabla=plantilla_calculoa&campo=nombre", {
            id: "id_plantilla",
            tipoe: "",
        },
        function(data, status) {
            $(selecPlantilla).html(data);
            $(selecPlantilla).selectpicker("refresh");
            $(selecPlantilla).val(0);
            $(selecPlantilla).selectpicker("refresh");
        }
    );
}


function llenaMoneda() {
    $("#monedaPlantillaG").empty();
    $.post(
        "../modelos/pais.php?op=llenaMoneda", {},
        function(data, status) {
            $("#monedaPlantillaG").html(data);
            $("#monedaPlantillaG").selectpicker("refresh");
            $("#monedaPlantillaG").val(0);
            $("#monedaPlantillaG").selectpicker("refresh");
        }
    );
}

function cargaNombrePlantilla(quienLLama) {
    if (quienLLama == 1) {
        var idplantillaG = $("#plantillaBG").val();
        limpiarPlantillaG();
        $.post(
            "../ajax/plantillaCalculoAlmacen.php?op=mostrarP", {
                idplantillaG: idplantillaG
            },
            function(data, status) {
                data = JSON.parse(data);
                if (data.id_plantilla >= 1) {
                    $("#nombrePlantillaG").val(data.nombre);
                    $("#monedaPlantillaG").selectpicker("refresh");
                    $("#monedaPlantillaG").val(data.moneda);
                    $("#monedaPlantillaG").selectpicker("refresh");
                    $("#diasLibresPlantillaG").val(data.dias_libres);
                    $("#idplantillaG").val(data.id_plantilla);
                    $("#tarifaMinimaG").val(data.tarifa_minima);
                    if (data.omitir_almacenaje == "1") {
                        $("#omitirDiasLibreG").prop("checked", true);
                    } else {
                        $("#omitirDiasLibreG").prop("checked", false);
                    }
                    $("#grabarNuevaP").removeAttr("disabled");
                }
            }
        );

    } else {
        var idplantillaG = $("#agregarPlantilla").val();
        $.post(
            "../ajax/plantillaCalculoAlmacen.php?op=mostrarP", {
                idplantillaG: idplantillaG
            },
            function(data, status) {
                data = JSON.parse(data);
                if (data.id_plantilla >= 1) {
                    $("#monedaPlantillaG").selectpicker("refresh");
                    $("#monedaPlantillaG").val(data.moneda);
                    $("#monedaPlantillaG").selectpicker("refresh");
                    $("#diasLibresPlantillaMP").val(data.dias_libres);
                    $("#idplantillaMP").val(data.id_plantilla);
                    $("#idMonedaPlantillaMP").val(data.moneda);

                    $("#tarifaMinimaMP").val(data.signo + ' ' + data.tarifa_minima);
                    if (data.omitir_almacenaje == "1") {
                        $("#omitirDias").prop("checked", true);
                    } else {
                        $("#omitirDias").prop("checked", false);
                    }
                    listarDetallePlantillaA(data.id_plantilla);
                    //$('#TplantillaG').DataTable().ajax.reload();
                }
            }
        );
    }
}

function llenaCatalogoCalculoA() {
    $("#catalogoPlantillaAlmacen").empty();
    $.post(
        "../modelos/pais.php?op=selectN&tabla=catalogo&campo=nombre", {
            id: "id_catalogo",
            tipoe: "",
        },
        function(data, status) {
            $("#catalogoPlantillaAlmacen").html(data);
            $("#catalogoPlantillaAlmacen").selectpicker("refresh");
            $("#catalogoPlantillaAlmacen").val(0);
            $("#catalogoPlantillaAlmacen").selectpicker("refresh");
        }
    );
}

function nuevoCatalogoCalculoA() {
    $("#llamaCalculoA").val("calculoA");
    llenaCatalogoModal();
    limpiarmodalCatalogo();
}

function nuevoDetallePlantilla() {
    limpiarDetallePlantilla();
    $("#btnGrabarDetallePlantilla").removeAttr("disabled");
}

function limpiarDetallePlantilla() {
    $("#catalogoPlantillaAlmacen").val(0);
    $("#catalogoPlantillaAlmacen").selectpicker("refresh");
    $("#minimoDetallePlantillaA").val(0);
    $("#tarifaDetallePlantillaA").val(0);
    $("#porcentajeDetallePA").val(0);
    $("#porPeso").prop("checked", false);
    $("#porVolumen").prop("checked", false);
    $("#porDia").prop("checked", false);
    $("#iddetallePlantilla").val(0);
    $("#btnGrabarDetallePlantilla").prop("disabled", "true");
}

function grabarDetallePlantilla() {
    /*     idplantillaMP
        idMonedaPlantillaMP
        catalogoPlantillaAlmacen
        minimoDetallePlantillaA
        porPeso
        tarifaDetallePlantillaA
        porVolumen
        porcentajeDetallePA
        porDia
     */
    var idcatalogo = $("#catalogoPlantillaAlmacen").prop("selectedIndex");
    var idplantilla = $("#idplantillaMP").val();

    if (idplantilla == 0 || idplantilla.trim() == "") {
        alertify.alert("Campo Vacio", "Debe de Seleccionar una Plantilla");
        return false;
    } else if (idcatalogo == -1 || idcatalogo == 0) {
        alertify.alert("Campo Vacio", "Debe de Seleccionar una Descripciòn");
        return false;
    }
    var frmPlantilla = new FormData($("#frmDetallePlnatillaA")[0]);
    $.ajax({
        url: "../ajax/detalle_plantillaA.php?op=guardaryeditar",
        type: "POST",
        data: frmPlantilla,
        contentType: false,
        processData: false,
        success: function(datos) {
            if (datos > 0) {
                alertify.success("Proceso Realizado con exito");
                $("#btnGrabarDetallePlantilla").prop("disabled", "true");
                $('#TplantillaG').DataTable().ajax.reload();
                listarDetallePlantillaA(idplantilla);

                limpiarDetallePlantilla();
            } else {
                alertify.error("Proceso no se pudo realizar") + " " + datos;
            }
        }
    });


}

function nuevaPlantillaCalculo() {
    $("#btnGrabarDetallePlantilla").prop("disabled", "true");
}

function listarDetallePlantillaA(idplantillaMP) {
    $('#TplantillaG').dataTable({
        "aProcessing": true, //Activamos el procesamiento del datatables
        "aServerSide": true, //Paginacion y fltrado realizado por el servidor
        dom: 'Bfrtip', //Definimos los elementos de control de tabla
        buttons: ['copyHtml5', 'excelHtml5', 'pdfHtml5'],
        "ajax": {
            url: '../ajax/detalle_plantillaA.php?op=listarDP',
            type: "post",
            dataType: "json",
            data: { "idplantillaMP": idplantillaMP },
            error: function(e) {
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

function mostrarDetallePlantilla(iddetallePlantilla) {
    $.post(
        "../ajax/detalle_plantillaA.php?op=mostrarDP", {
            iddetallePlantilla: iddetallePlantilla
        },

        function(data, status) {
            data = JSON.parse(data);
            if (data.id_detalle >= 1) {
                $("#iddetallePlantilla").val(data.id_detalle);
                $("#catalogoPlantillaAlmacen").val(data.id_catalogo);
                $("#catalogoPlantillaAlmacen").selectpicker("refresh");
                $("#minimoDetallePlantillaA").val(data.minimo);
                $("#tarifaDetallePlantillaA").val(data.tarifa);
                $("#porcentajeDetallePA").val(data.porcentaje);

                if (data.por_peso == "1") {
                    $("#porPeso").prop("checked", true);
                } else {
                    $("#porPeso").prop("checked", false);
                }

                if (data.por_volumen == "1") {
                    $("#porVolumen").prop("checked", true);
                } else {
                    $("#porVolumen").prop("checked", false);
                }
                if (data.por_dia == "1") {
                    $("#porDia").prop("checked", true);
                } else {
                    $("#porDia").prop("checked", false);
                }
                $("#btnGrabarDetallePlantilla").removeAttr("disabled");
            }
        }
    );
}

function eliminarDetallePlantilla(iddetallePlantilla) {
    var idplantilla = $("#idplantillaMP").val();
    $.post(
        "../ajax/detalle_plantillaA.php?op=eliminaDetalleP", {
            iddetallePlantilla: iddetallePlantilla
        },

        function(data, status) {

            data = JSON.parse(data);
            if (data >= 1) {

                listarDetallePlantillaA(idplantilla);
                Swal.fire(
                    'Eliminado con Exito!',
                    'Aceptar!',
                    'success'
                )
            }
        }
    );
}

function nuevaPlantillaCalculo() {
    $('#plantillaCalculoAlmacen').show();
    $('#calculoAlmacen').hide();

}

function cancelarPlantillaCalculo() {
    $('#plantillaCalculoAlmacen').hide();
    $('#calculoAlmacen').show();
}

function cargaCalulosPlantilla() {
    // enviar fecha desde hasta
    // enviar peso y volumen
    // base para seguro
    //bultos y clientes para cuadrilla 

    var idplantilla = $("#plantilla").val();
    var delCalculo  = $("#delCalculoA").val();
    var alcalculo= $("#alCalculoA").val();
    var impuesto= $("#impuestoCalculo").val();
    var baseparas =$("#bSeguroCalculo").val();
    var peso = $("#pesoCalculo").val();
    var volumen = $("#VolumenCalculo").val();
    var bultos = $("#bultosCalculoPen").val();
    var cntclie = $("#clientesCuadrilla").val();
    var diaslibres =$("#diaslPC").val();
    var totalminimo = $("#TotalMinimo").val();
    var dcompleto = $("#diascompletoPC").val();

    //$("#diaslPC").val(data.dias_libres);
    //$("#TotalMinimo").val(data.tarifa_minima);
    //$("#diascompletoPC").val(1);

    $('#TcalculosALmacenP').dataTable({
        "aProcessing": true, //Activamos el procesamiento del datatables
        "aServerSide": true, //Paginacion y fltrado realizado por el servidor
        dom: 'Bfrtip', //Definimos los elementos de control de tabla
        buttons: ['pdfHtml5'],
        "ajax": {
            url: '../ajax/calculoAlmacen.php?op=calcular',
            type: "post",
            dataType: "json",
            data: { "idplantilla": idplantilla,
                    "delCalculo":delCalculo,
                    "alCalculo":alcalculo,
                    "impuesto":impuesto,
                    "baseparas":baseparas,
                    "peso":peso,
                    "volumen":volumen,
                    "bultos":bultos,
                    "cntclie":cntclie,
                    "diaslibres":diaslibres,
                    "tminimo":totalminimo,
                    "dcompleto":dcompleto           
        },
            error: function(e) {
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
function cargaPlantillaparaCalculo(){
    var idplantillaG = $("#plantilla").val();
        $.post(
            "../ajax/plantillaCalculoAlmacen.php?op=mostrarP", {
                idplantillaG: idplantillaG
            },
            function(data, status) {
                data = JSON.parse(data);
                if (data.id_plantilla >= 1) {    
                    $("#diaslPC").val(data.dias_libres);
                    $("#TotalMinimo").val(data.tarifa_minima);
                    if (data.omitir_almacenaje == "1") {
                        $("#diascompletoPC").val(1);
                    } else {
                        $("#diascompletoPC").val(0);
                    }
                }
            }
        );
}
init();