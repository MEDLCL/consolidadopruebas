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
                    <div class="box-header with-border text-center">LIQUIDACIÓN DE EMBARQUE/ SERVICIOS O COSTOS ADICIONALES/ REPORTE A CLIENTE DE COBRO FINAL</div>
                    <div class="box-body">
                        <div class="col-md-3">
                            <label for="" class="">Codigo de Referencia(*)</label>
                            <div class="input-group-sm">
                                <input type="text" name="" id="input" class="form-control" onkeyup="mayusculas(this)">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label for="" class="">Codigo de Embarque(*)</label>
                            <div class="input-group-sm">
                                <input type="text" name="" id="input" class="form-control" onkeyup="mayusculas(this)">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label for="" class="">Cliente(*)</label>
                            <div class="input-group-sm">
                                <input type="text" name="" id="input" class="form-control" onkeyup="mayusculas(this)">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label for="" class="">Canal de Distribucion(*)</label>
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
                                    </tr>
                                </thead>
                                <tbody>

                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
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
                                <table class="table table-bordered table-hover table-responsive table-hover"
                                    id="Tkardex">
                                    <thead>
                                        <tr>
                                            <th>Servicios Adicionales</th>
                                            <th>Tarifa Venta</th>
                                            <th>Piloto</th>
                                            <th>Tarifa Costo</th>
                                            <th>Cantidad</th>
                                            <th>Proveedor TC</th>
                                            <th>Certificado de Seguro</th>
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
                                <table class="table table-bordered table-hover table-responsive table-hover"
                                    id="Tkardex">
                                    <thead>
                                        <tr>
                                            <th>Descripcion</th>
                                            <th>Tarifa Venta</th>
                                            <th>Tarifa Costo</th>
                                            <th>Placa</th>
                                            <th>Comentario</th>
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
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="box box-solid">
                    <div class=" box-header with-border">
                        <button type="button" class="btn btn-primary">Nuevo <span class="fa fa-plus"></span></button>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-body table-responsive">
                            <table class="table table-bordered table-hover table-responsive table-hover"
                                id="tblMovBancario">
                                <thead>
                                    <tr>
                                        <th>Acciones</th>
                                        <th>Estatus</th>
                                        <th>Codigo Referencia</th>
                                        <th>Codigo Embarque</th>
                                        <th>No. CP/MN/Referencia</th>
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
<script src="scritps/empresa.js"></script>
<script>
</script>

<?php }
ob_end_flush();
?>