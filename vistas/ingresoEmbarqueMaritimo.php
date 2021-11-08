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
        <div class="row" id="listadoEvalucaiones">
            <div class="col-md-12">
                <div class="box box-info box-solid">
                    <div class=" box-header with-border">
                    </div>
                    <div class="panel panel-default">

                        <ul class="nav nav-tabs" id="tabempresa">
                            <li><a class="active" id="home-tab" data-toggle="tab" href="#home">Datos Generales</a>
                            </li>
                            <li><a id="contacto-tab" data-toggle="tab" href="#contactos">Contactos</a></li>
                            <li><a id="fechas-tab" data-toggle="tab" href="#contactos">Fechas y Barco</a></li>
                            <li><a id="contenedores-tab" data-toggle="tab" href="#contactos">Contenedores</a></li>
                            <li><a id="master-tab" data-toggle="tab" href="#contactos">Master BL</a></li>
                            <li><a id="hbls-tab" data-toggle="tab" href="#contactos">House BL</a></li>
                            <!-- <li class="nav-item">
                                <a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab"
                                    aria-controls="contact" aria-selected="false">Contact</a>
                            </li> -->
                        </ul>
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade active" id="home">
                                <div class="row">
                                    <div class="col-md-7">
                                        <div class="panel panel-default">
                                            <div class="panel-heading"></div>
                                            <div class="panel-body">
                                                <!-- <form class="form-horizontal"> -->
                                            
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-5">
                                        <div id="consignadoa" class="col-md-8">
                                            <div class="panel panel-primary">
                                                <div class="panel-heading"></div>
                                                <div class="panel-body">
                                                    <!-- <form class="form-horizontal"> -->

                                                    <div class="form-group">
                                                        <label for="comision" class="control-label">%
                                                            Comision</label>
                                                        <input type="number" name="comision" id="comision"
                                                            class="form-control">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="cbm" class="control-label">
                                                            <input type="radio" name="cbmtarifa" id="cbm" value="cbm">
                                                            Por CBM:</label>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="tarifa" class="control-label">
                                                            <input type="radio" name="cbmtarifa" id="tarifa"
                                                                value="tarifa">
                                                            Por TARIFA:</label>
                                                    </div>
                                                    <!-- </form> -->
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12" id="otrosTruck">
                                            <div class="panel panel-primary">
                                                <div class="panel-heading"></div>
                                                <div class="panel-body">
                                                    <!-- <form class="form-horizontal"> -->

                                                    <div class="form-group">
                                                        <label for="giroNegocio" class="control-label">Giro de
                                                            Negocio:</label>
                                                        <select id="giroNegocio" name="giroNegocio"
                                                            class="selectpicker form-control" data-live-search="true">
                                                        </select>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="tamanoEmpresa" class="control-label">Tamaño de la
                                                            Empresa:</label>
                                                        <select id="tamanoEmpresa" name="tamanoEmpresa"
                                                            class="selectpicker form-control" data-live-search="true">

                                                        </select>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="tipoCargaEmpresa" class="control-label">Tipo
                                                            Carga:</label>
                                                        <select id="tipoCargaEmpresa" name="tipoCargaEmpresa"
                                                            class="selectpicker form-control" data-live-search="true">

                                                        </select>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="canalDistribucion" class="control-label">Canal de
                                                            Distribucion:</label>
                                                        <select id="canalDistribucion" name="canalDistribucion"
                                                            class="selectpicker form-control" data-live-search="true">

                                                        </select>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="asloEmpresa" class="control-label">Aslo:</label>
                                                        <select id="asloEmpresa" name="asloEmpresa"
                                                            class="selectpicker form-control" data-live-search="true">
                                                        </select>
                                                    </div>
                                                    <!-- </form> -->
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="tab-pane fade" id="contactos">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="panel panel-primary">
                                            <div class="panel-heading">
                                            </div>
                                            <div class="panel-body">
                                                <!-- <form role="form"> -->
                                                <div class="form-group">
                                                    <label for="Nombre" class="control-label">Nombre:</label>
                                                    <input type="text" name="Nombre" id="Nombre" class="form-control">
                                                </div>
                                                <div class="form-group">
                                                    <label for="Apellido" class="control-label">Apellido:</label>
                                                    <input type="text" name="Apellido" id="Apellido"
                                                        class="form-control">
                                                </div>
                                                <div class="form-group">
                                                    <label for="Correo" class="control-label">Correo:</label>
                                                    <input type="email" name="Correo" id="Correo" class="form-control">
                                                </div>
                                                <div class="form-group">
                                                    <label for="telefono" class="control-label">Telefono:</label>
                                                    <input type="text" name="telefonoc" id="telefonoc"
                                                        class="form-control"
                                                        onkeyup="this.value=numeroTelefono(this.value)">
                                                </div>
                                                <div class="form-group">
                                                    <label for="puesto" class="control-label">Puesto:</label>
                                                    <input type="text" name="puesto" id="puesto" class="form-control">
                                                </div>
                                                <div class="form-group col-md-offset-3">
                                                    <button type="button" class="btn btn-large btn-success"
                                                        onclick="registrarc()">Registrar</button>
                                                </div>
                                                <!-- </form> -->
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="panel-body table-responsive">
                                            <table class="table table-condensed table-hover table-bordered"
                                                id="Tcontactos">
                                                <thead>
                                                    <th>Aciones</th>
                                                    <th>Nombre</th>
                                                    <th>Apellido</th>
                                                    <th>Correo</th>
                                                    <th>Telefono</th>
                                                    <th>Puesto</th>
                                                </thead>
                                                <tbody id="tbodyC">
                                                </tbody>
                                            </table>
                                        </div>
                                    </div> <!-- col md 8 tabla -->
                                </div>
                            </div> 
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="tablaDetalleAlmacen">
                    <div class="box box-solid">
                        <div class=" box-header with-border">
                            <button type="button" class="btn btn-primary" onclick="nuevoDetalle('true')" id="btnNuevoDetalle">Nuevo
                                <span class="fa  fa-plus"></span>
                            </button>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-body table-responsive">

                                <table class="table table-bordered table-hover table-responsive table-hover" id="Tdetalle">
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
                                            <th>DUT</th>
                                            <th>Liberado</th>
                                            <th>Linea</th>
                                            <th>No. Resa</th>
                                            <th>DTI</th>
                                            <th>No Cancel</th>
                                            <th>No Orden</th>
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