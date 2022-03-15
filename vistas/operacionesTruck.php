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
            <div id="ingresoEmbarqueTruck" class="row">
                <div class="col-md-12">
                    <div class="box box-primary box-solid" id="">
                        <!--  formulario para detalle de almacen -->
                        <div class="box-header with-border text-center">PROGRAMACION Y COORDINACION DE EMBARQUE</div>
                        <div class="box-body">
                            <div class="col-md-4">
                                <label for="ventaOperaciones" class="">Venta No.(*) </label>
                                <div class="input-group input-group-sm">

                                    <select id="ventaOperaciones" name="ventaOperaciones" class="form-control selectpicker" onchange="llenarFletesOP()">
                                    </select>
                                    <span class="input-group-btn">
                                        <button type="button" class="btn btn-default"></button>
                                    </span>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <label for="" class="">Codigo de Embarque(*)</label>
                                <div class="input-group-sm">
                                    <input type="text" name="" id="input" class="form-control" onkeyup="mayusculas(this)">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <label for="" class="">No. De CP/MN/Referencia(*)</label>
                                <div class="input-group-sm">
                                    <input type="text" name="" id="input" class="form-control" onkeyup="mayusculas(this)">
                                </div>
                            </div>
                        </div> <!-- body box  -->
                        <!-- /.box -->
                    </div><!-- /.box -->
                </div> <!-- col md 12 tabla-->

                <div class="col-md-12">
                    <div class="box box-primary">
                        <div class=" box-header with-border text-center">
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-body table-responsive">
                                <table class="table table-bordered table-hover table-responsive table-hover" id="tfleteoperaciones">
                                    <thead>
                                        <tr>
                                            <th>Ruta</th>
                                            <th>Tipo de Unidad</th>
                                            <th>No. Unidades</th>
                                            <th>Tarifa Venta</th>
                                            <th>Tarifa Costo</th>
                                            <th></th>
                                            <th>Total Venta</th>
                                            <th>Hora Posicionamiento</th>
                                            <th>Tipo Carga</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                    <tfoot>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>
                </div> <!-- col md 12 tabla-->

                <div id="listadoEvalucaiones">
                    <div class="col-md-12">
                        <div class="box box-primary">
                            <div class=" box-header with-border text-center">
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-body table-responsive">
                                    <table class="table table-bordered table-hover table-responsive table-hover" id="Tkardex">
                                        <thead>
                                            <tr>
                                                <th>Ruta</th>
                                                <th>Transportista</th>
                                                <th>Piloto</th>
                                                <th>Licencia</th>
                                                <th>Placa</th>
                                                <th>Placa TC</th>
                                                <th>Fianza</th>
                                                <th>Peso</th>
                                                <th>Bultos</th>
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

                <div id="listadoEvalucaiones">
                    <div class="col-md-12">
                        <div class="box box-primary">
                            <div class=" box-header with-border text-center">
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-body table-responsive">
                                    <table class="table table-bordered table-hover table-responsive table-hover" id="Tkardex">
                                        <thead>
                                            <tr>
                                                <th>Servicios Adicionales</th>
                                                <th>Tarifa Venta</th>
                                                <th>Tarifa Costo</th>
                                                <th>Cantidad</th>
                                                <th>Proveedor</th>
                                                <th>Centificado de Seguro</th>

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
                <div id="">
                    <div class="col-md-12">
                        <div class="box box-primary">
                            <div class=" box-header with-border text-center">

                            </div>
                            <div class="panel panel-default">
                                <div class="panel-body table-responsive">
                                    <div class="col-md-6">
                                        <div class="col-md-12 form-group">
                                            <label for="consiganado" class="">Consignatario(*) </label>
                                            <div class="input-group input-group-sm">

                                                <select id="fianza" name="fianza" class="form-control selectpicker" data-live-search="true">
                                                </select>
                                                <span class="input-group-btn">
                                                    <button type="button" class="btn btn-success fa fa-plus"></button>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-md-12 form-group">
                                            <label for="consiganado" class="">Embarcador(*) </label>
                                            <div class="input-group input-group-sm">

                                                <select id="fianza" name="fianza" class="form-control selectpicker" data-live-search="true">
                                                </select>
                                                <span class="input-group-btn">
                                                    <button type="button" class="btn btn-success fa fa-plus"></button>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-md-12 form-group">
                                            <label for="consiganado" class="">Notificar a(*) </label>
                                            <div class="input-group input-group-sm">

                                                <select id="fianza" name="fianza" class="form-control selectpicker" data-live-search="true">
                                                </select>
                                                <span class="input-group-btn">
                                                    <button type="button" class="btn btn-success fa fa-plus"></button>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-md-12 form-group">
                                            <label for="consiganado" class="">Agente(*) </label>
                                            <div class="input-group input-group-sm">

                                                <select id="fianza" name="fianza" class="form-control selectpicker" data-live-search="true">
                                                </select>
                                                <span class="input-group-btn">
                                                    <button type="button" class="btn btn-success fa fa-plus"></button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="col-md-2 form-group">
                                            <button type="button" class="btn btn-success"><span class="fa fa-plus"></span>
                                            </button>
                                        </div>
                                        <table class="table table-bordered table-hover table-responsive table-hover" id="Tkardex">
                                            <thead>
                                                <tr>
                                                    <th>Codigo Producto</th>
                                                    <th>Descripcion</th>
                                                    <th>Volumen</th>
                                                    <th>Peso</th>
                                                    <th>Bultos</th>
                                                    <th>Peso/Bulto</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <div class="input-group-sm">
                                                            <input type="text" name="" id="input" class="form-control" onkeyup="mayusculas(this)">
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="input-group-sm">
                                                            <textarea name="" id="input" class="form-control" rows="1"></textarea>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="" style="width: 100px;">
                                                            <input type="number" name="" id="input" class="form-control" onkeyup="mayusculas(this)">
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="" style="width: 100px;">
                                                            <input type="number" name="" id="input" class="form-control" onkeyup="mayusculas(this)">
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="" style="width: 100px;">
                                                            <input type="number" name="" id="input" class="form-control" onkeyup="mayusculas(this)">
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="input-group-sm">
                                                            <input type="text" name="" id="input" class="form-control" onkeyup="mayusculas(this)">
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div> <!-- col md 12 tabla-->
                </div> <!-- row de tabla usuarios -->
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-solid">
                        <div class=" box-header with-border">
                            <button type="button" class="btn btn-primary">Nuevo <span class="fa fa-plus"></span></button>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-body table-responsive">
                                <table class="table table-bordered table-hover table-responsive table-hover" id="tblMovBancario">
                                    <thead>
                                        <tr>
                                            <th>Acciones</th>
                                            <th>Estatus</th>
                                            <th>Codigo Referencia</th>
                                            <th>Codigo Embarque</th>
                                            <th>No. CP/MN/Referencia</th>
                                            <th>Monto</th>
                                            <th>Cheque Caja</th>
                                            <th>Fecha Operacion</th>
                                            <th>No Operacion</th>
                                            <th>Benefeciario</th>
                                            <th>Observaciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div> <!-- col md 12 tabla-->
            </div>
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
    <script src="scritps/operacionesTruck.js"></script>
    <script>
    </script>

<?php }
ob_end_flush();
?>