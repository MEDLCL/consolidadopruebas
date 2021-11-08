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

        <div class="row">
            <div class="col-md-12">
                <div class="box box-info box-solid" id="">
                    <!--  formulario para detalle de almacen -->
                    <div class="box-header with-border text-center">TARIFARIO</div>
                    <div class="box-body">
                        <div class="col-md-4">
                            <label for="" class="">Codigo del Proyecto(*)</label>
                            <div class="input-group-sm">
                                <input type="text" name="" id="input" class="form-control" onkeyup="mayusculas(this)">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <label for="" class="">.</label>
                            <div class="input-group-sm"> 
                                <button type="button" class="btn btn-primary"><span class="fa fa-search-plus"></span>
                                </button>
                            </div>
                        </div>
                        
                    </div> <!-- body box  -->
                    <!-- /.box -->
                </div><!-- /.box -->
            </div> <!-- col md 12 tabla-->
        </div>
        <div class="row" id="listadoEvalucaiones">
            <div class="col-md-12">
                <div class="box box-info box-solid">
                    <div class=" box-header with-border">
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-body table-responsive">
                            <table class="table table-bordered table-hover table-responsive table-hover" id="Tkardex">
                                <thead>
                                    <tr>
                                        <th>Origen</th>
                                        <th>Destino</th>
                                        <th>Tipo Unidad</th>
                                        <th>Piloto</th>
                                        <th>Ayudante</th>
                                        <th>Tarifa Venta</th>
                                        <th>Tarifa Costo</th>
                                        <th>Validez</th>
                                        <th>Tipo Carga</th>
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

        <div class="row" id="listadoEvalucaiones">
            <div class="col-md-12">
                <div class="box box-info box-solid">
                    <div class=" box-header with-border">
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-body table-responsive">
                            <table class="table table-bordered table-hover table-responsive table-hover" id="Tkardex">
                                <thead>
                                    <tr>
                                        <th>Servicio Adicional</th>
                                        <th>Origen</th>
                                        <th>Destino</th>
                                        <th>Tarifa Venta</th>
                                        <th>Tarifa Costo</th>
                                        <th>Validez</th>
                                        <th>Tipo Carga</th>
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
<script>
</script>

<?php }
ob_end_flush();
?>