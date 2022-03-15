<div class="modal fade" id="modalventafletetruck" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title text-center" id="myModalLabel">Flete</h4>
            </div>
            <div class="modal-body">
                <div class="col-md-3 form-group">
                    <label for="">Tarifa Venta(*)</label>
                    <div class="input-group-sm">
                        <input type="number" class="form-control" name="tarifaVentaFleteMV" id="tarifaVentaFleteMV">
                    </div>
                </div>
                <input type="hidden" name="idfleteadicionalm" id="idfleteadicionalm">
                <div class="col-md-3 form-group">
                    <label for="">Tarifa Costo(*)</label>
                    <div class="input-group-sm">
                        <input type="number" class="form-control" name="tarifaCostoFleteMV" id="tarifaCostoFleteMV">
                    </div>
                </div>
                <div class="col-md-3 form-group">
                    <label for="monedaFleteMV" class="">.</label>
                    <div class="input-group input-group-sm">
                        <select id="monedaFleteMV" name="monedaFleteMV" class="form-control selectpicker" data-live-search="true">
                        </select>
                        <!-- <span class="input-group-btn">
                                                <button type="button" class="btn btn-default" disabled></button>
                                            </span> -->
                    </div>
                </div>
                <div class="col-md-12 form-group"></div>
                <div class="col-md-3 form-group">
                    <label for="tipounidadFleteVenta" class="">Tipo Unidad</label>
                    <div class="input-group input-group-sm">
                        <select id="tipounidadFleteVenta" name="tipounidadFleteVenta" class="form-control selectpicker" data-live-search="true">
                        </select>
                    </div>
                </div>

                <div class="col-md-3 form-group">
                    <label for="">No. Unidades(*)</label>
                    <div class="input-group-sm">
                        <input type="number" class="form-control input-sm" name="unidadesFleteMV" id="unidadesFleteMV">
                    </div>
                </div>
                <div class="col-md-3 form-group">
                    <label for="">Hora(*)</label>
                    <div class="input-group-sm">
                        <input type="time" class="form-control" name="horaFleteMV" id="horaFleteMV">
                    </div>
                </div>
                <div class="col-md-4 form-group">
                    <label for="">Fecha Pos.(*)</label>
                    <div class="input-group-sm">
                        <input type="date" class="form-control" name="fechaPosFleteMV" id="fechaPosFleteMV">
                    </div>
                </div>
                <div class="col-md-3 form-group">
                    <label for="">Dias Libres(*)</label>
                    <div class="input-group-sm">
                        <input type="number" class="form-control" name="diaslibreFleteMV" id="diaslibreFleteMV">
                    </div>
                </div>
                <div class="col-md-3 form-group">
                    <label for="tipocargaFleteMV" class="">Tipo Carga</label>
                    <div class="input-group input-group-sm">
                        <select id="tipocargaFleteMV" name="tipocargaFleteMV" class="form-control selectpicker" data-live-search="true">
                        </select>
                        <!-- <span class="input-group-btn">
                                                <button type="button" class="btn btn-default" disabled></button>
                                            </span> -->
                    </div>
                </div>
                
                <div class="col-md-6 form-group">
                    <label for="origenFleteMV">Origen(*):</label>
                    <textarea class="form-control" rows="1" id="origenFleteMV" name="origenFleteMV"></textarea>
                </div>
                <div class="col-md-6 form-group">
                    <label for="desitinoFleteMV">Destino(*):</label>
                    <textarea class="form-control" rows="1" id="desitinoFleteMV" name="desitinoFleteMV"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <div class="col-md-2">
                    <button type="button" class="btn btn-primary" id="grabarNuevaP" onclick="grabarEditarFleteAdicional()">Grabar
                        <span class="fa fa-floppy-o"></span></button>
                </div>
                <div class="col-md-2">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar
                        <span class="fa fa-close"></span></button>
                </div>
            </div>
        </div>
    </div>
</div>