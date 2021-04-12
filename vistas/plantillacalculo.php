<div class="row" id="plantillaCalculoAlmacen">
    <div class="col-md-12">
        <div class="box box-info">
            <div class="box-header with-border"></div>
            <div class="box-body">

                <form action="" method="POST" class="" role="form">
                    <div class="form-group col-md-5">
                        <label for="agregarPlantilla" class="">Nombre Plantilla</label>
                        <div class="input-group input-group-sm">
                            <select id="agregarPlantilla" name="agregarPlantilla" class="form-control selectpicker" data-live-search="true">
                            </select>
                            <span class="input-group-btn">
                                <button type="button" class="btn btn-info fa fa-plus" data-toggle="modal" data-target="#modalPlantillaAlmacen" id="btnmodalPlantilla"></button>
                            </span>
                        </div>
                    </div>
                    <div class="form-group col-md-2">
                        <label for="cif" class="control-label">Tarifa Minima(*):</label>
                        <input type="number" name="tarifaMinimaMP" id="tarifaMinimaMP" class="form-control" onkeyup="sumaCifImpuesto()">
                    </div>
                    <div class="form-group col-md-2">
                        <label for="cif" class="control-label">Dias Libres(*):</label>
                        <input type="number" name="diasLibresPlantillaMP" id="diasLibresPlantillaMP" class="form-control" onkeyup="sumaCifImpuesto()">
                    </div>
                    <div class="form-group col-md-3">
                        <label for="liberado"></label>
                        <div class="form-check">
                            <input id="omitirDias" class="form-check-input" type="checkbox" name="omitirDias" value=1>
                            <label for="omitirDias" class="form-check-label">Omitir dias libres Almacenaje:</label>
                        </div>
                    </div>

                    <div class="col-md-12"></div>

                    <div id="detallePlantillaCalculo">
                        <div class="row">
                            <div class="col-md-4">
                                <!-- <div class="form-group col-md-12">
                                    <label for="cif" class="control-label">CIF:</label>
                                    <div class="input-group">
                                        <div class="input-group-addon">
                                            <span>$.</span>
                                        </div>
                                        <input type="number" name="a" id="a" class="form-control" onkeyup="calcularCifDolares()">
                                    </div>
                                </div>

                                <div class="form-group col-md-12">
                                    <label for="cif" class="control-label">CIF(*):</label>
                                    <div class="input-group">
                                        <div class="input-group-addon">

                                        </div>
                                        <input type="number" name="" id="" class="form-control" onkeyup="sumaCifImpuesto()">
                                    </div>
                                </div>


                                <div class="form-group col-md-12">
                                    <label for="impuestoCalculo" class="control-label">Impuesto(*):</label>
                                    <div class="input-group">
                                        <div class="input-group-addon">

                                        </div>
                                        <input type="number" name="" id="" class="form-control" onkeyup="sumaCifImpuesto()">
                                    </div>
                                </div>

                                <div class="form-group col-md-12">
                                    <label for="pesoCalculo" class="control-label">Base Seguro:</label>
                                    <input type="number" name="" id="" class="form-control" readonly>
                                </div>

                                <div class="form-group col-md-12">
                                    <label for="puesto" class="control-label">Bultos totales:</label>
                                    <input type="text" name="" id="" class="form-control" readonly>
                                </div> -->

                            </div>
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
                        </div><!--  row -->
                    </div><!-- div area de formulas -->

                    <div class="col-md-12"></div>
                    <div class="box-footer">
                        <button type="button" class="btn btn-large btn-primary">Nuevo</button>

                        <button type="button" class="btn btn-large btn-info">Grabar
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