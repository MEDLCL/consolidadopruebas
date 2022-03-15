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
            include_once("../vistas/modal/modalempresa.php");
            include_once("modal/catalogo.php");
            ?>
            <form action="" method="post" id="frmEvaluacionProyectoTruck" enctype="multipart/form-data">
                <div class="row" id="nuevaEvaluacion">
                    <div class="col-md-12">
                        <div class="box box-primary box-solid">
                            <div class="box-header with-border text-center">EVALUACION DE PROYECTO</div>
                            <div class="box-body">
                                <div class="col-md-3">
                                    <label for="codigoProyecto">Codigo Proyecto:</label>
                                    <div class="form-group input-group-sm">
                                        <input type="text" class="form-control" name="codigoProyecto" id="codigoProyecto" onkeyup="mayusculas(this)" readonly>
                                        <input type="hidden" name="idproyecto" id="idproyecto">
                                    </div>
                                </div>
                                <div class="col-md-12"></div>
                                <div class="col-md-8">
                                    <label for="clienteEva" class="">Cliente(*) </label>
                                    <div class="input-group input-group-sm ">
                                        <select id="clienteEva" name="clienteEva" class="form-control selectpicker" data-live-search="true">
                                        </select>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-info"><span class="fa fa-plus" data-target="#modalempresa" onclick="nuevoClienteProyecto()"></span> </button>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <label for="finicioPro">Inicio:</label>
                                    <div class="form-group input-group-sm">
                                        <input type="text" class="form-control" name="finicioPro" id="finicioPro" onkeyup="mayusculas(this)">
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <label for="fFinalPro">Finalizacion:</label>
                                    <div class="form-group input-group-sm">
                                        <input type="text" class="form-control" name="fFinalPro" id="fFinalPro" onkeyup="mayusculas(this)">
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <label for="descripcionProyecto">Descripcion General del Proyecto(*):</label>
                                    <textarea class="form-control" rows="1" id="descripcionProyecto" name="descripcionProyecto" onkeyup="mayusculas(this)"></textarea>
                                </div>

                            </div> <!-- form id horizontal  -->
                        </div> <!-- body box  -->
                    </div>
                    <!--datos generales  -->
                    <div class="col-md-12">
                        <div class="box box-primary box-solid">
                            <div class="box-header with-border text-center">INFORMACION DE LA CARGA</div>
                            <div class="box-body">
                                <div class="form-horizontal">
                                    <div class="col-md-3">
                                        <label for="tipocargaProyecto" class="">Tipo Carga a Transportar(*) </label>
                                        <div class="input-group input-group-sm">

                                            <select id="tipocargaProyecto" name="tipocargaProyecto" class="form-control selectpicker" data-live-search="true">
                                            </select>
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-default"></button>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <label for="fianzaPro" class="">Fianza(*) </label>
                                        <div class="input-group input-group-sm">

                                            <select id="fianzaPro" name="fianzaPro" class="form-control selectpicker" data-live-search="true">
                                            </select>
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-default"></button>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-lg-offset-1">
                                        <label for="pesoPromedioPro">Peso Promedio(*)</label>
                                        <div class="input-group-sm ">
                                            <input type="number" class="form-control" name="pesoPromedioPro" id="pesoPromedioPro" onkeyup="mayusculas(this)">
                                        </div>
                                    </div>
                                    <div class="col-md-2 ">
                                        <label for="unidadPesoPro" class="">Unidad(*) </label>
                                        <div class="input-group input-group-sm">
                                            <select id="unidadPesoPro" name="unidadPesoPro" class="form-control selectpicker" data-live-search="true">
                                            </select>
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-default"></button>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <label for="piesCubicosPro">Pies Cubicos</label>
                                        <div class="input-group-sm ">
                                            <input type="number" class="form-control" name="piesCubicosPro" id="piesCubicosPro" onkeyup="mayusculas(this)">
                                        </div>
                                    </div>
                                    <div class="col-md-12 form-group"></div>
                                    <div class="col-md-6">
                                        <label for="mercaderiaPro">Descripcion de la Mercaderia(*):</label>
                                        <textarea class="form-control" rows="1" id="mercaderiaPro" name="mercaderiaPro" onkeyup="mayusculas(this)"></textarea>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="permisosEspecialesPro">Permisos Especiales(*):</label>
                                        <textarea class="form-control" rows="1" id="permisosEspecialesPro" name="permisosEspecialesPro"></textarea>
                                    </div>
                                    <div class="col-md-12 form-group"></div>

                                </div> <!-- form id horizontal  -->
                            </div> <!-- body box  -->
                        </div><!-- /.col -->
                    </div>
                    <!--informacion de la carga -->

                    <div class="col-md-12">
                        <div class="box box-primary box-solid" id="">
                            <!--  formulario para detalle de almacen -->
                            <div class="box-header with-border text-center">TIPO DE UNIDAD DE TRASPORTE</div>
                            <div class="box-body">

                                <div class="col-md-6">
                                    <div class="panel panel-default">
                                        <div class="panel-body">

                                            <div class="col-md-6 form-group">
                                                <label for="">No. de Unidades(*)</label>
                                                <div class="input-group-sm">
                                                    <input type="number" class="form-control" name="numeroUnidadesPro" id="numeroUnidadesPro" onkeyup="mayusculas(this)">
                                                    <input type="hidden" name="idtipounidadtransporte" id="idtipounidadtransporte">
                                                </div>
                                            </div>

                                            <div class="col-md-6 form-group">
                                                <label for="tipoUnidaPro" class="">Tipo de Unidades(*) </label>
                                                <div class="input-group input-group-sm">
                                                    <select id="tipoUnidaPro" name="tipoUnidaPro" class="form-control selectpicker" data-live-search="true">
                                                    </select>
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-default"></button>
                                                    </span>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <label for="tipoEquipoPro" class="">Tipo de Equipo(*) </label>
                                                <div class="input-group input-group-sm">
                                                    <select id="tipoEquipoPro" name="tipoEquipoPro" class="form-control selectpicker" data-live-search="true">
                                                    </select>
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-default"></button>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="col-md-6 from form-group">
                                                <label for="">Temperatura Promedio(*)</label>
                                                <div class="input-group-sm">
                                                    <input type="text" class="form-control" name="temperaturaPro" id="temperaturaPro" onkeyup="mayusculas(this)">
                                                </div>
                                            </div>

                                            <div class="col-md-12 form-group">
                                                <label for="caracEquipoPro">Especificación del Equipo(*):</label>
                                                <textarea class="form-control" rows="1" id="caracEquipoPro" name="caracEquipoPro"></textarea>
                                            </div>
                                            <div class="col-md-6 form-group">
                                                <label for="cajillaSeguridadPro" class="">Cajilla de Seguridad(*) </label>
                                                <div class="input-group input-group-sm">
                                                    <select id="cajillaSeguridadPro" name="cajillaSeguridadPro" class="form-control selectpicker" data-live-search="true">
                                                    </select>
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-default"></button>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="col-md-6 form-group">
                                                <label for="marchamoPro" class="">Marchamo(*) </label>
                                                <div class="input-group input-group-sm">
                                                    <select id="marchamoPro" name="marchamoPro" class="form-control selectpicker" data-live-search="true">
                                                    </select>
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-default"></button>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="col-md-6 form-group">
                                                <label for="gpsPro" class="">GPS(*) </label>
                                                <div class="input-group input-group-sm">
                                                    <select id="gpsPro" name="gpsPro" class="form-control selectpicker" data-live-search="true">
                                                    </select>
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-default"></button>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="col-md-12 form-group">
                                                <label for="lugarCargaPro">Lugar de Carga(*):</label>
                                                <textarea class="form-control" rows="1" id="lugarCargaPro" name="lugarCargaPro"></textarea>
                                            </div>
                                            <div class="col-md-12 form-group">
                                                <label for="lugarDescargaPro">Lugar Descarga(*):</label>
                                                <textarea class="form-control" rows="1" id="lugarDescargaPro" name="lugarDescargaPro"></textarea>
                                            </div>
                                            <div class="col-md-12 form-group">
                                                <label for="canalDistribucionPro" class="">Canal de Distrbucion(*) </label>
                                                <div class="input-group input-group-sm">
                                                    <select id="canalDistribucionPro" name="canalDistribucionPro" class="form-control selectpicker" data-live-search="true">
                                                    </select>
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-default"></button>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="col-md-12 form-group col-md-offset-4">
                                                <button type="button" class="btn btn-primary" onclick="registrarUnidadesTransporte()">Registrar <span class="fa fa-plus-circle"></span> </button>
                                            </div>

                                        </div> <!-- body box  -->
                                    </div>
                                </div>
                                <div class="col-md-6">

                                    <div class="panel panel-default">
                                        <div class="panel-body table-responsive">
                                            <table class="table table-bordered table-hover table-responsive table-hover" id="TuniadesAsignadas">
                                                <thead>
                                                    <tr>
                                                        <th>Acciones</th>
                                                        <th>Cant. Unidades</th>
                                                        <th>Tipo Unidad</th>
                                                        <th>Tipo Equipo</th>
                                                        <th>Temperatura</th>
                                                        <th>Especificaciones</th>
                                                        <th>Seguridad</th>
                                                        <th>Marchamo</th>
                                                        <th>GPS</th>
                                                        <th>Lugar Carga</th>
                                                        <th>Lugar Descarga</th>
                                                        <th>Canal Distribucion</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="tbodytipounidadtransporte">

                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div> <!-- col md 8 tabla-->

                    <div class="col-md-12">
                        <div class="box box-primary box-solid" id="">
                            <!--  formulario para detalle de almacen -->
                            <div class="box-header with-border text-center">DATOS DE LA OPERACION</div>
                            <div class="box-body">

                                <div class="col-md-4 form-group">
                                    <label for="entregasPromedioPro">Prom. De entregas realizadas por viaje:</label>
                                    <div class="input-group-sm">
                                        <input type="text" class="form-control" name="entregasPromedioPro" id="entregasPromedioPro">
                                    </div>
                                </div>

                                <div class="col-md-4 form-group">
                                    <label for="kilometrosPromedioPro">Prom. de kilómetros recorridos:</label>
                                    <div class="input-group-sm">
                                        <input type="text" class="form-control" name="kilometrosPromedioPro" id="kilometrosPromedioPro">
                                    </div>
                                </div>
                                <div class="col-md-4 form-group">
                                    <label for="">Frecuencia de viajes:</label>
                                    <div class="input-group-sm">
                                        <input type="text" class="form-control" name="frecuenciaViajes" id="frecuenciaViajes">
                                    </div>
                                </div>
                                <div class="col-md-2 form-group">
                                    <label for="seCargaPro" class="">Se Carga:() </label>
                                    <div class="input-group input-group-sm">
                                        <select id="seCargaPro" name="seCargaPro" class="form-control selectpicker" data-live-search="true">
                                        </select>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-default"></button>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-2 form-group">
                                    <label for="seDescargaPro" class="">Se Descarga:() </label>
                                    <div class="input-group input-group-sm">
                                        <select id="seDescargaPro" name="seDescargaPro" class="form-control selectpicker" data-live-search="true">
                                        </select>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-default"></button>
                                        </span>
                                    </div>
                                </div>

                                <div class="col-md-2 form-group">
                                    <label for="manejoEfectivoPro" class="">Man. de Efectivo() </label>
                                    <div class="input-group input-group-sm">
                                        <select id="manejoEfectivoPro" name="manejoEfectivoPro" class="form-control selectpicker" data-live-search="true">
                                        </select>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-default"></button>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-2 form-group">
                                    <label for="diasLibresProyecto">Dias Libres:</label>
                                    <div class="input-group-sm">
                                        <input type="number" class="form-control" name="diasLibresProyecto" id="diasLibresProyecto">
                                    </div>
                                </div>
                                <div class="col-md-12 form-group">
                                    <label for="comentarioOperacionPro">Comentario():</label>
                                    <textarea class="form-control" rows="1" id="comentarioOperacionPro" name="comentarioOperacionPro"></textarea>
                                </div>

                            </div> <!-- body box  -->
                            <!-- /.box -->
                        </div><!-- /.box -->
                    </div> <!-- col md 8 tabla-->
                    <!-- tarifas propuestas -->
                    <div class="col-md-12">
                        <div class="box box-primary box-solid" id="">
                            <!--  formulario para detalle de almacen -->
                            <div class="box-header with-border text-center">TARIFAS TARGET</div>
                            <div class="box-body">
                                <div class="col-md-6">
                                    <div class="panel panel-default">
                                        <div class="panel-body">
                                            <div class="col-md-6 form-group">
                                                <label for="tipounidadTarget" class="">Tipo de Unidad(*) </label>
                                                <div class="input-group input-group-sm">
                                                    <select id="tipounidadTarget" name="tipounidadTarget" class="form-control selectpicker" data-live-search="true">
                                                    </select>
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-default"></button>
                                                    </span>
                                                </div>
                                                <input type="hidden" name="idtarifatarget" id="idtarifatarget">
                                            </div>
                                            <div class="col-md-6 form-group">
                                                <label for="FianzaTarget" class="">Fianza() </label>
                                                <div class="input-group input-group-sm">
                                                    <select id="FianzaTarget" name="FianzaTarget" class="form-control selectpicker" data-live-search="true">
                                                    </select>
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-default"></button>
                                                    </span>
                                                </div>
                                            </div>

                                            <div class="col-md-4 form-group">
                                                <label for="">Tarifa Venta(*)</label>
                                                <div class="input-group-sm">
                                                    <input type="number" class="form-control" name="tarifaVentaFleteProyecto" id="tarifaVentaFleteProyecto">
                                                </div>
                                            </div>
                                            <div class="col-md-4 form-group">
                                                <label for="">Tarifa Costo(*)</label>
                                                <div class="input-group-sm">
                                                    <input type="number" class="form-control" name="tarifaCostoFleteProyecto" id="tarifaCostoFleteProyecto">
                                                </div>
                                            </div>
                                            <div class="col-md-4 form-group">
                                                <label for="monedaTargetProyecto" class="">.</label>
                                                <div class="input-group input-group-sm">
                                                    <select id="monedaTargetProyecto" name="monedaTargetProyecto" class="form-control selectpicker" data-live-search="true">
                                                    </select>
                                                    <!-- <span class="input-group-btn">
                                                <button type="button" class="btn btn-default" disabled></button>
                                            </span> -->
                                                </div>
                                            </div>

                                            <div class="col-md-12 form-group">
                                                <label for="lugarCargaTarget">Lugar de Carga():</label>
                                                <textarea class="form-control" rows="1" id="lugarCargaTarget" name="lugarCargaTarget"></textarea>
                                            </div>

                                            <div class="col-md-12 form-group">
                                                <label for="lugarDescargaTarget">Lugar Descarga():</label>
                                                <textarea class="form-control" rows="1" id="lugarDescargaTarget" name="lugarDescargaTarget"></textarea>
                                            </div>

                                            <div class="col-md-12 form-group col-md-offset-4">
                                                <button type="button" class="btn btn-primary" onclick="registraTarifasTarget()">Registrar <span class="fa fa-plus-circle"></span> </button>
                                            </div>

                                        </div> <!-- body box  -->
                                    </div>
                                </div>
                                <div class="col-md-6">

                                    <div class="panel panel-default">
                                        <div class="panel-body table-responsive">
                                            <table class="table table-bordered table-hover table-responsive table-hover" id="tTarifasTarget">
                                                <thead>
                                                    <tr>
                                                        <th>Acciones</th>
                                                        <th>Tipo Carga</th>
                                                        <th>Fianza</th>
                                                        <th>Tarifa Venta</th>
                                                        <th>Tarifa Costo</th>
                                                        <th></th>
                                                        <th>Lugar Carga</th>
                                                        <th>Lugar Descarga</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="tbodytarifastarget">

                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div> <!-- col md 8 tabla-->
                    <div class="col-md-12">
                        <div class="box box-primary box-solid" id="">
                            <!--  formulario para detalle de almacen -->
                            <div class="box-header with-border text-center">TARIFAS TARGET SERVICIOS ADICIONALES</div>
                            <div class="box-body">
                                <div class="col-md-6">
                                    <div class="panel panel-default">
                                        <div class="panel-body">
                                            <div class="col-md-12 form-group">
                                                <label for="servicioTarget" class="">Servicio(*) </label>
                                                <div class="input-group input-group-sm">
                                                    <select id="servicioTarget" name="servicioTarget" class="form-control selectpicker" data-live-search="true">
                                                    </select>
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-success fa fa-plus" data-target="#modalCatalogo" onclick="modalCalogoEvaluacion()"></button>
                                                    </span>
                                                </div>
                                            </div>
                                            <input type="hidden" name="idserviciotarget" id="idserviciotarget">
                                            <div class="col-md-4 form-group">
                                                <label for="">Tarifa Venta(*)</label>
                                                <div class="input-group-sm">
                                                    <input type="number" class="form-control" name="tarifaVentaServicioT" id="tarifaVentaServicioT">
                                                </div>
                                            </div>
                                            <div class="col-md-4 form-group">
                                                <label for="">Tarifa Costo(*)</label>
                                                <div class="input-group-sm">
                                                    <input type="number" class="form-control" name="tarifaCostoServicioT" id="tarifaCostoServicioT">
                                                </div>
                                            </div>
                                            <div class="col-md-4 form-group">
                                                <label for="monedaServicioT" class="">.</label>
                                                <div class="input-group input-group-sm">
                                                    <select id="monedaServicioT" name="monedaServicioT" class="form-control selectpicker" data-live-search="true">
                                                    </select>
                                                    <!-- <span class="input-group-btn">
                                                <button type="button" class="btn btn-default" disabled></button>
                                            </span> -->
                                                </div>
                                            </div>
                                            <div class="col-md-12 form-group">
                                                <label for="lugarCargaTargetServicios">Lugar de Carga():</label>
                                                <textarea class="form-control" rows="1" id="lugarCargaTargetServicios" name="lugarCargaTargetServicios"></textarea>
                                            </div>

                                            <div class="col-md-12 form-group">
                                                <label for="lugarDescargaTargetServicios">Lugar Descarga():</label>
                                                <textarea class="form-control" rows="1" id="lugarDescargaTargetServicios" name="lugarDescargaTargetServicios"></textarea>
                                            </div>

                                            <div class="col-md-12 form-group col-md-offset-4">
                                                <button type="button" class="btn btn-primary" onclick="grabaServicioTarget()">Registrar <span class="fa fa-plus-circle"></span> </button>
                                            </div>

                                        </div> <!-- body box  -->
                                    </div>
                                </div>
                                <div class="col-md-6">

                                    <div class="panel panel-default">
                                        <div class="panel-body table-responsive">
                                            <table class="table table-bordered table-hover table-responsive table-hover" id="tServcioTarget">
                                                <thead>
                                                    <tr>
                                                        <th>Acciones</th>
                                                        <th>Servicio</th>
                                                        <th>Tarifa Venta</th>
                                                        <th>Tarifa Costo</th>
                                                        <th></th>
                                                        <th>Lugar Carga</th>
                                                        <th>Lugar Descarga</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="tbodytarifasserviciosadicional">

                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="col-md-12">
                        <div class="box box-primary box-solid">
                            <div class=" box-header with-border text-center">
                                DATOS DE TRIPULACION
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-body table-responsive">
                                    <table class="table table-bordered table-hover table-responsive table-hover" id="tDatosTripulacion" style="text-align: center;">
                                        <thead>
                                            <tr>
                                                <th>Botas</th>
                                                <th>Chaleco</th>
                                                <th>Lentes</th>
                                                <th>Guantes</th>
                                                <th>Mascarilla</th>
                                                <th>Careta</th>
                                                <th>Otros</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <th style="text-align: center;">
                                                <div class="form-check">
                                                    <input id="botasVenta" class="form-check-input" type="checkbox" name="botasVenta" value=1>
                                                </div>
                                            </th>
                                            <th style="text-align: center;">
                                                <div class="form-check">
                                                    <input id="chalecoVenta" class="form-check-input" type="checkbox" name="chalecoVenta" value=1>
                                                </div>
                                            </th>
                                            <th style="text-align: center;">
                                                <div class="form-check">
                                                    <input id="lentesVenta" class="form-check-input" type="checkbox" name="lentesVenta" value=1>
                                                </div>
                                            </th>
                                            <th style="text-align: center;">
                                                <div class="form-check">
                                                    <input id="guantesVenta" class="form-check-input" type="checkbox" name="guantesVenta" value=1>
                                                </div>
                                            </th>
                                            <th style="text-align: center;">
                                                <div class="form-check">
                                                    <input id="mascarillaVenta" class="form-check-input" type="checkbox" name="mascarillaVenta" value=1>
                                                </div>
                                            </th>
                                            <th style="text-align: center;">
                                                <div class="form-check">
                                                    <input id="caretaVenta" class="form-check-input" type="checkbox" name="caretaVenta" value=1>
                                                </div>
                                            </th>
                                            <th>
                                                <div class="input-group-sm">
                                                    <input type="text" name="otrosVenta" id="otrosVenta" class="form-control" onkeyup="mayusculas(this)">
                                                </div>
                                            </th>
                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>
                    </div> <!-- col md 12 tabla-->

                    <div class="col-md-12">
                        <div class="box box-primary box-solid">
                            <div class=" box-header with-border text-center">
                                ARCHIVOS
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-body table-responsive">
                                    <div class="form-group col-md-12">
                                        <label for="Archivos" class="col-form-label">Archivos:</label>
                                        <input type="file" name="archivosEvaProyecto[]" id="archivosEvaProyecto" class="form-control" multiple onchange="agregaPreviuw(this)">
                                    </div>

                                    <div class="col-md-12 CreaMPreviw" id="CreaMPreviw"></div>

                                    <div class="panel-body table-responsive col-md-8">
                                        <table class="table table-condensed table-hover table-bordered" id="" style="text-align:center;">
                                            <thead>
                                                <th>#</th>
                                                <th>Nombre Archivo</th>
                                                <th>Archivo</th>
                                                <th>Eliminar</th>
                                                <th>Descargar</th>
                                            </thead>
                                            <tbody id="tbodyarchivosEvaP">
                                            </tbody>
                                        </table>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div> <!-- col md 12 tabla-->

                    <div class="col-md-12">
                        <div class="box box-primary " id="">
                            <!--  formulario para detalle de almacen -->
                            <div class="box-header with-border text-center"></div>
                            <div class="box-body">


                            </div> <!-- body box  -->
                            <div class="box-footer">

                                <button type="button" class="btn btn-success fa fa-floppy-o" onclick="grabarProyecto()" id="btnGrabarProyecto">Grabar</button>
                                <button type="button" class="btn btn-danger fa fa-close" onclick="cancelarProyecto()"> Cancelar</button>
                                <button type="button" class="btn btn-primary fa fa-file-pdf-o" onclick="reporteEvaluacion(1)" id="btnReporteEvaluacion"> Reporte</button>
                                <button type="button" class="btn btn-primary fa fa-envelope" onclick="reporteEvaluacion(2)" id="btnReporteEvaluacion"> Email</button>

                            </div>
                            <!-- /.box -->
                        </div><!-- /.box -->
                    </div> <!-- col md 12 tabla-->
                </div>
            </form>
            <div class="row" id="listadoEvaluacionesProyecto">
                <div class="col-md-12">
                    <div class="box  box-solid">
                        <div class=" box-header with-border">
                            <button type="button" class="btn btn-primary" onclick="nuevoProyecto()">Nuevo Proyecto<span class="fa  fa-plus"></span>
                            </button>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-body table-responsive">
                                <table class="table table-bordered table-hover table-responsive table-hover" id="tProyectos">
                                    <thead>
                                        <tr>
                                            <th>Acciones</th>
                                            <th>Codigo</th>
                                            <th>Cliente</th>
                                            <th>Inicio</th>
                                            <th>Finalizacion</th>
                                            <th>Tipo Carga</th>
                                            <th>Fianza</th>
                                            <th>Peso</th>
                                            <th>Pies Cubicos</th>
                                            <th>Mercaderia</th>
                                            <th>Permisos</th>
                                            <th>Promedio Entregas</th>
                                            <th>Promedio Recorrido</th>
                                            <th>Frecuencia Viajes</th>
                                            <th>Se Carga</th>
                                            <th>Se Descarga</th>
                                            <th>Maneja Efectivo</th>
                                            <th>Descripcion Proyecto</th>
                                            <th>Dias Libre</th>
                                            <th>Comentario Operacion</th>
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
    <script src="scritps/catalogo.js"></script>
    <script src="scritps/evaluacionProyecto.js"></script>


<?php }
ob_end_flush();
?>