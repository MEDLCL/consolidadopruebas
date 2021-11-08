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
                    <div class="box-header with-border text-center">VENTA NACIONAL/INTERNACIONAL</div>
                    <div class="box-body">
                        <div class="col-md-3 col-md-offset-1">
                            <label for="consiganado" class="">Tipo Venta(*) </label>
                            <div class="input-group input-group-sm">

                                <select id="fianza" name="fianza" class="form-control selectpicker"
                                    data-live-search="true">
                                </select>
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-default"></button>
                                </span>
                            </div>
                        </div>
                        <div class="col-md-3 col-md-offset-3">
                            <label for="" class="">Codigo Venta(*)</label>
                            <div class="input-group-sm">
                                <input type="text" name="" id="input" class="form-control" onkeyup="mayusculas(this)">
                            </div>
                        </div>

                        <div class="col-md-12 form-group "></div>
                        <div class="col-md-6 col-md-offset-1">
                            <label for="consiganado" class="">Cliente(*) </label>
                            <div class="input-group input-group-sm">

                                <select id="fianza" name="fianza" class="form-control selectpicker"
                                    data-live-search="true">
                                </select>
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-default"></button>
                                </span>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label for="consiganado" class="">Proyectos(*) </label>
                            <div class="input-group input-group-sm">

                                <select id="fianza" name="fianza" class="form-control selectpicker"
                                    data-live-search="true">
                                </select>
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-default"></button>
                                </span>
                            </div>
                        </div>
                        <div class="col-md-12 form-group"></div>
                        <div class="col-md-9 col-md-offset-1">
                            <label for="caracEquipo">Observaciones(*):</label>
                            <textarea class="form-control" rows="2" id="caracEquipo" name="caracEquipo"></textarea>
                        </div>
                    </div> <!-- body box  -->
                    <!-- /.box -->
                </div><!-- /.box -->
            </div> <!-- col md 12 tabla-->
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="box box-info box-solid">
                    <div class=" box-header with-border text-center">
                        SERVICIOS ADICIONALES
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-body table-responsive">
                            <table class="table table-bordered table-hover table-responsive table-hover" id="Tkardex">
                                <thead>
                                    <tr>
                                        <th>Servicio Adicional</th>
                                        <th>Tarifa Venta</th>
                                        <th>Tarifa Costo</th>
                                        <th>Valor Factura</th>
                                        <th>Ruta</th>
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
        <div class="row" id="listadoEvalucaiones">
            <div class="col-md-12">
                <div class="box box-info box-solid">
                    <div class=" box-header with-border text-center">
                        DETALLES DE POSICIONAMIENTO
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-body table-responsive">
                            <table class="table table-bordered table-hover table-responsive table-hover" id="Tkardex">
                                <thead>
                                    <tr>
                                        <th>Ruta</th>
                                        <th>Tarifa Venta</th>
                                        <th>Tarifa Costo</th>
                                        <th>No. Ujidades</th>
                                        <th>Total Venta</th>
                                        <th>Total Costo</th>
                                        <th>Hora Posicionamiento</th>
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
                    <div class=" box-header with-border text-center">
                        DATOS DE TRIPULACION
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-body table-responsive">
                            <table class="table table-bordered table-hover table-responsive table-hover" id="Tkardex">
                                <thead>
                                    <tr>
                                        <th>Botas</th>
                                        <th>Chaleco</th>
                                        <th>Lentes</th>
                                        <th>Guantes</th>
                                        <th>Mascarilla</th>
                                        <th>Careta</th>
                                        <th>Otros</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <th>
                                        <div class="form-check">
                                            <input id="liberado" class="form-check-input" type="checkbox"
                                                name="liberado" value=1>
                                        </div>
                                    </th>
                                    <th>
                                        <div class="form-check">
                                            <input id="liberado" class="form-check-input" type="checkbox"
                                                name="liberado" value=1>
                                        </div>
                                    </th>
                                    <th>
                                        <div class="form-check">
                                            <input id="liberado" class="form-check-input" type="checkbox"
                                                name="liberado" value=1>
                                        </div>
                                    </th>
                                    <th>
                                        <div class="form-check">
                                            <input id="liberado" class="form-check-input" type="checkbox"
                                                name="liberado" value=1>
                                        </div>
                                    </th>
                                    <th>
                                        <div class="form-check">
                                            <input id="liberado" class="form-check-input" type="checkbox"
                                                name="liberado" value=1>
                                        </div>
                                    </th>
                                    <th>
                                        <div class="form-check">
                                            <input id="liberado" class="form-check-input" type="checkbox"
                                                name="liberado" value=1>
                                        </div>
                                    </th>
                                    <th>
                                        <div class="input-group-sm">
                                            <input type="text" name="" id="input" class="form-control"
                                                onkeyup="mayusculas(this)">
                                        </div>
                                    </th>
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>
            </div> <!-- col md 12 tabla-->
        </div> <!-- row de tabla usuarios -->
        <div class="row" id="">
            <div class="col-md-12">
                <div class="box box-info box-solid">
                    <div class=" box-header with-border text-center">
                        CREACION DE DOCUMENTACION
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-body table-responsive">
                            <div class="col-md-6">
                                <div class="col-md-12 form-group">
                                    <label for="consiganado" class="">Consignatario(*) </label>
                                    <div class="input-group input-group-sm">

                                        <select id="fianza" name="fianza" class="form-control selectpicker"
                                            data-live-search="true">
                                        </select>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-success fa fa-plus"></button>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-12 form-group">
                                    <label for="consiganado" class="">Embarcador(*) </label>
                                    <div class="input-group input-group-sm">

                                        <select id="fianza" name="fianza" class="form-control selectpicker"
                                            data-live-search="true">
                                        </select>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-success fa fa-plus"></button>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-12 form-group">
                                    <label for="consiganado" class="">Notificar a(*) </label>
                                    <div class="input-group input-group-sm">

                                        <select id="fianza" name="fianza" class="form-control selectpicker"
                                            data-live-search="true">
                                        </select>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-success fa fa-plus"></button>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-12 form-group">
                                    <label for="consiganado" class="">Agente(*) </label>
                                    <div class="input-group input-group-sm">

                                        <select id="fianza" name="fianza" class="form-control selectpicker"
                                            data-live-search="true">
                                        </select>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-success fa fa-plus"></button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="col-md-2 form-group">
                                <button type="button" class="btn btn-success"><span class="fa fa-plus"></span> </button>
                                </div>
                                <table class="table table-bordered table-hover table-responsive table-hover"
                                    id="Tkardex">
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
                                            <td><div class="input-group-sm">
                                                <input type="text" name="" id="input" class="form-control"
                                                    onkeyup="mayusculas(this)">
                                            </div></td>
                                            <td><div class="input-group-sm">        
                                                <textarea name="" id="input" class="form-control" rows="1" ></textarea>
                                            </div></td>
                                            <td><div class="" style="width: 100px;">
                                                <input type="number" name="" id="input" class="form-control"
                                                    onkeyup="mayusculas(this)">
                                            </div></td>
                                            <td> <div class="" style="width: 100px;">
                                                <input type="number" name="" id="input" class="form-control"
                                                    onkeyup="mayusculas(this)">
                                            </div></td>
                                            <td><div class="" style="width: 100px;">
                                                <input type="number" name="" id="input" class="form-control"
                                                    onkeyup="mayusculas(this)">
                                            </div></td>
                                            <td><div class="input-group-sm">
                                                <input type="text" name="" id="input" class="form-control"
                                                    onkeyup="mayusculas(this)">
                                            </div></td>
                                        </tr>                                           
                                    </tbody>
                                </table>
                            </div>
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