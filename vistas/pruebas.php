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
                    <div class="col-md-6">
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
<<<<<<< HEAD
                                                                <select id="my-select" class="input-control selectpicker form-control " data-live-search="true" name="">
=======
                                                                <select id="consiganado" class="input-control selectpicker form-control " data-live-search="true" name="">
>>>>>>> b1b90f0d96dadbd0c174d1c5192ff57089351795
                                                                    <option>Text</option>
                                                                </select>
                                                            </td>
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
                                    <div class="row">
                                        <div class="form-group col-md-12">
                                            <label for="contenedor" class="control-label">Contenedor/Placa</label>
                                            <div class="col-md-12">
                                                <input type="email" class="form-control" id="contenedor" placeholder="contenedor">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="input-group input-sm">
                                            <label for="exampleInputEmail2">Email address</label>
                                            <input type="email" class="form-control" id="exampleInputEmail2" placeholder="Enter email">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label for="inputPassword3" class="col-sm-2 control-label">Password</label>
                                            <div class="col-sm-10">
                                                <input type="password" class="form-control" id="inputPassword3" placeholder="Password">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">

                                        <div class="form-group col-md-12">
                                            <label for="poliza" class="col-md-2 control-label">Poliza:</label>
                                            <div class="col-md-10">
                                                <input type="email" class="form-control" id="poliza" placeholder="Email">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="form-group col-md-12">
                                            <label>Referencia:</label>
                                            <input type="text" class="form-control" name="referencia" id="referencia">
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="form-group col-md-6">
                                            <label>Cant. Cliente:</label>
                                            <input type="text" class="form-control" name="Ccliente" id="Ccliente">
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="form-group col-sm-6">
                                            <label>Peso Total</label>
                                            <input type="text" class="form-control" name="pesoT" id="pesoT">
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="form-group col-sm-6">
                                            <label>Volumen Total</label>
                                            <input type="text" class="form-control" name="volumenT" id="volumenT">
                                        </div>
                                    </div>

                                    <div class="container-fluid justify-content-center">
                                        <form role="form" class="pt-3">
                                            <div class="form-group row">
                                                <label for="inputfield1" class="col-sm-2 control-label">Generic input</label>
                                                <div class="col-sm-10">
                                                    <input type="text" class="form-control" id="inputfield1" placeholder="Generic input..." />
                                                </div>
                                            </div><!-- .form-group -->
                                            <div class="form-group row">
                                                <label for="inputfield2" class="col-sm-2 control-label">Money value</label>
                                                <div class="input-group col-sm-10">
                                                    <span class="input-group-prepend input-group-text">$</span>
                                                    <input type="text" class="form-control" id="inputfield2" placeholder="Money value..." />
                                                    <span class="input-group-append input-group-text">.00</span>
                                                </div>
                                            </div><!-- .form-group -->
                                            <div class="form-group row">
                                                <label for="inputfield3" class="col-sm-3 control-label">Username</label>
                                                <div class="input-group col-sm-8">
                                                    <span class="input-group-addon input-group-text">@</span>
                                                    <input type="text" class="form-control" id="inputfield3" placeholder="Username..." />
                                                </div>
                                            </div><!-- .form-group -->
                                        </form>
                                    </div> <!-- termina container  -->

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