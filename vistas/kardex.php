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

            <form action="" method="POST" role="form">
                <div class="row">
                    <div class="col-md-4">
                        <!-- <div class="box"> -->
                        <!-- <div class="box-header with-border">
                                <h3>KARDEX</h3>
                            </div> -->
                        <div class="box box-info">
                            <div class="box-header with-border"></div>
                            <div class="box-body">
                                <div class="form-horizontal">
                                    <div class="form-group input-group-sm">
                                        <label class="col-sm-2 control-label">Codigo: </label>
                                        <input type="hidden" name="idconsignado" id="idconsignado">
                                        <div class="col-sm-5">
                                            <input type="text" class="form-control" name="nombre" id="nombre" readonly>
                                        </div>
                                    </div>

                                    <label for="consiganado" class="">Consignado* </label>
                                    <div class="input-group input-group-sm">

                                        <select id="consiganado" class="form-control selectpicker" data-live-search="true" name="consignado">
                                        </select>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-info btn-flat">Go!</button>
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
                                    <p></p>
                                    <label>Fecha Ingreso Almacen:</label>
                                    <div class="form-group input-group-sm">
                                        <div class="col-md-6">
                                            <input type="text" class="form-control" name="fechaI" id="fechaI">
                                        </div>
                                    </div>

                                </div>
                            </div>

                            <!-- </div> -->
                            <!-- /.box -->
                        </div><!-- /.col -->
                    </div><!-- /.row -->
                    <div class="row" id="contenedorKardex">
                        <div class="col-md-12">
                            <div class="box box-solid">
                                <div class=" box-header with-border">
                                    <button type="button" class="btn btn-primary" onclick="">Nuevo
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
            </form> <!-- final formulario -->
        </section><!-- /.content -->
    </div><!-- /.content-wrapper -->
    <?php
    require_once("../inc/footer.php");
    require_once("../inc/scritps.php");
    ?>
    <script type="text/javascript" src="scritps/kardex.js"></script>
<?php }
ob_end_flush();
?>