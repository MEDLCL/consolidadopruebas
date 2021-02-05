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
                    <div class="col-md-5">
                        <div class="box">
                            <div class="box-header with-border">
                                <h3>KARDEX</h3>
                            </div>
                            <div class="panel panel-primary">
                                <div class="panel-heading"></div>
                                <div class="panel-body">
                                    <div class="form-group col-lg-8">
                                        <label>Número(*):</label>
                                        <input type="text" class="form-control" name="num_documento" id="num_documento" maxlength="20" placeholder="Documento" required>
                                    </div>
                                    <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                        <label>Dirección:</label>
                                        <input type="text" class="form-control" name="direccion" id="direccion" placeholder="Dirección" maxlength="70">
                                    </div>
                                    <div class="form-group">
                                        <label for="codigo" class="control-label">Codigo:</label>
                                        <input type="text" class="form-control" id="codigo" placeholder="codigo" name="codigo" readonly>
                                    </div>
                                   
                                    <div class="form-group col-lg-10">
                                        <label>Tipo Documento(*):</label>
                                        <select class="form-control select-picker" name="tipo_documento" id="tipo_documento" required>
                                            <option value="DNI">DNI</option>
                                            <option value="RUC">RUC</option>
                                            <option value="CEDULA">CEDULA</option>
                                        </select>
                                    </div>
                                    <div class="form-group col-lg-2">
                                        <label>Número(*):</label>
                                        <input type="text" class="form-control" name="num_documento" id="num_documento" maxlength="20" placeholder="Documento" required>
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
<<<<<<< HEAD
                                                <td class="text-right">
                                                    <div class="btn-group">
                                                        <!-- <button type="button" class="btn btn-danger">acciones</button> -->
                                                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                                                            Acciones <span class="caret"></span>
                                                            <span class="sr-only">Desplegar menú</span>
                                                        </button>
=======
                                                <td>
                                                    <div class="btn-group">
                                                        <button type="button" class="btn btn-success dropdown-toggle btn-sm" data-toggle="dropdown">
                                                            <span class="fa fa-cog"></span>
                                                            Acciones
                                                            <span class="caret"></span>
                                                            <span class="sr-only">Desplegar menú</span>
                                                        </button>

>>>>>>> 6b784b6bd998ea73c8cd40ead5b87576d1fddf8b
                                                        <ul class="dropdown-menu" role="menu">
                                                            <li><a href="#">Acción #1</a></li>
                                                            <li><a href="#">Acción #2</a></li>
                                                            <li><a href="#">Acción #3</a></li>
                                                            <li class="divider"></li>
                                                            <li><a href="#">Acción #4</a></li>
                                                        </ul>
                                                    </div>
                                                </td>
<<<<<<< HEAD
                                                <td>

                                                </td>
=======
>>>>>>> 6b784b6bd998ea73c8cd40ead5b87576d1fddf8b
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

<?php }
ob_end_flush();
?>