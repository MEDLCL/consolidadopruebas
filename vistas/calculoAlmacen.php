<div class="row" id="calculoAlmacen">
    <div class="col-md-12">
        <div class="box box-info">
            <div class="box-header with-border"></div>
            <div class="box-body">

                <form action="" method="POST" class="" role="form">
                    <div class="form-group col-md-6">
                        <label for="clienteCalculoA" class="">Cliente/Consignado(*) </label>
                        <div class="input-group input-group-sm">

                            <select id="clienteCalculoA" name="clienteCalculoA" class="form-control selectpicker" data-live-search="true">
                            </select>
                            <span class="input-group-btn">
                                <button type="button" class="btn btn-info fa fa-building" disabled></button>
                            </span>
                        </div>
                    </div>

                    <div class="form-group col-md-2">
                        <label>Poliza Da:</label>
                        <input type="text" class="form-control input-sm" name="polizaEntradaCalculo" id="polizaEntradaCalculo" readonly>
                        <input type="hidden" name="id_detalleA_calculo" id="id_detalleA_calculo">
                    </div>

                    <div class="form-group col-md-2">
                        <label>Total Dias:</label>
                        <input type="text" class="form-control input-sm" name="totalDias" id="totalDias" readonly>
                    </div>

                    <!-- <div class="form-group col-md-2">
                        <label>Dias Calculo:</label>
                        <input type="text" class="form-control input-sm" name="diasCaclculo" id="diasCalculo" readonly>
                    </div>-->
                    <div class="form-group col-md-2">
                        <label>Dias Almacenaje:</label>
                        <input type="text" class="form-control input-sm" name="diasAlmacenaje" id="diasAlmacenaje" readonly>
                    </div>
                    <div class="col-md-12"></div>
                    <div class="form-group col-md-4">
                        <label for="comment">Direccion(*):</label>
                        <textarea class="form-control" rows="2" id="direccionCalculo" name="direccionCalculo"></textarea>
                    </div>
                    <div class="form-group col-md-2">
                        <label>Nit(*):</label>
                        <input type="text" class="form-control" name="nitCalculo" id="nitCalculo">
                    </div>

                    <!--  <div class="form-group col-md-3">
                        <label>Dias Almacenaje:</label>
                        <input type="text" class="form-control input-sm" name="diasAlmacenaje" id="diasAlmacenaje" readonly>
                    </div> -->

                    <div class="form-group col-md-2">
                        <label>Dias Libres:</label>
                        <input type="text" class="form-control input-sm" name="diasLibre" id="diasLibre" readonly>
                    </div>

                    <div class="col-md-12"></div>
                    <div class="form-group col-md-3">
                        <label for="" class="">Del(*):</label>
                        <div class="input-group date">
                            <div class="input-group-addon">
                                <i class="fa fa-calendar"></i>
                            </div>
                            <input type="text" class="form-control pull-right input-sm" id="delCalculoA" name="delCalculoA" readonly>
                        </div>
                    </div>

                    <div class="form-group col-md-3">
                        <label for="" class="">Al(*):</label>
                        <div class="input-group date">
                            <div class="input-group-addon">
                                <i class="fa fa-calendar"></i>
                            </div>
                            <input type="text" class="form-control pull-right input-sm" id="alCalculoA" name="alCalculoA">
                        </div>
                    </div>
                    <div class="form-group col-md-2">
                        <label>DUT:</label>
                        <input type="text" class="form-control input-sm" name="dutCalculo" id="dutCalculo">
                    </div>

                    <div class="form-group col-md-2">
                        <label>Poliza DI:</label>
                        <input type="text" class="form-control input-sm" name="polizaSalida" id="polizaSalida">
                    </div>
                    <div class="form-group col-md-2">
                        <label>Orden de Salida:</label>
                        <input type="text" class="form-control input-sm" name="ordenSalida" id="ordenSalida ">
                    </div>
                    <div class="col-md-12"></div>

                    <div class="form-group col-md-2">
                        <label for="tipoCambioCalculo" class="control-label">T. Cambio:</label>
                        <input type="number" name="tipoCambioCalculo" id="tipoCambioCalculo" class="form-control" onkeyup="calcularCifDolares()">
                    </div>

                    <div class="form-group col-md-6 col-md-offset-2">
                        <label for="consiganado" class="">Plantilla(*) </label>
                        <div class="input-group input-group-sm">

                            <select id="plantilla" name="plantilla" class="form-control selectpicker" data-live-search="true">
                            </select>

                            <input type="hidden" name="TotalMinimo" id="TotalMinimo">
                            <input type="hidden" name="diaslPC" id="diaslPC">
                            <input type="hidden" name="diascompletoPC" id="diascompletoPC">

                            <span class="input-group-btn">
                                <button type="button" class="btn btn-info fa fa-plus" onclick="nuevaPlantillaCalculo()"></button>
                            </span>
                        </div>
                    </div>
                    <div class="form-group col-md-2">
                        <label for="consiganado" class="">Descuento(*) </label>
                        <div class="input-group input-group-sm">

                            <select id="descuento" name="descuento" class="form-control selectpicker" data-live-search="true">
                            </select>
                            <span class="input-group-btn">
                            </span>
                        </div>
                    </div>

                    <div class="col-md-12"></div>

                    <div id="detallePlantillaCalculo">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group col-md-7">
                                    <label for="cif" class="control-label">CIF:</label>
                                    <div class="input-group">
                                        <div class="input-group-addon">
                                            <span>$.</span>
                                        </div>
                                        <input type="number" name="cifgtdolar" id="cifgtdolar" class="form-control" onkeyup="calcularCifDolares()">
                                    </div>
                                </div>

                                <div class="form-group col-md-5">
                                    <label for="cif" class="control-label">Peso:</label>
                                    <input type="text" name="pesoCalculo" id="pesoCalculo" class="form-control" readonly>
                                </div>
                                <!--                 <div class="form-group col-md-6">
                                    <label for="cif" class="control-label">CIF(*):</label>
                                    <input type="number" name="cifCalculo" id="cifCalculo" class="form-control" onkeyup="sumaCifImpuesto()">
                                </div> -->
                                <div class="form-group col-md-7">
                                    <label for="cif" class="control-label">CIF(*):</label>
                                    <div class="input-group">
                                        <div class="input-group-addon">

                                        </div>
                                        <input type="number" name="cifCalculo" id="cifCalculo" class="form-control" onkeyup="sumaCifImpuesto()">
                                    </div>
                                </div>
                                <div class="form-group col-md-5">
                                    <label for="cif" class="control-label">Volumen:</label>
                                    <input type="text" name="volumenCalculo" id="VolumenCalculo" class="form-control" readonly>
                                </div>

                                <!--  <div class="form-group col-md-6">
                                    <label for="impuesto" class="control-label">Impuesto(*):</label>
                                    <input type="number" name="impuestoCalculo" id="impuestoCalculo" class="form-control" onkeyup="sumaCifImpuesto()">
                                </div> -->
                                <div class="form-group col-md-7">
                                    <label for="impuestoCalculo" class="control-label">Impuesto(*):</label>
                                    <div class="input-group">
                                        <div class="input-group-addon">

                                        </div>
                                        <input type="number" name="impuestoCalculo" id="impuestoCalculo" class="form-control" onkeyup="sumaCifImpuesto()">
                                    </div>
                                </div>

                                <div class="form-group col-md-5">
                                    <label for="cif" class="control-label">Cnt. Clie.:</label>
                                    <input type="text" name="CantClientes" id="CantClientes" class="form-control">
                                </div>

                                <div class="form-group col-md-7">
                                    <label for="pesoCalculo" class="control-label">Base Seguro:</label>
                                    <input type="number" name="bSeguroCalculo" id="bSeguroCalculo" class="form-control" readonly>
                                </div>

                                <div class="form-group col-md-5">
                                    <label for="puesto" class="control-label">Cuadrilla:</label>
                                    <input type="text" name="clientesCuadrilla" id="clientesCuadrilla" class="form-control">
                                </div>

                                <div class="form-group col-md-7">
                                    <label for="puesto" class="control-label">Bultos totales:</label>
                                    <input type="text" name="bultosCalculoTotal" id="bultosCalculoTotal" class="form-control" readonly>
                                </div>
                                <div class="form-group col-md-5">
                                    <label for="puesto" class="control-label">Bultos:</label>
                                    <input type="text" name="bultosCalculoPen" id="bultosCalculoPen" class="form-control">
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="panel-body table-responsive">
                                    <table class="table table-condensed table-hover table-bordered" id="TcalculosALmacenP" style="text-align: center;">
                                        <thead>
                                            <th>Descripcion</th>
                                            <th>Signo</th>
                                            <th>Valor</th>
                                            <th>sumarValor</th>
                                            <th>Ocultar</th>
                                            <th>Prorratear</th>
                                            <th>Descuento</th>
                                        </thead>
                                        <tbody id="tbodyC">
                                        </tbody>
                                    </table>
                                </div>
                            </div> <!-- col md 8 tabla -->
                        </div><!--  row -->
                    </div><!-- div area de formulas -->
                    <div class="totalescr col-md-12">
                        <div class="form-group col-md-2 col-md-offset-4">
                            <label for="financiado" class="control-label">Finaciacion:</label>
                            <input type="text" name="financiado" id="financiado" class="form-control">
                        </div>
                        <div class="form-group col-md-2">
                            <label for="porcentajefinanciado" class="control-label">% Finaciacion:</label>
                            <input type="text" name="porcentajefinanciado" id="porcentajefinanciado" class="form-control" value= "3.50">
                        </div>
                    </div>
                    <div class="form-group col-md-4">
                    </div>

                    <div class="row totales">
                        <div class="form-group col-md-2">
                            <label for="total" class="control-label">Sub-Total</label>
                            <input type="text" name="subtotal" id="subtotal" class="form-control" readonly>
                        </div>
                        <div class="form-group col-md-2">
                            <label for="total" class="control-label">Iva</label>
                            <input type="text" name="iva" id="iva" class="form-control" readonly>
                        </div>

                        <div class="form-group col-md-2">
                            <label for="total" class="control-label">Total</label>
                            <input type="text" name="total" id="total" class="form-control" readonly>
                        </div>
                    </div>

                    <div class="col-md-12"></div>


                    <div class="totalesgt col-md-12">

                    </div>
                    <div class="totalesnic col-md-12">

                    </div>

                    <div class="box-footer">
                        <div class="btnscalculo">
                            <button type="button" class="btn btn-large btn-primary col-xs-offset-2">Nuevo
                                <span class="fa  fa-plus"></span>
                            </button>

                            <button type="button" class="btn btn-large btn-info">Grabar
                                <span class="fa fa-floppy-o"></span>
                            </button>

                            <button type="button" class="btn btn-large btn-danger">Cancelar
                                <span class="fa fa-close"></span>
                            </button>

                            <button type="button" class="btn btn-large btn-success" id="btnCalcular">Calcular
                                <span class="fa fa-refresh"></span>
                            </button>

                            <button type="button" class="btn btn-large btn-primary col-xs-offset-2">Factura
                                <span class="fa fa-file-text"></span>
                            </button>

                            <button type="button" class="btn btn-large btn-primary">Recibo
                                <span class="fa fa-file-text"></span>
                            </button>
                        </div>

                    </div>

                </form>
            </div> <!-- box body -->
        </div>

    </div>
</div>