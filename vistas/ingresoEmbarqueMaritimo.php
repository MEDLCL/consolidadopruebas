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
            <div class="row" id="ingresomaritimo">
                <div class="col-md-12">
                    <div class="box box-info">
                        <div class=" box-header with-border">
                        </div>
                        <div class="panel panel-default">

                            <ul class="nav nav-tabs" id="tabIngresoMaritimo">
                                <li><a class="active" id="datosGenerales-tab" data-toggle="tab" href="#CrearMar">Datos
                                        Generales</a>
                                </li>
                                <li><a id="fechas-tab" data-toggle="tab" href="#fechaBarco">Fechas y Barco</a></li>
                                <li><a id="contenedores-tab" data-toggle="tab" href="#contenedor">Contenedores</a></li>
                                <li><a id="master-tab" data-toggle="tab" href="#mbl">Master BL</a></li>
                                <li><a id="hbls-tab" data-toggle="tab" href="#categorizacion">House BL</a></li>
                                <!-- <li class="nav-item">
                                <a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab"
                                    aria-controls="contact" aria-selected="false">Contact</a>
                            </li> -->
                            </ul>
                            <div class="tab-content" id="myTabContent">
                                <!-- <form action="" id="frmmaritimoOP" enctype="multipart/form-data"> -->
                                <?php
                                include_once("modal/ciudad.php");
                                include_once("../vistas/modal/modalempresa.php");
                                include_once("modal/barco.php");
                                include_once "includes/creacionMaritimo.php"
                                ?>
                                <!--  </form> -->
                                <div class="tab-pane fade" id="fechaBarco">
                                    <form action="" method="post" id="frmAsignaBarcoOP">
                                        <div class="col-md-12 form-group"></div>
                                        <div class="box box-primary" id="">
                                            <!--  formulario para detalle de almacen -->
                                            <div class="box-header with-border text-center"></div>
                                            <div class="box-body">
                                                <div class="form-group col-md-2">
                                                    <label for="codigobarco" class="control-label">Codigo:</label>
                                                    <input type="text" name="codigobarco" id="codigobarco" class="form-control input-sm" readonly>
                                                </div>
                                                <div class="form-group col-md-2">
                                                    <label for="consecutivoBarco" class="control-label">Consecutivo:</label>
                                                    <input type="text" name="consecutivoBarco" id="consecutivoBarco" class="form-control input-sm" readonly>
                                                </div>
                                                <input type="hidden" name="idEmbarquemBarco" id="idEmbarquemBarco">
                                                <div class="col-md-8">

                                                    <div class="col-md-6">
                                                        <label for="barcoLlegada" class="">Barco de Llegada(*)</label>
                                                        <div class="input-group input-group-sm">
                                                            <select id="barcoLlegada" name="barcoLlegada" class="form-control selectpicker" data-live-search="true">
                                                            </select>
                                                            <span class="input-group-btn">
                                                                <button type="button" class="btn btn-success fa fa-plus" data-target="#modalBarco" onclick="nuevoBarcoMllegada()"></button>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <label for="ViajeLlegada" class="control-label">Viaje de
                                                            Llegada(*):</label>
                                                        <input type="text" class="form-control input-sm" id="ViajeLlegada" name="ViajeLlegada" onkeyup="mayusculas(this)">
                                                    </div>
                                                    <div class="col-md-12 form-group">

                                                    </div>

                                                    <div class="form-group col-md-3">
                                                        <label for="etdOP" class="control-label">ETD(*):</label>
                                                        <input type="text" id="etdOP" name="etdOP" class="form-control input-sm">
                                                    </div>
                                                    <div class="form-group col-md-3">
                                                        <label for="etaOP" class="control-label">ETA(*):</label>
                                                        <input type="text" id="etaOP" name="etaOP" class="form-control input-sm">
                                                    </div>

                                                    <div class="form-group col-md-3">
                                                        <label for="cetaOP" class="control-label">CETA:</label>
                                                        <input type="text" id="cetaOP" name="cetaOP" class="form-control input-sm">
                                                    </div>

                                                    <div class="form-group col-md-3">
                                                        <label for="etaNavieraOP" class="control-label">ETANaviera:</label>
                                                        <input type="text" id="etaNavieraOP" name="etaNavieraOP" class="form-control input-sm">
                                                    </div>

                                                    <div class="col-md-12 form-group"></div>

                                                    <div class="form-group col-md-3">
                                                        <label for="completoOP" class="control-label">Completo:</label>
                                                        <input type="text" id="completoOP" name="completoOP" class="form-control input-sm">
                                                    </div>
                                                    <div class="form-group col-md-3">
                                                        <label for="pilotoOP" class="control-label">Piloto:</label>
                                                        <input type="text" id="pilotoOP" name="pilotoOP" class="form-control input-sm">
                                                    </div>
                                                    

                                                    <div class="form-group col-md-3">
                                                        <label for="descargaOP" class="control-label">Descarga:</label>
                                                        <input type="text" id="descargaOP" name="descargaOP" class="form-control input-sm">
                                                    </div>
                                                    <div class="form-group col-md-3">
                                                        <label for="liberadoOP" class="control-label">Liberado:</label>
                                                        <input type="text" id="liberadoOP" name="liberadoOP" class="form-control input-sm">
                                                    </div>
                                                    <div class="col-md-12 form-group"></div>
                                                    <div class="form-group col-md-3">
                                                        <label for="devueltoOP" class="control-label">Devuelto:</label>
                                                        <input type="text" id="devueltoOP" name="devueltoOP" class="form-control input-sm">
                                                    </div>
                                                </div> <!-- col md 8 tabla -->
                                            </div>
                                            <div class="box-footer">
                                                <button type="button" class="btn btn-primary" onclick="grabarAsingaBarco()">Grabar Barco <span class="fa fa-floppy-o"></span> </button>
                                            </div>
                                        </div>
                                    </form>
                                </div> <!-- barco y fecha -->

                                <div class="tab-pane fade" id="contenedor">
                                    <form action="" method="post">
                                        <div class="col-md-12 form-group"></div>
                                        <div class="box box-primary" id="">
                                            <!--  formulario para detalle de almacen -->
                                            <div class="box-header with-border text-center"></div>
                                            <div class="box-body">
                                                <div class="col-md-12">
                                                    <div class="form-group col-md-2">
                                                        <label for="codigobarco" class="control-label">Codigo:</label>
                                                        <input type="text" name="codigobarco" id="codigobarco" class="form-control input-sm" readonly>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label for="consecutivoBarco" class="control-label">Consecutivo:</label>
                                                        <input type="text" name="consecutivoBarco" id="consecutivoBarco" class="form-control input-sm" readonly>
                                                    </div>
                                                </div>
                                                <div class="col-md-5">
                                                    <div class="col-md-12 form-group"></div>

                                                    <div class="form-group col-md-6">
                                                        <label for="ViajeLlegada" class="control-label">No
                                                            Contenedor(*)</label>
                                                        <input type="text" class="form-control input-sm" id="ViajeLlegada" name="ViajeLlegada" onkeyup="mayusculas(this)">
                                                    </div>

                                                    <div class="col-md-6">
                                                        <label for="barcoLlegada" class="">Tipo Equipo(*)</label>
                                                        <div class="input-group input-group-sm">
                                                            <select id="barcoLlegada" name="barcoLlegada" class="form-control selectpicker" data-live-search="true">
                                                            </select>
                                                            <span class="input-group-btn">
                                                                <button type="button" class="btn btn-success fa fa-plus" data-target="#modalBarco" onclick="nuevoBarcoM()"></button>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12"></div>

                                                    <div class="form-group col-md-6">
                                                        <label for="ViajeLlegada" class="control-label">Peso(*):</label>
                                                        <input type="number" class="form-control input-sm" id="ViajeLlegada" name="ViajeLlegada" onkeyup="mayusculas(this)">
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <label for="ViajeLlegada" class="control-label">Volumen(*):</label>
                                                        <input type="number" class="form-control input-sm" id="ViajeLlegada" name="ViajeLlegada" onkeyup="mayusculas(this)">
                                                    </div>

                                                    <div class="col-md-12">

                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <label for="ViajeLlegada" class="control-label">Paquetes(*):</label>
                                                        <input type="number" class="form-control input-sm" id="ViajeLlegada" name="ViajeLlegada" onkeyup="mayusculas(this)">
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label for="barcoLlegada" class="">Empaque(*)</label>
                                                        <div class="input-group input-group-sm">
                                                            <select id="barcoLlegada" name="barcoLlegada" class="form-control selectpicker" data-live-search="true">
                                                            </select>
                                                            <span class="input-group-btn">
                                                                <button type="button" class="btn btn-success fa fa-plus" data-target="#modalBarco" onclick="nuevoBarcoM()"></button>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12"></div>

                                                    <div class="col-md-6">
                                                        <label for="barcoLlegada" class="">Usuario CS(*)</label>
                                                        <div class="input-group input-group-sm">
                                                            <select id="barcoLlegada" name="barcoLlegada" class="form-control selectpicker" data-live-search="true">
                                                            </select>
                                                            <span class="input-group-btn">
                                                                <button type="button" class="btn btn-success fa fa-plus" data-target="#modalBarco" onclick="nuevoBarcoM()"></button>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12 form-group"></div>

                                                    <div class="form-group col-md-12">
                                                        <label for="obervaciones" class="control-label">Observaciones:</label>
                                                        <textarea class="form-control input-sm" id="obervaciones" name="obervaciones" rows="3" onkeyup="mayusculas(this)"></textarea>
                                                    </div>
                                                    <div class="form-group col-md-12">
                                                        <label for="obervaciones" class="control-label">Observaciones:</label>
                                                        <textarea class="form-control input-sm" id="obervaciones" name="obervaciones" rows="3" onkeyup="mayusculas(this)"></textarea>
                                                    </div>

                                                    <div class="col-md-6">
                                                        <label for="barcoLlegada" class="">Tipo Sello(*)</label>
                                                        <div class="input-group input-group-sm">
                                                            <select id="barcoLlegada" name="barcoLlegada" class="form-control selectpicker" data-live-search="true">
                                                            </select>
                                                            <span class="input-group-btn">
                                                                <button type="button" class="btn btn-default"></button>
                                                            </span>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-5">
                                                        <label for="ViajeLlegada" class="control-label">Sello(*):</label>
                                                        <input type="text" class="form-control input-sm" id="ViajeLlegada" name="ViajeLlegada" onkeyup="mayusculas(this)">
                                                    </div>

                                                    <div class="col-md-1 form-group">
                                                        <label for="">.</label>
                                                        <button type="button" class="btn btn-default fa fa-plus">
                                                        </button>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <div class="panel-body table-responsive">
                                                            <table class="table table-condensed table-hover table-bordered" id="Tcontactos">
                                                                <thead>
                                                                    <th>Aciones</th>
                                                                    <th>Tipo</th>
                                                                    <th>Sello</th>
                                                                </thead>
                                                                <tbody id="tbodyC">
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div> <!-- col md 8 tabla -->
                                                </div> <!-- col md 8 tabla -->
                                                <div class="col-md-7">
                                                    <div class="panel-body table-responsive">
                                                        <table class="table table-condensed table-hover table-bordered" id="Tcontactos">
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
                                    </form>
                                </div> <!-- Contenedor -->
                                <div class="tab-pane fade" id="mbl">
                                    <form action="" method="post">
                                        <div class="col-md-12 form-group"></div>
                                        <div class="box box-primary" id="">
                                            <!--  formulario para detalle de almacen -->
                                            <div class="box-header with-border text-center"></div>
                                            <div class="box-body">
                                                <div class="col-md-12">
                                                    <div class="form-group col-md-2">
                                                        <label for="codigobarco" class="control-label">Codigo:</label>
                                                        <input type="text" name="codigobarco" id="codigobarco" class="form-control input-sm" readonly>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label for="consecutivoBarco" class="control-label">Consecutivo:</label>
                                                        <input type="text" name="consecutivoBarco" id="consecutivoBarco" class="form-control input-sm" readonly>
                                                    </div>
                                                </div>
                                                <div class="col-md-5">
                                                    <div class="col-md-12 form-group"></div>
                                                    <div class="form-group col-md-6">
                                                        <label for="ViajeLlegada" class="control-label">No. MBL(*)</label>
                                                        <input type="text" class="form-control input-sm" id="ViajeLlegada" name="ViajeLlegada" onkeyup="mayusculas(this)">
                                                    </div>

                                                    <div class="form-group col-md-6">
                                                        <label for="ViajeLlegada" class="control-label">Paquetes Totales(*):</label>
                                                        <input type="number" class="form-control input-sm" id="ViajeLlegada" name="ViajeLlegada" onkeyup="mayusculas(this)">
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <label for="ViajeLlegada" class="control-label">Peso Total(*):</label>
                                                        <input type="number" class="form-control input-sm" id="ViajeLlegada" name="ViajeLlegada" onkeyup="mayusculas(this)">
                                                    </div>
                                                    <div class="form-group col-md-6">
                                                        <label for="ViajeLlegada" class="control-label">Volumen Total(*):</label>
                                                        <input type="number" class="form-control input-sm" id="ViajeLlegada" name="ViajeLlegada" onkeyup="mayusculas(this)">
                                                    </div>

                                                    <div class="col-md-12 form-group">
                                                        <label for="barcoLlegada" class="">Puerto de Carga(*)</label>
                                                        <div class="input-group input-group-sm">
                                                            <select id="barcoLlegada" name="barcoLlegada" class="form-control selectpicker" data-live-search="true">
                                                            </select>
                                                            <span class="input-group-btn">
                                                                <button type="button" class="btn btn-success fa fa-plus" data-target="#modalBarco" onclick="nuevoBarcoM()"></button>
                                                            </span>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-12 form-group">
                                                        <label for="barcoLlegada" class="">Puerto de Descarga(*)</label>
                                                        <div class="input-group input-group-sm">
                                                            <select id="barcoLlegada" name="barcoLlegada" class="form-control selectpicker" data-live-search="true">
                                                            </select>
                                                            <span class="input-group-btn">
                                                                <button type="button" class="btn btn-success fa fa-plus" data-target="#modalBarco" onclick="nuevoBarcoM()"></button>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12 form-group">
                                                        <label for="barcoLlegada" class="">Tipo Documento(*)</label>
                                                        <div class="input-group input-group-sm">
                                                            <select id="barcoLlegada" name="barcoLlegada" class="form-control selectpicker" data-live-search="true">
                                                            </select>
                                                            <span class="input-group-btn">
                                                                <button type="button" class="btn btn-success fa fa-plus" data-target="#modalBarco" onclick="nuevoBarcoM()"></button>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <button type="button" class="btn btn-default fa fa-file-pdf-o">Nuevo MBL</button>
                                                        <button type="button" class="btn btn-primary fa fa-floppy-o">Grabar MBL</button>
                                                    </div>

                                                </div> <!-- col md 8 tabla -->
                                                <div class="col-md-7">
                                                    <div class="panel-body table-responsive">
                                                        <table class="table table-condensed table-hover table-bordered" id="Tcontactos">
                                                            <thead>
                                                                <th>Aciones</th>
                                                                <th>No. MBL</th>
                                                                <th>Cant. Paquete</th>
                                                                <th>Peso Total</th>
                                                                <th>Volumen Total</th>
                                                                <th>Puerto Carga</th>
                                                                <th>Puerto Descarga</th>
                                                                <th>Tipo Documento</th>
                                                            </thead>
                                                            <tbody id="tbodyC">
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div> <!-- col md 8 tabla -->

                                            </div>
                                        </div>
                                    </form>
                                </div> <!-- Master -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="tblEmbarquesOP">
                <div class="box box-solid">

                    <div class="panel panel-default">
                        <div class="panel-body table-responsive">

                            <table class="table table-bordered table-hover table-responsive table-hover" id="tblDetalleEmbarquesOP">
                                <thead>
                                    <tr>
                                        <th>Acciones</th>
                                        <th>Fecha Ingreso</th>
                                        <th>Codigo</th>
                                        <th>Consecutivo</th>
                                        <th>Tipo Carga</th>
                                        <th>Tipo Servicio</th>
                                        <th>Courier</th>
                                        <th>Barco</th>
                                        <th>Viaje</th>
                                        <th>Cant. Clientes</th>
                                        <th>Agente Embarcador</th>
                                        <th>Naviera/Agencia Carga</th>
                                        <th>Origen</th>
                                        <th>Destino</th>
                                        <th>Usuario Asignado</th>
                                        <th>Observaciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><button type="submit" class="btn btn-warning glyphicon glyphicon-pencil" data-target="" data-toggle="">
                                            </button>
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
    <script type="text/javascript" src="scritps/barco.js"></script>
    <script src="scritps/maritimo.js"> </script>
    <script src="scritps/ingresaMaritimo.js"></script>
    <script type="text/javascript" src="scritps/ciudad.js"></script>

    <script>
    </script>

<?php }
ob_end_flush();
?>