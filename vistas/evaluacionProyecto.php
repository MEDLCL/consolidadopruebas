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
        <div class="row" id="nuevaEvaluacion">
            <div class="col-md-6">
                <div class="box box-info box-solid">
                    <div class="box-header with-border text-center">EVALUACIÓN DEL PROYECTO</div>
                    <div class="box-body">
                        <div class="col-md-6">
                            <label for="codigoProyecto">Codigo Proyecto:</label>
                            <div class="form-group input-group-sm">
                                <input type="text" class="form-control" name="codigoProyecto" id="codigoProyecto"
                                    onkeyup="mayusculas(this)">
                            </div>
                        </div>
                        <div class="col-md-12"></div>
                        <div class="col-md-6 ">
                            <label for="cotizacionProyecto">Cotizacion No.:</label>
                            <div class="form-group input-group-sm">
                                <input type="text" class="form-control" name="cotizacionProyecto"
                                    id="cotizacionProyecto" onkeyup="mayusculas(this)">
                            </div>
                        </div>
                        <div class="col-md-12"></div>
                        <div class="col-md-6 ">
                            <label for="cotizacionProyecto">Fecha Estimada de Inicio:</label>
                            <div class="form-group input-group-sm">
                                <input type="text" class="form-control" name="cotizacionProyecto"
                                    id="cotizacionProyecto" onkeyup="mayusculas(this)">
                            </div>
                        </div>
                        <div class="col-md-6 ">
                            <label for="cotizacionProyecto">Fecha Estimada de Finalización:</label>
                            <div class="form-group input-group-sm">
                                <input type="text" class="form-control" name="cotizacionProyecto"
                                    id="cotizacionProyecto" onkeyup="mayusculas(this)">
                            </div>
                        </div>
                        <div class="col-md-12">
                            <label for="consiganado" class="">Cliente(*) </label>
                            <div class="input-group input-group-sm ">
                                <select id="consignado" name="consignado" class="form-control selectpicker"
                                    data-live-search="true">
                                </select>
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-info"></button>
                                </span>
                            </div>
                        </div>

                    </div> <!-- form id horizontal  -->
                </div> <!-- body box  -->
            </div>
            <div class="col-md-6">
                <div class="box box-info box-solid">
                    <div class="box-header with-border text-center">INFORMACION DE LA CARGA</div>
                    <div class="box-body">
                        <div class="form-horizontal">
                            <div class="col-md-6">
                                <label for="tipocargaProyecto" class="">Tipo Carga a Transportar(*) </label>
                                <div class="input-group input-group-sm">

                                    <select id="tipocargaProyecto" name="tipocargaProyecto"
                                        class="form-control selectpicker" data-live-search="true">
                                    </select>
                                    <span class="input-group-btn">
                                        <button type="button" class="btn btn-default"></button>
                                    </span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label for="consiganado" class="">Fianza(*) </label>
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
                            <div class="col-md-12">
                                <label for="mercaderia">Descripcion de la Mercaderia(*):</label>
                                <textarea class="form-control" rows="1" id="mercaderia" name="mercaderia"></textarea>
                            </div>

                            <div class="col-md-12 form-group"></div>
                            <div class="col-md-12">
                                <label for="permisosEspeciales">Permisos Especiales(*):</label>
                                <textarea class="form-control" rows="1" id="permisosEspeciales"
                                    name="permisosEspeciales"></textarea>
                            </div>
                            <div class="col-md-12 form-group"></div>
                            <div class="col-md-6">
                                <label for="pesoPromedio">Peso Promedio(*)</label>
                                <div class="input-group-sm ">
                                    <input type="number" class="form-control" name="pesoPromedio" id="pesoPromedio"
                                        onkeyup="mayusculas(this)">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label for="medidaPeso" class="">Medidas(*) </label>
                                <div class="input-group input-group-sm">
                                    <select id="medidaPeso" name="medidaPeso" class="form-control selectpicker"
                                        data-live-search="true">
                                    </select>
                                    <span class="input-group-btn">
                                        <button type="button" class="btn btn-default"></button>
                                    </span>
                                </div>
                            </div>
                        </div> <!-- form id horizontal  -->
                    </div> <!-- body box  -->
                </div><!-- /.col -->
            </div><!-- /.col row -->

            <div class="col-md-6">
                <div class="box box-info box-solid" id="">
                    <!--  formulario para detalle de almacen -->
                    <div class="box-header with-border text-center">TIPO DE UNIDAD DE TRASPORTE</div>
                    <div class="box-body">

                        <div class="col-md-6">
                            <label for="">Cant. de Unidades(*)</label>
                            <div class="input-group-sm">
                                <input type="number" class="form-control" name="pesoPromedio" id="pesoPromedio"
                                    onkeyup="mayusculas(this)">
                            </div>
                        </div>

                        <div class="col-md-6">
                            <label for="tamanoUnidades" class="">Tamaño de las Unidades(*) </label>
                            <div class="input-group input-group-sm">
                                <select id="tamanoUnidades" name="tamanoUnidades" class="form-control selectpicker"
                                    data-live-search="true">
                                </select>
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-default"></button>
                                </span>
                            </div>
                        </div>
                        <div class="col-md-12 form-group"></div>
                        <div class="col-md-12">
                            <label for="caracEquipo">Caracteristicas del Equipo(*):</label>
                            <textarea class="form-control" rows="2" id="caracEquipo" name="caracEquipo"></textarea>
                        </div>
                        <div class="col-md-12 form-group"></div>
                        <div class="col-md-6">
                            <label for="cajillaSeguridad" class="">Cajilla de Seguridad(*) </label>
                            <div class="input-group input-group-sm">
                                <select id="cajillaSeguridad" name="cajillaSeguridad" class="form-control selectpicker"
                                    data-live-search="true">
                                </select>
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-default"></button>
                                </span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="">Temperatura Promedio(*)</label>
                            <div class="input-group-sm">
                                <input type="number" class="form-control" name="temperaturaPro" id="temperaturaPro"
                                    onkeyup="mayusculas(this)">
                            </div>
                        </div>
                        <div class="col-md-12 form-group"></div>
                        <div class="col-md-4">
                            <label for="tipoCamion" class="">Tipo Camiones(*) </label>
                            <div class="input-group input-group-sm">
                                <select id="tipoCamion" name="tipoCamion" class="form-control selectpicker"
                                    data-live-search="true">
                                </select>
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-default"></button>
                                </span>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <label for="tipoCamion" class="">Marchamo(*) </label>
                            <div class="input-group input-group-sm">
                                <select id="tipoCamion" name="tipoCamion" class="form-control selectpicker"
                                    data-live-search="true">
                                </select>
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-default"></button>
                                </span>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <label for="tipoCamion" class="">GPS(*) </label>
                            <div class="input-group input-group-sm">
                                <select id="tipoCamion" name="tipoCamion" class="form-control selectpicker"
                                    data-live-search="true">
                                </select>
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-default"></button>
                                </span>
                            </div>
                        </div>
                        <div class="col-md-12 form-group"></div>
                        <div class="col-md-12">
                            <label for="comentarioAdicional">Comentario Adicional(*):</label>
                            <textarea class="form-control" rows="2" id="comentarioAdicional"
                                name="comentarioAdicional"></textarea>
                        </div>
                    </div> <!-- body box  -->
                    <!-- /.box -->
                </div><!-- /.box -->

            </div> <!-- col md 8 tabla-->

            <div class="col-md-6">
                <div class="box box-info box-solid" id="">
                    <!--  formulario para detalle de almacen -->
                    <div class="box-header with-border text-center">DATOS DE LA OPERACION</div>
                    <div class="box-body">
                        <div class="col-md-12 form-group">
                            <label for="canalDistribucion" class="">Canal de Distribución(*) </label>
                            <div class="input-group input-group-sm">
                                <select id="canalDistribucion" name="canalDistribucion"
                                    class="form-control selectpicker" data-live-search="true">
                                </select>
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-default"></button>
                                </span>
                            </div>
                        </div>

                        <div class="col-md-12 form-group">
                            <label for="lugarCarga">Lugar de Carga(*):</label>
                            <textarea class="form-control" rows="1" id="lugarCarga" name="lugarCarga"></textarea>
                        </div>

                        
                        <div class="col-md-12 form-group">
                            <label for="lugarDescarga">Lugar de Descarga(*):</label>
                            <textarea class="form-control" rows="1" id="lugarDescarga" name="lugarDescarga"></textarea>
                        </div>

                        <div class="col-md-12 form-group">
                            <label for="entregasPromedio">Prom. De entregas realizadas por viaje:</label>
                            <div class="input-group-sm">
                                <input type="text" class="form-control" name="entregasPromedio" id="entregasPromedio"
                                    onkeyup="mayusculas(this)">
                            </div>
                        </div>

                        <div class="col-md-12 form-group">
                            <label for="kilometrosPromedio">Prom. de kilómetros recorridos:</label>
                            <div class="input-group-sm">
                                <input type="text" class="form-control" name="kilometrosPromedio"
                                    id="kilometrosPromedio" onkeyup="mayusculas(this)">
                            </div>
                        </div>
                        <div class="col-md-6 form-group">
                            <label for="seCarga" class="">Se Carga:(*) </label>
                            <div class="input-group input-group-sm">
                                <select id="seCarga" name="seCarga" class="form-control selectpicker"
                                    data-live-search="true">
                                </select>
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-default"></button>
                                </span>
                            </div>
                        </div>
                        <div class="col-md-6 form-group">
                            <label for="seDescarga" class="">Se Descarga:(*) </label>
                            <div class="input-group input-group-sm">
                                <select id="seDescarga" name="seDescarga" class="form-control selectpicker"
                                    data-live-search="true">
                                </select>
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-default"></button>
                                </span>
                            </div>
                        </div>

                        <div class="col-md-6 form-group">
                            <label for="manejoEfectivo" class="">Manejo de Efectivo(*) </label>
                            <div class="input-group input-group-sm">
                                <select id="manejoEfectivo" name="manejoEfectivo" class="form-control selectpicker"
                                    data-live-search="true">
                                </select>
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-default"></button>
                                </span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="">Frecuencia de viajes:</label>
                            <div class="input-group-sm">
                                <input type="text" class="form-control" name="temperaturaPro" id="temperaturaPro"
                                    onkeyup="mayusculas(this)">
                            </div>
                        </div>
                    </div> <!-- body box  -->
                    <!-- /.box -->
                </div><!-- /.box -->
            </div> <!-- col md 8 tabla-->
            <div class="col-md-6">
                <div class="box box-info box-solid" id="">
                    <!--  formulario para detalle de almacen -->
                    <div class="box-header with-border text-center">TARIFAS PROPUESTAS</div>
                    <div class="box-body">
                        <div class="col-md-6 form-group">
                            <label for="canalDistribucion" class="">Unidad(*) </label>
                            <div class="input-group input-group-sm">
                                <select id="canalDistribucion" name="canalDistribucion"
                                    class="form-control selectpicker" data-live-search="true">
                                </select>
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-default"></button>
                                </span>
                            </div>
                        </div>

                        <div class="col-md-6 form-group">
                            <label for="canalDistribucion" class="">Fianza(*) </label>
                            <div class="input-group input-group-sm">
                                <select id="canalDistribucion" name="canalDistribucion"
                                    class="form-control selectpicker" data-live-search="true">
                                </select>
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-default"></button>
                                </span>
                            </div>
                        </div>
                        
                        <div class="col-md-12 form-group">
                            <label for="canalDistribucion" class="">Origen(*) </label>
                            <div class="input-group input-group-sm">
                                <select id="canalDistribucion" name="canalDistribucion"
                                    class="form-control selectpicker" data-live-search="true">
                                </select>
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-primary fa fa-plus"></button>
                                </span>
                            </div>
                        </div>
                        
                        <div class="col-md-12 form-group">
                            <label for="canalDistribucion" class="">Destino(*) </label>
                            <div class="input-group input-group-sm">
                                <select id="canalDistribucion" name="canalDistribucion"
                                    class="form-control selectpicker" data-live-search="true">
                                </select>
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-primary fa fa-plus"></button>
                                </span>
                            </div>
                        </div>
                        
                        <div class="col-md-12 form-group">
                            <button type="button" class="btn btn-primary fa fa-plus"></button>
                        </div>
                        
                        <div class="col-md-12 ">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>Unidad</th>
                                        <th>Fianza</th>
                                        <th>Origen</th>
                                        <th>Destino</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>

                        </div>
                    </div> <!-- body box  -->
                    <!-- /.box -->
                </div><!-- /.box -->
            </div> <!-- col md 8 tabla-->
            <div class="col-md-6">
                <div class="box box-info box-solid" id="">
                    <!--  formulario para detalle de almacen -->
                    0
                    <div class="box-body">
                        <div class="col-md-12 form-group">
                            <label for="canalDistribucion" class="">Descripcion(*) </label>
                            <div class="input-group input-group-sm">
                                <select id="canalDistribucion" name="canalDistribucion"
                                    class="form-control selectpicker" data-live-search="true">
                                </select>
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-primary fa fa-plus"></button>
                                </span>
                            </div>
                        </div>
                        
                        <div class="col-md-12 form-group">
                            <label for="canalDistribucion" class="">Origen(*) </label>
                            <div class="input-group input-group-sm">
                                <select id="canalDistribucion" name="canalDistribucion"
                                    class="form-control selectpicker" data-live-search="true">
                                </select>
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-primary fa fa-plus"></button>
                                </span>
                            </div>
                        </div>
                        
                        <div class="col-md-12 form-group">
                            <label for="canalDistribucion" class="">Destino(*) </label>
                            <div class="input-group input-group-sm">
                                <select id="canalDistribucion" name="canalDistribucion"
                                    class="form-control selectpicker" data-live-search="true">
                                </select>
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-primary fa fa-plus"></button>
                                </span>
                            </div>
                        </div>
                        
                        <div class="col-md-6 form-group">
                            <label for="canalDistribucion" class="">Tipo de Carga(*) </label>
                            <div class="input-group input-group-sm">
                                <select id="canalDistribucion" name="canalDistribucion"
                                    class="form-control selectpicker" data-live-search="true">
                                </select>
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-default"></button>
                                </span>
                            </div>
                        </div>

                        
                        <div class="col-md-12 form-group">
                            <button type="button" class="btn btn-primary fa fa-plus"></button>
                        </div>
                        <div class="col-md-12 form-group"></div>
                        <div class="col-md-12 ">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>Descripcion</th>   
                                        <th>Origen</th>
                                        <th>Destino</th>
                                        <th>Tipo Carga</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>

                        </div>
                    </div> <!-- body box  -->
                    <!-- /.box -->
                </div><!-- /.box -->
            </div> <!-- col md 8 tabla-->
            
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary box-solid" id="">
                    <!--  formulario para detalle de almacen -->
                    <div class="box-header with-border text-center"></div>
                    <div class="box-body">
                        <div class="col-md-1">
                            <button type="button" class="btn btn-success">Grabar <span
                                    class="fa fa-floppy-o"></span></button>
                        </div>
                        <div class="col-md-1 col-md-offset-1">
                            <button type="button" class="btn btn-danger">Cancelar <span
                                    class="fa fa-close"></span></button>
                        </div>
                    </div> <!-- body box  -->
                    <!-- /.box -->
                </div><!-- /.box -->
            </div> <!-- col md 12 tabla-->
        </div>


        <div class="row" id="listadoEvalucaiones">
            <div class="col-md-12">
                <div class="box  box-solid">
                    <div class=" box-header with-border">
                        <button type="button" class="btn btn-primary" onclick="ocultaAlma(true)">Nuevo Proyecto<span
                                class="fa  fa-plus"></span>
                        </button>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-body table-responsive">
                            <table class="table table-bordered table-hover table-responsive table-hover" id="Tkardex">
                                <thead>
                                    <tr>
                                        <th>Acciones</th>
                                        <th>Estatus</th>
                                        <th>Codigo P.</th>
                                        <th>No. Cotizacion</th>
                                        <th>Inicio</th>
                                        <th>Finalizacion</th>
                                        <th>Cliente</th>
                                        <th>Tipo Carga</th>
                                        <th>Fianza</th>
                                        <th>Mercaderia</th>
                                        <th>Permisos</th>
                                        <th>Peso</th>
                                        <th>Cant. Unidades</th>
                                        <th>Tamaño Unidades</th>
                                        <th>Caracteristicas</th>
                                        <th>Seguridad</th>
                                        <th>Temperatura</th>
                                        <th>Tipo Camion</th>
                                        <th>Marchamo</th>
                                        <th>GPS</th>
                                        <th>Comentarios</th>
                                        <th>Canal Dis.</th>
                                        <th>Lugar Carga</th>
                                        <th>Lugar Descarga</th>
                                        
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