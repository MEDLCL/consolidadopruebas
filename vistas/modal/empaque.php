<div class="container">
    <div class="row">
        <div class="modal fade" id="modalEmaqpue" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title text-center" id="titulomodale">Empaque</h4>
                    </div>
                    <div class="modal-body">

                        <form action="" method="POST" class="form-horizontal" role="form" id="frmModalEmpaque">
                            <label for="consiganado" class="">Busqueda:</label>
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <select id="empaqueB" name="empaqueB" class="form-control selectpicker" data-live-search="true">
                                    </select>
                                </div>
                            </div>
                                <label>Nombre:</label>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <input type="text" name="nombreE" id="nombreE" class="form-control" value="" required="required" pattern="" title="">
                                        <input type="hidden" name="id_empaque" id="id_empaque">
                                    </div>
                                </div>
                            
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" onclick="grabaEmpaque()">Grabar</button>
                    </div>
                </div>
            </div>
        </div>
    </div><!-- row -->
</div><!-- contenedor -->