<div class="modal fade" id="modalFacturaAlmacen" tabindex="-1" role="dialog" aria-labelledby="basicModal"
    aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title text-center" id="">Factura Almacen</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <form id="frmFacturaAlmacen form-horizontal">
                        <div class="col-md-4">
                            <label for="control-label col-md-4">No Factura(*):</label>
                            <div class="form-group input-group-sm">
                                <input type="text" class="form-control input-sm" name="noFactura" id="noFactura">
                            </div>
                        </div>
                        <div class="form-group col-md-4">
                            <label for="liberado"></label>
                            <div class="form-check">
                                <label for="credito" class="form-check-label">Credito:</label>
                                <input id="credito" class="form-check-input" type="checkbox" name="credito" value=1>
                            </div>
                        </div>
                        <div class="form-group col-md-4">
                            <label for="liberado"></label>
                            <div class="form-check">
                                <label for="contado" class="form-check-label">Contado:</label>
                                <input id="contado" class="form-check-input" type="checkbox" name="contado" value=1>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <label for="">A nombre De(*):</label>
                            <div class="form-group input-group-sm">
                                <input type="text" class="form-control input-sm" name="clienteFactura"
                                    id="clienteFactura">
                            </div>
                        </div>
                        <div class="form-group col-md-12">
                            <label for="">Direccion(*):</label>
                            <textarea class="form-control" id="direccionFactura" name="direccionFactura" rows="2"
                                cols="1" onkeyup="mayusculas(this)"></textarea>
                        </div>
                        <div class="col-md-6">
                            <label for="">Nit(*):</label>
                            <div class="form-group input-group-sm">
                                <input type="text" class="form-control input-sm" name="nitFactura" id="nitFactura">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="">Poliza(*):</label>
                            <div class="form-group input-group-sm">
                                <input type="text" class="form-control input-sm" name="polizaFactura"
                                    id="polizaFactura">
                            </div>
                        </div>
                        <div class="col-md-12">
                            <label for="">Concepto(*):</label>
                            <div class="form-group input-group-sm">
                                <input type="text" class="form-control input-sm" name="descripcionFactura"
                                    id="descripcionFactura">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="">Total(*):</label>
                            <div class="form-group input-group-sm">
                                <input type="text" class="form-control input-sm" name="totalFactura" id="totalFactura">
                            </div>
                        </div>
                        <div class="col-md-2">
                            <label for="">.</label>
                            <div class="form-group input-group-sm">
                                <input type="text" class="form-control input-sm" name="monedaFactura"
                                    id="monedaFactura">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <label for="">Tipo C.:</label>
                            <div class="form-group input-group-sm">
                                <input type="number" class="form-control input-sm" name="tipocFacturaAlmacen"
                                    id="tipocFacturaAlmacen">
                            </div>
                        </div>
                        <div class="form-group col-md-12">
                            <label for="">Total Letras:</label>
                            <textarea type="text" class="form-control" name="totalletrasFactura" id="totalletrasFactura"
                                onkeyup="mayusculas(this)" rows="1" cols="1">
                                </textarea>
                        </div>
                        <div class="form-group col-md-12">
                            <label for="comment">Observaciones(*):</label>
                            <textarea class="form-control" rows="1" id="observacionesFactura"
                                name="observacionesFactura"></textarea>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="" 
                    onclick="grabarFacturaAlmacen()">Grabar
                    <span class="fa fa-floppy-o"></span>
                </button>
                
                <button type="button" class="btn btn-default" id="" 
                    onclick="reporteFactura()">Imprimir
                    <span class="fa fa-floppy-o"></span>
                </button>

                <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar
                    <span class="fa fa-close"></span>
                </button>

            </div>
        </div>
    </div>
</div>