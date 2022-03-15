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
            <?php
            /*include_once("../vistas/modal/facturaAlmacen.php") */
            ?>

            <div class="row col-md-12">
                <div class="box box-primary box-solid" id="">
                    <!--  formulario para detalle de almacen -->
                    <div class="box-header with-border text-center">TARIFARIO</div>
                    <div class="box-body">
                        <div class="col-md-3 form-group">
                            <label for="codigoProyecto" class="">Codigo Proyecto(*) </label>
                            <div class="input-group input-group-sm">
                                <select id="codigoProyecto" name="codigoProyecto" class="form-control selectpicker" data-live-search="true" onchange="llenaTarifasFleteServicio()">
                                </select>
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-default"></button>
                                </span>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <label for="" class="">.</label>
                            <div class="input-group-sm">
                                <button type="button" class="btn btn-primary" onclick="llenaTarifasFleteServicio()"><span class="fa fa-search-plus"></span>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <label for="" class="">.</label>
                            <div class="input-group-sm">
                                <button type="button" class="btn btn-primary" onclick="reporteTarifario(1)"><span class="fa fa-file-pdf-o"></span>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <label for="" class="">.</label>
                            <div class="input-group-sm">
                                <button type="button" class="btn btn-primary" onclick="reporteTarifario(2)"><span class="fa fa-envelope"></span>
                                </button>
                            </div>
                        </div>

                    </div> <!-- body box  -->
                    <!-- /.box -->
                </div><!-- /.box -->
            </div>

            <div class="row col-md-12">
                <div class="box box-primary box-solid" id="">
                    <!--tarifas -->
                    <div class="box-header with-border text-center">TARIFA FLETE</div>
                    <div class="box-body">
                        <div class="col-md-6">
                            <form action="" method="post" id="frmTarifasFlete">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <div class="col-md-12 form-group">
                                            <label for="origenTarifa">Origen(*):</label>
                                            <textarea class="form-control" rows="1" id="origenTarifa" name="origenTarifa"></textarea>
                                        </div>
                                        <div class="col-md-12 form-group">
                                            <label for="destinoTarifa">Destino(*):</label>
                                            <textarea class="form-control" rows="1" id="destinoTarifa" name="destinoTarifa"></textarea>
                                        </div>
                                        <div class="col-md-6 form-group">
                                            <label for="tipoUnidadTarifa" class="">Tipo de Unidad(*) </label>
                                            <div class="input-group input-group-sm">
                                                <select id="tipoUnidadTarifa" name="tipoUnidadTarifa" class="form-control selectpicker" data-live-search="true">
                                                </select>
                                                <span class="input-group-btn">
                                                    <button type="button" class="btn btn-default"></button>
                                                </span>
                                            </div>
                                        </div>
                                        <!-- <div class="col-md-6 form-group">
                                            <label for="pilotoTarifa" class="">Piloto(*) </label>
                                            <div class="input-group input-group-sm">
                                                <select id="pilotoTarifa" name="pilotoTarifa" class="form-control selectpicker" data-live-search="true">
                                                </select>
                                                <span class="input-group-btn">
                                                    <button type="button" class="btn btn-default"></button>
                                                </span>
                                            </div>
                                        </div> -->
                                        <div class="col-md-6 form-group">
                                            <label for="">No. Ayudantes</label>
                                            <div class="input-group-sm">
                                                <input type="number" class="form-control" name="numeroPilotos" id="numeroPilotos">
                                                <input type="hidden" name="idtarifaflete" id="idtarifaflete">
                                            </div>
                                        </div>
                                        <div class="col-md-6 form-group">
                                            <label for="">Validez(*)</label>
                                            <div class="input-group-sm">
                                                <input type="text" class="form-control" name="validezTarifaFlete" id="validezTarifaFlete">
                                            </div>
                                        </div>
                                        <div class="col-md-6 form-group">
                                            <label for="tipoCargaTarifa" class="">Tipo Carga(*) </label>
                                            <div class="input-group input-group-sm">
                                                <select id="tipoCargaTarifa" name="tipoCargaTarifa" class="form-control selectpicker" data-live-search="true">
                                                </select>
                                                <span class="input-group-btn">
                                                    <button type="button" class="btn btn-default"></button>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-md-12"></div>
                                        <div class="col-md-4 form-group">
                                            <label for="">Tarifa Venta(*)</label>
                                            <div class="input-group-sm">
                                                <input type="number" class="form-control" name="tarifaVentaFlete" id="tarifaVentaFlete">
                                            </div>
                                        </div>
                                        <div class="col-md-4 form-group">
                                            <label for="">Tarifa Costo(*)</label>
                                            <div class="input-group-sm">
                                                <input type="number" class="form-control" name="tarifaCostoFlete" id="tarifaCostoFlete">
                                            </div>
                                        </div>
                                        <div class="col-md-3 form-group">
                                            <label for="monedaTarifaFlete" class="">.</label>
                                            <div class="input-group input-group-sm">
                                                <select id="monedaTarifaFlete" name="monedaTarifaFlete" class="form-control selectpicker" data-live-search="true">
                                                </select>
                                                <!-- <span class="input-group-btn">
                                                <button type="button" class="btn btn-default"></button>
                                            </span> -->
                                            </div>
                                        </div>
                                        <div class="col-md-12 form-group col-md-offset-4">
                                            <button type="button" class="btn btn-primary" onclick="grabarEditarTarifaFlete()">Registrar <span class="fa fa-plus-circle"></span> </button>
                                        </div>

                                    </div> <!-- body box  -->
                                </div>
                            </form>
                        </div>
                        <div class="col-md-6">

                            <div class="panel panel-default">
                                <div class="panel-body table-responsive">
                                    <table class="table table-bordered table-hover table-responsive table-hover" id="TuniadesAsignadas">
                                        <thead>
                                            <tr>
                                                <th>Acciones</th>
                                                <th>Origen</th>
                                                <th>Destino</th>
                                                <th>Tipo Unidad</th>
                                                <th>No. Ayudantes</th>
                                                <th>Validez</th>
                                                <th>Tipo Carga</th>
                                                <th>Venta</th>
                                                <th>Costo</th>
                                                <th>Signo</th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> <!-- col md 8 tabla-->
            <div class="row col-md-12">
                <div class="box box-primary box-solid" id="">
                    <!--  formulario para detalle de almacen -->
                    <div class="box-header with-border text-center">TARIFAS SERVICIOS</div>
                    <div class="box-body">

                        <div class="col-md-6">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-12 form-group">
                                        <label for="servicioTarifa" class="">Servicio(*) </label>
                                        <div class="input-group input-group-sm">
                                            <select id="servicioTarifa" name="servicioTarifa" class="form-control selectpicker" data-live-search="true">
                                            </select>
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-default"></button>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <label for="origenServicioTarifa">Origen(*):</label>
                                        <textarea class="form-control" rows="1" id="origenServicioTarifa" name="origenServicioTarifa"></textarea>
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <label for="destinoServicioTarifa">Destino(*):</label>
                                        <textarea class="form-control" rows="1" id="destinoServicioTarifa" name="destinoServicioTarifa"></textarea>
                                    </div>
                                    <div class="col-md-4 form-group">
                                        <label for="">Validez(*)</label>
                                        <div class="input-group-sm">
                                            <input type="text" class="form-control" name="validezServicio" id="validezServicio">
                                        </div>
                                    </div>
                                    <div class="col-md-12 form-group"></div>
                                    <div class="col-md-4 form-group">
                                        <label for="">Tarifa Venta(*)</label>
                                        <div class="input-group-sm">
                                            <input type="number" class="form-control" name="tarifaVentaServicio" id="tarifaVentaServicio">
                                            <input type="hidden" name="idtarifaservicio" id="idtarifaservicio">
                                        </div>
                                    </div>
                                    <div class="col-md-4 form-group">
                                        <label for="">Tarifa Costo(*)</label>
                                        <div class="input-group-sm">
                                            <input type="number" class="form-control" name="tarifaCostoServicio" id="tarifaCostoServicio">
                                        </div>
                                    </div>
                                    <div class="col-md-4 form-group">
                                        <label for="monedaServicioTarifa" class="">.</label>
                                        <div class="input-group input-group-sm">
                                            <select id="monedaServicioTarifa" name="monedaServicioTarifa" class="form-control selectpicker" data-live-search="true">
                                            </select>
                                            <!-- <span class="input-group-btn">
                                                <button type="button" class="btn btn-default" disabled></button>
                                            </span> -->
                                        </div>
                                    </div>
                                    <div class="col-md-12 form-group col-md-offset-4">
                                        <button type="button" class="btn btn-primary" onclick="registrarServiciosTarifa()">Registrar <span class="fa fa-plus-circle"></span> </button>
                                    </div>

                                </div> <!-- body box  -->
                            </div>
                        </div>
                        <div class="col-md-6">

                            <div class="panel panel-default">
                                <div class="panel-body table-responsive">
                                    <table class="table table-bordered table-hover table-responsive table-hover" id="tServiciosTarifas">
                                        <thead>
                                            <tr>
                                                <th>Acciones</th>
                                                <th>Servicio</th>
                                                <th>Origen</th>
                                                <th>Destino</th>
                                                <th>Tarifa Venta</th>
                                                <th>Tarifa Costo</th>
                                                <th>Signo</th>
                                                <th>Validez</th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> <!-- col md 8 tabla-->
            <div class="row">
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
    <script src="scritps/tarifarioTruck.js"></script>
    <script>
    </script>

<?php }
ob_end_flush();
?>