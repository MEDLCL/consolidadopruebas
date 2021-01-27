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
                                <button class="btn btn-primary" data-toggle="modal" data-target="#modalempresa">Agregar
                                    Nuevo
                                    <span class="glyphicon glyphicon-plus"></span>
                                </button>
                            </div>
                            <div class="panel panel-primary">
                                <div class="panel-heading"></div>
                                <div class="panel-body">
                                    <div class="form-group">
                                        <label for="codigo" class="control-label">Codigo:</label>
                                        <input type="text" class="form-control" id="codigo" placeholder="codigo" name="codigo">
                                    </div>
                                    <div class="form-group">
                                        <label for="codigo" class="control-label">Codigo:</label>
                                        <input type="text" name="codigo" id="codigo" class="form-control" style="width:150px">
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
                                                <th>Consignado A</th>
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
                                                    <ul class="sidebar-menu" data-widget="tree">
                                                        <li class='treeview'>
                                                            <a href="#">
                                                                <i class="fa fa-ship"></i>
                                                                <span>Acciones</span>
                                                                <span class="pull-right-container">
                                                                    <i class="fa fa-angle-left pull-right"></i>
                                                                </span>
                                                            </a>
                                                            <ul class='treeview-menu'>
                                                                <li><a href="pages/charts/chartjs.html"><i class="fa fa-circle-o"></i> ChartJS</a></li>
                                                                <li><a href="pages/charts/morris.html"><i class="fa fa-circle-o"></i> Morris</a></li>
                                                                <li><a href="pages/charts/flot.html"><i class="fa fa-circle-o"></i> Flot</a></li>
                                                                <li><a href="pages/charts/inline.html"><i class="fa fa-circle-o"></i> Inline charts</a></li>
                                                            </ul>
                                                        </li>
                                                    </ul>
                                                </td>
                                                <td class="text-right">
                                                    <div class="btn-group dropleft">
                                                        <button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                            Acciones
                                                        </button>
                                                        <div class="dropdown-menu" x-placement="left-start" style="position: absolute; transform: translate3d(-2px, 0px, 0px); top: 0px; left: 0px; will-change: transform;">
                                                            <a class="dropdown-item" href="#" title="Editar cliente" onclick="obtener_datos('177');" data-toggle="modal" data-target="#myModal2"><i class="fa fa-edit"></i> Editar</a>
                                                            <a class="dropdown-item" href="#" title="Agregar contacto" data-toggle="modal" data-id="177" data-cliente="Jose Luis " data-target="#agregar"><i class="fa fa-user"></i> Agregar contacto</a>
                                                            <a class="dropdown-item" href="#" title="Borrar cliente" onclick="eliminar('177')"><i class="fa fa-trash"></i> Eliminar</a>
                                                        </div>
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

<?php }
ob_end_flush();
?>