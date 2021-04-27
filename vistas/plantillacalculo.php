<div class="row" id="plantillaCalculoAlmacen">
    <div class="col-md-12">
        <div class="box box-info">
            <div class="box-header with-border"></div>
            <div class="box-body">

                <form action="" method="POST" class="" role="form" id="frmDetallePlnatillaA">
                    <div class="form-group col-md-5">
                        <label for="agregarPlantilla" class="">Nombre Plantilla</label>
                        <div class="input-group input-group-sm">
                            <select id="agregarPlantilla" name="agregarPlantilla" class="form-control selectpicker" data-live-search="true">
                            </select>
                            <span class="input-group-btn">
                                <button type="button" class="btn btn-info fa fa-plus" data-toggle="modal" data-target="#modalPlantillaAlmacen" id="btnmodalPlantilla"></button>
                            </span>

                            <input type="hidden" name="idplantillaMP" id="idplantillaMP" class="form-control">
                            <input type="hidden" name="idMonedaPlantillaMP" id="idMonedaPlantillaMP">
                            <input type="hidden" name="iddetallePlnatilla" id="iddetallePlnatilla">
                        </div>
                    </div>
                    <div class="form-group col-md-2">
                        <label for="tarifaMinimaMP" class="control-label">Tarifa Minima(*):</label>
                        <input type="text" name="tarifaMinimaMP" id="tarifaMinimaMP" class="form-control" readonly>
                    </div>
                    <div class="form-group col-md-2">
                        <label for="diasLibresPlantillaMP" class="control-label">Dias Libres(*):</label>
                        <input type="number" name="diasLibresPlantillaMP" id="diasLibresPlantillaMP" class="form-control" readonly>
                    </div>
                    <div class="form-group col-md-3">
                        <label for="liberado"></label>
                        <div class="form-check">
                            <input id="omitirDias" class="form-check-input" type="checkbox" name="omitirDias" value=1 disabled>
                            <label for="omitirDias" class="form-check-label">Omitir dias libres Almacenaje:</label>
                        </div>
                    </div>

                    <div class="col-md-12"></div>
                    <!-- <div id="detallePlantillaCalculo"> -->
                    <!-- <div class="row"> -->
                    <div class="col-md-4" style="padding-left: 0px; padding-right:0px; ">
                        <div class="form-group col-md-12" style="padding-right: 0px;">
                            <label for="catalogoPlantillaAlmacen" class="">Descripcion</label>
                            <div class="input-group input-group-sm">
                                <select id="catalogoPlantillaAlmacen" name="catalogoPlantillaAlmacen" class="form-control selectpicker" data-live-search="true">
                                </select>
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-info fa fa-plus" data-toggle="modal" data-target="#modalCatalogo" id="btnmodalcatalogoPA" onclick="nuevoCatalogoCalculoA()"></button>
                                </span>
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="minimoDetallePlantillaA" class="control-label">Minimo:</label>
                            <input type="number" name="minimoDetallePlantillaA" id="minimoDetallePlantillaA" class="form-control">
                        </div>
                        <div class="form-group col-md-6">
                            <label for=""></label>
                            <div class="form-check">
                                
                                <input id="porPeso" class="form-check-input" type="checkbox" name="porPeso" value=1>
                                <label for="porPeso" class="form-check-label">por Peso:</label>
                            </div>
                        </div>
                        <div class="col-md-12"></div>
                        <div class="form-group col-md-6">
                            <label for="tarifaDetallePlantillaA" class="control-label">Tarifa:</label>
                            <input type="number" name="tarifaDetallePlantillaA" id="tarifaDetallePlantillaA" class="form-control">
                        </div>
                        <div class="form-group col-md-6">
                            <label for=""></label>
                            <div class="form-check">
                                
                                <input id="porVolumen" class="form-check-input" type="checkbox" name="porVolumen" value=1>
                                <label for="porVolumen" class="form-check-label">por Volumen:</label>
                            </div>
                            
                        </div>
                        <div class="col-md-12"></div>
                        <div class="form-group col-md-6">
                            <label for="porcentajeDetallePA" class="control-label">%:</label>
                            <input type="number" name="porcentajeDetallePA" id="porcentajeDetallePA" class="form-control">
                        </div>
                        <div class="form-group col-md-6">
                        <label for=""></label>
                            <div class="form-check">
                                <input id="porDia" class="form-check-input" type="checkbox" name="porDia" value=1>
                                <label for="porDia" class="form-check-label">por Dia:</label>
                            </div>
                            <label for="porDia"></label>
                        </div>
                        <!-- <div class="form-check col-md-6">
                            <label for="porPeso" class="control-label">* Por Peso</label>
                            <input type="checkbox" name="porPeso" id="porPeso" class="form-check-label">
                        </div> -->
                        
                    </div> <!-- col md 4 -->
                    <div class="col-md-8">
                        <div class="panel-body table-responsive">
                            <table class="table table-condensed table-hover table-bordered" id="TplantillaG">
                                <thead>
                                    <th>Descripcion</th>
                                    <th>Signo</th>
                                    <th>Valor</th>
                                    <th>sumarValor</th>
                                    <th>Ocultar</th>
                                    <th>Prorratear</th>
                                    <th>Descuento</th>
                                </thead>
                                <tbody id="tbodyPlnatillaG">
                                </tbody>
                            </table>
                        </div>
                    </div> <!-- col md 8 tabla -->
                    <!-- </div> -->
                    <!--  row -->
                    <!-- </div> -->
                    <!-- div area de formulas -->

                    <div class="col-md-12"></div>
                    <div class="box-footer col-md-12">
                        <button type="button" class="btn btn-large btn-primary" onclick="nuevoDetallePlantilla()">Nuevo</button>

                        <button type="button" class="btn btn-large btn-info" id="btnGrabarDetallePlantilla" onclick="grabarDetallePlantilla()">Grabar
                            <span class="fa fa-floppy-o"></span>
                        </button>

                        <button type="button" class="btn btn-large btn-danger">Cancelar
                            <span class="fa fa-close"></span>
                        </button>

                    </div>

                </form>
            </div> <!-- box body -->
        </div>

    </div>
</div>