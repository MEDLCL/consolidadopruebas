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
            include_once("../vistas/banco.php");
        ?>

        <div class="row" id="divMovBancarios">
            <form action="" role="form" id="frmMovBancario">
                <div class="col-md-6">
                    <div class="box box-info">
                        <div class="box-header with-border">
                            
                        </div>
                        <div class="box-body">
                            <div class="form-horizontal">
                                <div class="col-md-12">
                                    <label for="movBanco" class="">Nombre Banco(*) </label>
                                    <div class="input-group input-group-sm">
                                        <select id="movBanco" name="movBanco" class="form-control selectpicker"
                                            data-live-search="true">
                                        </select>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-info fa fa-plus" data-toggle="modal"
                                                data-target="#modalempresa" onclick="nuevoBanco()"></button>
                                        </span>
                                        <input type="hidden" name="idmovbancario" id="idmovbancario">
                                    </div>
                                </div>
                                <di class="col-md-12">
                                    <span>.</span>
                                </di>
                                <div class="col-md-12">
                                    <label for="consigmovcuentaBancariaanado" class="">Numero de Cuenta(*)</label>
                                    <div class="input-group input-group-sm">
                                        <select id="movcuentaBancaria" name="movcuentaBancaria"
                                            class="form-control selectpicker" data-live-search="true">
                                        </select>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-info fa fa-plus" data-toggle="modal"
                                                data-target="#modalempresa" onclick="nuevoBanco()"></button>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-12"><span>.</span></div>
                                <div class="col-md-4">
                                    <label for="tipoOperacion" class="">Tipo Operacion(*)</label>
                                    <div class="input-group input-group-sm">
                                        <select id="tipoOperacion" name="tipoOperacion"
                                            class="form-control selectpicker" data-live-search="true">
                                        </select>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-info fa fa-genderless"></button>
                                        </span>
                                    </div>
                                </div>


                                <div class="col-md-4">
                                    <label for="movMonto">Monto(*): </label>
                                    <div class="form-group input-group-sm">
                                        <div class="col-md-12">
                                            <input type="number" class="form-control" name="movMonto" id="movMonto">
                                        </div>
                                    </div>

                                </div>
                                <div class="col-md-4">
                                    <label for="movChequeCaja">Cheque de Caja(*): </label>
                                    <div class="form-group input-group-sm">
                                        <div class="col-md-12">
                                            <input type="number" class="form-control" name="movChequeCaja"
                                                id="movChequeCaja">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12"></div>
                                <div class="col-md-6">
                                    <label>Fecha Operacion(*)</label>
                                    <div class="form-group input-group-sm">
                                        <div class="col-md-12">
                                            <input type="text" class="form-control" name="movFechaOperacion"
                                                id="movFechaOperacion">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label>No. Operacion(*)</label>
                                    <div class="form-group input-group-sm">
                                        <div class="col-md-12">
                                            <input type="number" class="form-control" name="movNoOperacion"
                                                id="movNoOperacion">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <label>A nombre De(*)</label>
                                    <div class="form-group input-group-sm">
                                        <div class="col-md-12">
                                            <textarea class="form-control input-sm" id="movAnombreDe"
                                                name="movAnombreDe" rows="2" onkeyup="mayusculas(this)"></textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <label>Observaciones:</label>
                                    <div class="form-group input-group-sm">
                                        <div class="col-md-12">
                                            <textarea class="form-control input-sm" id="movObservaciones"
                                                name="movObservaciones" rows="3" onkeyup="mayusculas(this)"></textarea>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-offset-3 col-sm-9">
                                        <button class="btn btn-default" type="button" onclick="" id="">Nuevo
                                            <span class="fa fa-file-o"></span>
                                        </button>

                                        <button class="btn btn-primary" type="button" onclick="" id="grabaAlmacen">Graba
                                            <span class="fa fa-floppy-o"></span>
                                        </button>

                                        <button class="btn btn-danger" type="button" onclick="" id="cancelarA">Cancelar
                                            <span class="fa fa-close"></span>
                                        </button>
                                    </div>
                                </div>
                            </div> <!-- form id horizontal  -->
                        </div> <!-- body box  -->
                    </div>
                </div><!-- /.col -->
                <div class="col-md-6">
                    <!-- area de factruas proveedores -->
                    <div class="box box-solid">
                        <div class=" box-header with-border">
                        </div>
                        <div class="panel panel-default">
                            <div class="col-md-12">
                                <label for="movBanco" class="">Proveedor(*) </label>
                                <div class="input-group input-group-sm">
                                    <select id="movBanco" name="movBanco" class="form-control selectpicker"
                                        data-live-search="true">
                                    </select>
                                    <span class="input-group-btn">
                                        <button type="button" class="btn btn-success"></button> ></button>
                                    </span>
                                </div>
                            </div>
                            <div class="col-md-12"><span>.</span></div>
                            <div class="col-md-4">
                                <label>Fecha Inicio(*)</label>
                                <div class="form-group input-group-sm">
                                    <input type="text" class="form-control" name="movFechainicio" id="movFechainicio">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label>Fecha Final(*)</label>
                                <div class="form-group input-group-sm">
                                    <input type="text" class="form-control" name="movFechaFinal" id="movFechaFinal">
                                </div>
                            </div>
                            <label for="">.</label>
                            <div class="col-md-4">
                                <button class="btn btn-primary" type="button" onclick="" id="btnBuscaFacturas">
                                    <span class="fa  fa-refresh"></span>
                                </button>
                            </div>
                            <div class="col-md-12"></div>
                            <div class="panel-body table-responsive">
                                <table class="table table-bordered table-hover table-responsive table-hover"
                                    id="tblMovFacturasPro">
                                    <thead>
                                        <tr>
                                            <th>Acciones</th>
                                            <th>Estatus</th>
                                            <th>Año</th>
                                            <th>Codigo</th>
                                            <th>Consignado</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div> <!-- fin col 6 proveedores -->
            </form><!--  form almacen -->
        </div><!-- /.col row -->

        <div class="row" id="divTblMovBancarios">
            <div class="col-md-12">
                <div class="box box-solid">
                    <div class=" box-header with-border">
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-body table-responsive">
                            <table class="table table-bordered table-hover table-responsive table-hover"
                                id="tblMovBancario">
                                <thead>
                                    <tr>
                                        <th>Acciones</th>
                                        <th>Estatus</th>
                                        <th>Banco</th>
                                        <th>Cuenta</th>
                                        <th>Tipo</th>
                                        <th>Monto</th>
                                        <th>Cheque Caja</th>
                                        <th>Fecha Operacion</th>
                                        <th>Fecha Ingreso</th>
                                        <th>No Operacion</th>
                                        <th>Cant. Clientes</th>
                                        <th>Benefeciario</th>
                                        <th>Observaciones</th>
                                    </tr>
                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div> <!-- col md 12 tabla-->
        </div> <!-- row de tabla movbancarios -->
    </section><!-- /.content -->
</div><!-- /.content-wrapper -->
<?php
    require_once("../inc/footer.php");
    require_once("../inc/scritps.php");
    ?>

<!-- <script src="scritps/empresa.js"></script> -->
<?php }
ob_end_flush();
?>