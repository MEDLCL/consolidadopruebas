<?php
ob_start();
session_start();

if (!$_SESSION['nombre']) {
    header('LOCATION: ../index.php');
} else {

    require_once("../inc/head.php");
    require_once("../inc/header.php");
?>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Main content -->
        <section class="content">
            <div id="ventaTruck">
                <?php
                include_once("modal/catalogo.php");
                include_once("modal/servicioVentaTruck.php");
                include_once("modal/fleteVentaTruck.php");
                include_once("modal/modalempresa.php");
                ?>
                <form action="" id="frmVentaTruck" method="POST">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="box box-primary box-solid" id="">
                                <!--  formulario para detalle de almacen -->

                                <div class="box-header with-border text-center">VENTA NACIONAL/INTERNACIONAL</div>
                                <div class="box-body">
                                    <div class="col-md-3 col-md-offset-1">
                                        <label for="tipoVentaTRuck" class="">Tipo Venta(*) </label>
                                        <div class="input-group input-group-sm">

                                            <select id="tipoVentaTRuck" name="tipoVentaTRuck" class="form-control selectpicker" onchange="VentaInternacional()" data-live-search="true">
                                            </select>
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-default"></button>
                                            </span>
                                        </div>
                                    </div>

                                    <input type="hidden" name="idVentaTruck" id="idVentaTruck">

                                    <div class="col-md-3 col-md-offset-3">
                                        <label for="" class="">Codigo Venta(*)</label>
                                        <div class="input-group-sm">
                                            <input type="text" name="codigoVentaTruck" id="codigoVentaTruck" class="form-control" onkeyup="mayusculas(this)" readonly>
                                        </div>
                                    </div>

                                    <div class="col-md-12 form-group "></div>
                                    <div class="col-md-6 col-md-offset-1">
                                        <label for="clienteVentaTruck" class="">Cliente(*) </label>
                                        <div class="input-group input-group-sm">

                                            <select id="clienteVentaTruck" name="clienteVentaTruck" class="form-control selectpicker" onchange="cargaProyectos(0)" data-live-search="true">
                                            </select>
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-default"></button>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="proyectosTruck" class="">Proyectos(*) </label>
                                        <div class="input-group input-group-sm">

                                            <select id="proyectosTruck" name="proyectosTruck" class="form-control selectpicker" data-live-search="true" onchange="listarTarifasNuevo()">
                                            </select>
                                            <input type="hidden" name="codigoProyectoVenta" id="codigoProyectoVenta">
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-default"></button>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-md-12 form-group"></div>
                                    <div class="col-md-9 col-md-offset-1">
                                        <label for="observacionesVenta">Observaciones(*):</label>
                                        <textarea class="form-control" rows="2" id="observacionesVenta" name="observacionesVenta"></textarea>
                                    </div>
                                </div> <!-- body box  -->
                                <!-- /.box -->
                            </div><!-- /.box -->
                        </div> <!-- col md 12 tabla-->
                    </div>
                    <div class="row" id="servicioadicionalVentanueva">
                        <div class="col-md-12">
                            <div class="box box-primary box-solid">
                                <div class=" box-header with-border text-center">
                                    SERVICIOS ADICIONALES
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-body table-responsive">
                                        <table class="table table-bordered table-hover table-responsive table-hover" id="tServicioAdicionalesVenta" style="text-align:center;">
                                            <thead>
                                                <tr>
                                                    <th><span class="fa fa-cog"></span></th>
                                                    <th><span class="fa fa-check-square-o"></span> </th>
                                                    <th>Origen</th>
                                                    <th>Destino</th>
                                                    <th>Servicio</th>
                                                    <th>Tarifa Venta</th>
                                                    <th>Tarifa Costo</th>
                                                    <th></th>
                                                    <th>Cantidad</th>
                                                    <th>Comision</th>
                                                    <th>Profit</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbodyServicioAdicionalesVenta">

                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="box-footer">
                                        <button type="button" class="btn btn-primary" data-target="#modalServicioAdicionalVentaTruck" onclick="nuevoServicioAdicional()" id="btnNuevoServicioA">Nuevo <span class="fa fa-plus"></span></button>
                                    </div>
                                </div>

                            </div>
                        </div> <!-- col md 12 tabla-->
                    </div>
                    <div class="row" id="listadoEvalucaiones">
                        <div class="col-md-12">
                            <div class="box box-primary box-solid">
                                <div class=" box-header with-border text-center">
                                    DETALLES DE POSICIONAMIENTO
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-body table-responsive">
                                        <table class="table table-bordered table-hover table-responsive table-hover" id="tfletesVenta" style="text-align: center;">
                                            <thead>
                                                <tr>
                                                    <th><span class="fa fa-cog"></span>Acciones</th>
                                                    <th><span class="fa fa-check-square-o"></span></th>
                                                    <th>Origen</th>
                                                    <th>Destino</th>
                                                    <th>Tarifa Venta</th>
                                                    <th>Tarifa Costo</th>
                                                    <th></th>
                                                    <th>Tipo Unidad</th>
                                                    <th>No. Unidades</th>
                                                    <th>Total Venta</th>
                                                    <th>Total Costo</th>
                                                    <th>Hora Pos.</th>
                                                    <th>Fecha Pos.</th>
                                                    <th>Días Libres</th>
                                                    <th>Tipo Carga</th>
                                                    <th>Comision</th>
                                                    <th>Profit</th>

                                                </tr>
                                            </thead>
                                            <tbody id="tbodyfletesVenta">

                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="box-footer">
                                        <button type="button" class="btn btn-primary" id="btnNuevoFlete" data-target="#modalventafletetruck" onclick="fleteAdicional()">Nuevo <span class="fa fa-plus"></span></button>
                                    </div>
                                </div>
                            </div>
                        </div> <!-- col md 12 tabla-->
                    </div> <!-- row de tabla usuarios -->

                    <div class="row" id="idVentaInternacional">
                        <div class="col-md-12">
                            <div class="box box-primary box-solid">
                                <div class=" box-header with-border text-center">
                                    CREACION DE DOCUMENTACION
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-body table-responsive">
                                        <div class="col-md-6">
                                            <!--  <div class="col-md-12 form-group">
                                                <label for="embarcadorVenta" class="">Embarcador(*) </label>
                                                <div class="input-group input-group-sm">

                                                    <select id="embarcadorVenta" name="embarcadorVenta" class="form-control selectpicker" data-live-search="true">
                                                    </select>
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-success fa fa-plus" data-target="#modalempresa" onclick="modalEmbarcador()"></button>
                                                    </span>
                                                </div>
                                            </div> -->
                                            <div class="col-md-12 form-group">
                                                <label for="notificaraVenta" class="">Notificar a(*) </label>
                                                <div class="input-group input-group-sm">

                                                    <select id="notificaraVenta" name="notificaraVenta" class="form-control selectpicker" data-live-search="true">
                                                    </select>
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-success fa fa-plus" data-target="#modalempresa" onclick="modalNotificaA()"></button>
                                                    </span>
                                                </div>
                                            </div>
                                            <!--  <div class="col-md-12 form-group">
                                                <label for="agenteVenta" class="">Agente(*) </label>
                                                <div class="input-group input-group-sm">

                                                    <select id="agenteVenta" name="agenteVenta" class="form-control selectpicker" data-live-search="true">
                                                    </select>
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-success fa fa-plus" data-target="#modalempresa" onclick="modalAgente()"></button>
                                                    </span>
                                                </div>
                                            </div> -->
                                        </div>
                                        <!--     <div class="col-md-6">
                                            <div class="col-md-2 form-group">
                                                <button type="button" class="btn btn-success" onclick="adicionarProducto ()"><span class="fa fa-plus"></span> </button>
                                            </div>
                                            <table class="table table-bordered table-hover table-responsive table-hover" id="Tkardex">
                                                <thead>
                                                    <tr>
                                                        <th><span class="fa fa-cog"></span></th>
                                                        <th>Codigo Producto</th>
                                                        <th>Descripcion</th>
                                                        <th>Volumen</th>
                                                        <th>Peso</th>
                                                        <th>Bultos</th>
                                                        <th>Peso/Bulto</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="tbodyProductoVenta">

                                                </tbody>
                                            </table>
                                        </div> -->
                                    </div>
                                </div>
                            </div>
                        </div> <!-- col md 12 tabla-->
                    </div> <!-- row de tabla usuarios -->
                    <div class="row">
                        <div class="col-md-12">
                            <div class="box box-primary" id="">
                                <div class="box-body">
                                    <button id="btnGrabarVenta" type="button" value="" class="btn btn-primary fa fa-database" onclick="grabarNuevaVenta()"> Grabar</button>
                                    <button id="" type="button" value="" class="btn btn-danger fa fa-close" onclick="cancelarVenta()"> Cancelar</button>
                                    <button id="" type="button" value="" class="btn btn-primary fa fa-file-pdf-o" onclick="reporteVentaTruck(1)"> Reporte </button>
                                    <button id="" type="button" value="" class="btn btn-primary fa fa-envelope" onclick="reporteVentaTruck(2)"> E-mail </span></button>
                                </div> <!-- body box  -->
                                <!-- /.box -->
                            </div><!-- /.box -->
                        </div> <!-- col md 12 tabla-->
                    </div>
                </form>
            </div>
            <div class="row" id="listadoVentasTRUCK">
                <div class="col-md-12">
                    <div class="box  box-solid">
                        <div class=" box-header with-border">
                            <button type="button" class="btn btn-primary" onclick="nuevaVenta()">Nueva Venta <span class="fa  fa-plus"></span>
                            </button>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-body table-responsive">
                                <table class="table table-bordered table-hover table-responsive table-hover" id="tVentasTruck" style="text-align: center;">
                                    <thead>
                                        <tr>
                                            <th>Acciones</th>
                                            <th>Codigo</th>
                                            <th>Cliente</th>
                                            <th>Proyecto</th>
                                            <th>Observaciones</th>
                                            <!-- <th>Embarcador</th> -->
                                            <th>Notificar A</th>
                                            <!--   <th>Agente</th> -->
                                        </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div> <!-- col md 12 tabla-->
            </div> <!-- row de tabla usuarios -->
        </section><!-- /.content -->
    </div><!-- /.content-wrapper -->
    <?php
    require_once("../inc/footer.php");
    require_once("../inc/scritps.php");
    ?>
    <!--  <script>
        $(document).ready(function() {
            //Date picker
            $('#fechaI').datepicker({
                autoclose: true
            });
        });
    </script> -->
    <script src="scritps/empresa.js"></script>
    <script src="scritps/ventatruck.js"></script>
    <script src="scritps/catalogo.js"></script>

<?php }
ob_end_flush();
?>