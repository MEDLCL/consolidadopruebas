<div class="modal fade" id="modalPlantillaAlmacen" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title text-center" id="myModalLabel">Plantilla Almacen</h4>
            </div>
            <div class="modal-body">
                <form id="frmNuevaPlantillaA">
                    <div class="form-group col-md-12">
                        <label for="plantillaBG" class="col-form-label">Busqueda:</label>
                        <select id="plantillaBG" name="plantillaBG" class="form-control selectpicker" data-live-search="true">

                        </select>
                    </div>

                    <div class="form-group col-md-12">
                        <label for="nombrePlantillaG" class="col-form-label">Nombre(*):</label>
                        <input type="text" name="nombrePlantillaG" id="nombrePlantillaG" class="form-control">
                    </div>
                    <div class="form-group col-md-5">
                        <label for="tarifaMinimaG" class="control-label">Tarifa Minima(*):</label>
                        <input type="number" name="tarifaMinimaG" id="tarifaMinimaG" class="form-control">
                    </div>
                    <div class="form-group col-md-3">
                        <label for="monedaPlantillaG" class="col-form-label">Moneda:(*)</label>
                        <select name="monedaPlantillaG" id="monedaPlantillaG" class="form-control selectpicker" data-live-search="true">
                        </select>
                    </div>

                    <div class="form-group col-md-4">
                        <label for="diasLibresPlantillaG" class="control-label">Dias Libres(*):</label>
                        <input type="number" name="diasLibresPlantillaG" id="diasLibresPlantillaG" class="form-control">
                        <input type="hidden" name="idplantillaG" id="idplantillaG">
                    </div>
                    <div class="form-group col-md-12">
                        <div class="form-check">
                            <input id="omitirDiasLibre" class="form-check-input" type="checkbox" name="omitirDiasLibre" value=1>
                            <label for="omitirDiasLibre" class="col-form-label">Omitir dias libres Almacenaje:</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="" class="col-form-label">.</label>
                    </div>
                </form>
            </div>
            <div class="modal-footer">

                <button type="button" class="btn btn-default" onclick="limpiarPlantillaG()">Nuevo
                    <span class="fa fa-file-o"></span></button>

                <button type="button" class="btn btn-primary" id="grabarNuevaP" disabled = "false" onclick="grabarPlnatillaAlmacen()">Grabar
                    <span class="fa fa-floppy-o"></span></button>

                <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar
                    <span class="fa fa-close"></span></button>
            </div>
        </div>
    </div>
</div>