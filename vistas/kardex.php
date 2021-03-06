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
    include_once ("../vistas/modal/empaque.php");
    include_once ("../vistas/modal/modalempresa.php");
?>
            <div class="row" id="Almacen">
                <div class="col-md-4">
                    <form action="" role="form" id="formAlmacen">
                        <!-- <div class="box"> -->
                        <!-- <div class="box-header with-border">
                                <h3>KARDEX</h3>
                            </div> -->
                        <div class="box box-info">
                            <div class="box-header with-border"></div>
                            <div class="box-body">
                                <div class="form-horizontal">
                                    <label class="">Codigo: </label>
                                    <div class="form-group input-group-sm">
                                        <div class="col-sm-5">
                                            <input type="text" class="form-control" name="codigo" id="codigo" readonly>
                                            <input type="hidden" name="idAlmacen" name="idAlmacen">
                                        </div>
                                    </div>

                                    <label for="consiganado" class="">Consignado* </label>
                                    <div class="input-group input-group-sm">

                                        <select id="consignado" name="consignado" class="form-control selectpicker" data-live-search="true" >
                                        </select>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-info fa fa-plus" data-toggle="modal" data-target="#modalempresa" onclick="nuevoConsignado()"></button>
                                        </span>
                                    </div>
                                    <br>
                                    <label for="contenedor">Contenedor/Placa: </label>
                                    <div class="form-group input-group-sm">
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" name="contenedor" id="contenedor">
                                        </div>
                                    </div>

                                    <label>Poliza:</label>
                                    <div class="form-group input-group-sm">
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" name="poliza" id="poliza">
                                        </div>
                                    </div>

                                    <label>Referencia:</label>
                                    <div class="form-group input-group-sm">
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" name="referencia" id="referencia">
                                        </div>
                                    </div>

                                    <div class="form-group">

                                        <div class="col-sm-4">
                                            <div class="input-group">
                                                <label>Peso Total:</label>
                                                <input type="number" class="form-control" name="pesoT" id="pesoT">
                                            </div>
                                            <!-- /input-group -->
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="input-group">
                                                <label>Vol. Total:</label>
                                                <input type="number" class="form-control" name="volumenT" id="volumenT">
                                            </div>
                                            <!-- /input-group -->
                                        </div>

                                        <div class="col-sm-4">
                                            <div class="input-group">
                                                <label>Bultos T.:</label>
                                                <input type="number" class="form-control" name="bultosT" id="bultosT">
                                            </div>
                                            <!-- /input-group -->
                                        </div>
                                    </div>
                                    <div class="form-group">


                                        <div class="col-sm-8">
                                            <label for="" class="">Fecha Ingreso Almacen</label>
                                            <div class="input-group date">
                                                <div class="input-group-addon">
                                                    <i class="fa fa-calendar"></i>
                                                </div>
                                                <input type="text" class="form-control pull-right" id="fechaI" name="fechaI">
                                            </div>
                                        </div>
                                    </div>
                                    <!-- <div class="form-group">
                                        <label for="my-input">Text</label>
                                        <input id="my-input" class="form-control" type="text" name="">
                                    </div>
                                    <div class="input-group date">
                                        <div class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                        <input type="text" class="form-control pull-right" id="fechaI">
                                    </div> -->

                                    <div class="form-group">
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <button class="btn btn-primary" type="button" onclick="grabarAlmacen()" id="grabaru">Graba
                                                <span class="fa fa-floppy-o"></span>
                                            </button>
                                            <button class="btn btn-danger" type="button" onclick="ocultaAlma(false)" id="cancelarA">Cancelar
                                                <span class="fa fa-close"></span>
                                            </button>
                                        </div>
                                    </div>
                                </div> <!-- form id horizontal  -->
                            </div> <!-- body box  -->
                    </form><!--  form almacen -->
                </div><!-- /.col -->
            </div><!-- /.col row -->

            <div class="col-md-8">
                <div class="box box-info" id="datosDetalleA">
                    <!--  formulario para detalle de almacen -->
                    <div class="box-header with-border"></div>
                    <div class="box-body">
                        <form class="" id="formAlmacenDetalle">
                            <div class="form-group col-md-12">
                                <label for="consiganado" class="">Cliente* </label>
                                <div class="input-group input-group-sm">
                                    <select id="cliente" name="cliente" class="form-control selectpicker" data-live-search="true" >
                                    </select>
                                    <span class="input-group-btn">
                                        <button type="button" class="btn btn-info fa fa-plus"  onclick="nuevoCliente()"></button>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <label>No. HBL:</label>
                                <input type="hidden" name="iddetallealmacen" id="iddetallealmacen">
                                <input type="text" class="form-control" name="nohbl" id="nohbl" required>
                            </div>

                            <div class="form-group col-md-6">
                                <label>Peso(*)</label>
                                <input type="number" class="form-control" name="peso" id="peso">
                            </div>
                            <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <label>Ubicacion</label>
                                <input type="text" class="form-control" name="ubicacion" id="ubicacion">
                            </div>

                            <div class="form-group col-md-6">
                                <label>Volumen(*)</label>
                                <input type="number" class="form-control" name="volumen" id="volumen">
                            </div>

                            <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <label>DUT</label>
                                <input type="text" class="form-control" name="dut" id="dut">
                            </div>

                            <div class="form-group col-md-6">
                                <label>Bultos(*)</label>
                                <input type="number" class="form-control" name="bultos" id="bultos">
                            </div>

                            <div class="form-group col-md-6">
                                <label class="">Embalaje (*) </label>
                                <div class="input-group input-group-sm">
                                    <select id="embalajeD" name="embalajeD" class="form-control selectpicker" data-live-search="true">
                                    </select>
                                    <span class="input-group-btn">
                                        <button type="button" class="btn btn-info fa fa-plus" data-toggle="modal" data-target="#modalEmaqpue" onclick="limpiaEmpaque()"></button>
                                    </span>
                                </div>
                            </div>
                            <div class="form-group col-md-6">
                            </div>
                            <div class="form-group col-md-12">
                                <div class="form-check">
                                    <input id="liberado" class="form-check-input" type="checkbox" name="liberado">
                                    <label for="liberado" class="form-check-label">Liberado</label>
                                </div>
                            </div>

                            <div class="form-group col-lg-3 col-md-3 col-sm-3 col-xs-3">
                                <label>Resa</label>
                                <input type="text" class="form-control" name="resa" id="resa">
                            </div>
                            <div class="form-group col-lg-3 col-md-3 col-sm-3 col-xs-3">
                                <label>DTI</label>
                                <input type="text" class="form-control" name="dti" id="dti">
                            </div>
                            <div class="form-group col-lg-3 col-md-3 col-sm-3 col-xs-3">
                                <label>No. Cancel</label>
                                <input type="text" class="form-control" name="ncancel" id="ncancel">
                            </div>
                            <div class="form-group col-lg-3 col-md-3 col-sm-3 col-xs-3">
                                <label>No. Orden</label>
                                <input type="text" class="form-control" name="norden" id="norden">
                            </div>

                            <div class="form-group col-md-6">
                                <label for="comment">Mercaderia(*):</label>
                                <textarea class="form-control" rows="3" id="mercaderia" name="mercaderia"></textarea>
                            </div>

                            
                            <div class="form-group col-md-6">
                                <label for="observaciones">Observaciones:</label>
                                <textarea class="form-control" rows="3" id="observaciones" name="observaciones"></textarea>
                            </div>

                            <fieldset class="col-md-12">
                                <legend></legend>
                                <div class="form-group">
                                    <div class="col-md-offset-1 col-md-11">
                                        <button class="btn btn-primary" type="button" onclick="" id="grabaD">Graba
                                            <span class="fa fa-floppy-o"></span>
                                        </button>
                                        <button class="btn btn-danger" type="button" onclick="nuevoDetalle('false')" id="cancelarD">Cancelar
                                            <span class="fa fa-close"></span>
                                        </button>
                                    </div>
                                </div>
                            </fieldset>

                        </form> <!-- form  -->
                    </div> <!-- body box  -->
                    <!-- /.box -->
                </div><!-- /.box -->
                <div id="tablaDetalleAlmacen">
                    <div class="box box-solid">
                        <div class=" box-header with-border">
                            <button type="button" class="btn btn-primary" onclick="nuevoDetalle('true')">Nuevo
                                <span class="fa  fa-plus"></span>
                            </button>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-body table-responsive">

                                <table class="table table-bordered table-hover table-responsive table-hover" id="Tkardex">
                                    <thead>
                                        <tr>
                                            <th>Acciones</th>
                                            <th>Estado</th>
                                            <th>Cliente</th>
                                            <th>No. HBL</th>
                                            <th>Peso</th>
                                            <th>Volumen</th>
                                            <th>Bultos</th>
                                            <th>Ubicacion</th>
                                            <th>Embalaje</th>
                                            <th>Linea</th>
                                            <th>No. Resa</th>
                                            <th>Mercaderia</th>
                                            <th>Observaciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <div class="btn-group">
                                                    <button type="button" class="btn btn-success dropdown-toggle btn-sm" data-toggle="dropdown">
                                                        <span class="fa fa-cog"></span>
                                                        Acciones
                                                        <span class="caret"></span>
                                                        <span class="sr-only">Desplegar menú</span>
                                                    </button>

                                                    <ul class="dropdown-menu" role="menu">
                                                        <li><a href="#" class="fa fa-pencil"> Editar</a></li>
                                                        <li><a href="#" class="fa fa-trash"> Elimnar</a></li>
                                                    </ul>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div> <!-- col md 8 tabla-->
    </div><!--  row  -->
    <div class="row" id="contenedorKardex">
        <div class="col-md-12">
            <div class="box box-solid">
                <div class=" box-header with-border">
                    <button type="button" class="btn btn-primary" onclick="ocultaAlma(true)">Nuevo
                        <span class="fa  fa-plus"></span>
                    </button>
                </div>
                <div class="panel panel-default">
                    <div class="panel-body table-responsive">
                        <table class="table table-bordered table-hover table-responsive table-hover" id="Tkardex">
                            <thead>
                                <tr>
                                    <th>Acciones</th>
                                    <th>Estatus</th>
                                    <th>Año</th>
                                    <th>Codigo</th>
                                    <th>Consignado</th>
                                    <th>Contenedor</th>
                                    <th>Poliza</th>
                                    <th>Referencia</th>
                                    <th>Fecha Ingreso</th>
                                    <th>Cliente Final</th>
                                    <th>Cant. Clientes</th>
                                    <th>No. HBL</th>
                                    <th>Mercaderia</th>
                                    <th>Peso</th>
                                    <th>Volumen</th>
                                    <th>Bultos</th>
                                    <th>Ubicacion</th>
                                    <th>Linea</th>
                                    <th>No. Resa</th>
                                    <th>Fecha Retiro</th>
                                    <th>Dias Almacenaje</th>
                                    <th>Dias Libres Almacenaje</th>
                                    <th>Almacenaje</th>
                                    <th>Gastos</th>
                                    <th>Cif</th>
                                    <th>Impuestos</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-success dropdown-toggle btn-sm" data-toggle="dropdown">
                                                <span class="fa fa-cog"></span>
                                                Acciones
                                                <span class="caret"></span>
                                                <span class="sr-only">Desplegar menú</span>
                                            </button>

                                            <ul class="dropdown-menu" role="menu">
                                                <li><a href="#">Acción #1</a></li>
                                                <li><a href="#">Acción #2</a></li>
                                                <li><a href="#">Acción #3</a></li>
                                                <li class="divider"></li>
                                                <li><a href="#">Acción #4</a></li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
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
    <script type="text/javascript" src="scritps/kardex.js"></script>
 
<?php }
ob_end_flush();
?>