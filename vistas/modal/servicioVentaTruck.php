<div class="modal fade" id="modalServicioAdicionalVentaTruck" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title text-center" id="myModalLabel">Servicio Adicional</h4>
            </div>
            <div class="modal-body">
                
                    <div class="col-md-12 form-group">
                        <label for="servicioVentaTruck" class="">Servicio(*) </label>
                        <div class="input-group input-group-sm">
                            <select id="servicioVentaTruck" name="servicioVentaTruck" class="form-control selectpicker" data-live-search="true">
                            </select>
                            <span class="input-group-btn">
                                <button type="button" class="btn btn-success" data-target="#modalCatalogo" onclick="catalogollama()"><span class="fa fa-plus"></span> </button>
                            </span>
                        </div>
                        <input type="hidden" name="idservicioadicional" id="idservicioadicional">
                    </div>
                    <div class="col-md-3 form-group">
                        <label for="">Tarifa Venta(*)</label>
                        <div class="input-group-sm">
                            <input type="number" class="form-control" name="servicioTarifaVenta" id="servicioTarifaVenta">
                        </div>
                    </div>
                    <div class="col-md-3 form-group">
                        <label for="">Tarifa Costo(*)</label>
                        <div class="input-group-sm">
                            <input type="number" class="form-control" name="servicioTarifaCosto" id="servicioTarifaCosto">
                        </div>
                    </div>
                    <div class="col-md-3 form-group">
                        <label for="servicioMonedaVenta" class="">.</label>
                        <div class="input-group input-group-sm">
                            <select id="servicioMonedaVenta" name="servicioMonedaVenta" class="form-control selectpicker" data-live-search="true">
                            </select>
                            <!-- <span class="input-group-btn">
                                                <button type="button" class="btn btn-default" disabled></button>
                                            </span> -->
                        </div>
                    </div>
                    <div class="col-md-3 form-group">
                        <label for="">Cantidad(*)</label>
                        <div class="input-group-sm">
                            <input type="number" class="form-control" name="servicioCantidadVenta" id="servicioCantidadVenta">
                        </div>
                    </div>
                    <div class="col-md-6 form-group">
                        <label for="servicioOrigenVenta">Origen(*):</label>
                        <textarea class="form-control" rows="1" id="servicioOrigenVenta" name="servicioOrigenVenta"></textarea>
                    </div>
                    <div class="col-md-6 form-group">
                        <label for="servicioDestinoVenta">Destino(*):</label>
                        <textarea class="form-control" rows="1" id="servicioDestinoVenta" name="servicioDestinoVenta"></textarea>
                    </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="grabarNuevaP" onclick="grabarEditarServicioAdicional()">Grabar
                    <span class="fa fa-floppy-o"></span></button>

                <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar
                    <span class="fa fa-close"></span></button>
            </div>
        </div>
    </div>
</div>