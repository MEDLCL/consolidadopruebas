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
                        <div class="box">
                            <div class="box-header with-border">
                                <h3>KARDEX</h3>
                            </div>
                            <div class="panel panel-primary">
                                <div class="panel-heading"></div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="form-group col-md-6">
                                            <label>Codigo:</label>
                                            <input type="hidden" name="idconsignado" id="idconsignado">
                                            <input type="text" class="form-control" name="nombre" id="nombre" readonly>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="">Consignado*</label>
                                                <table class="" width="100%">
                                                    <tbody>
                                                        <tr class="">
                                                            <td width="90%">
                                                                <select id="consiganado" class="input-control selectpicker form-control " data-live-search="true" name="">
                                                                    <option>Text</option>
                                                                </select></td>
                                                            <td>
                                                                <button class="btn btn-info">
                                                                    <span class="fa fa-cog"></span>
                                                                </button>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div><!-- /.box -->
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