<div class="modal fade" id="modalBarco" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title text-center" id="titulomodalBarco">Barcos</h4>
            </div>
            <div class="modal-body">
                <form id="frmBarco">
                    <div class="form-group col-md-12">
                        <label for="bBarco" class="col-form-label">Busqueda:</label>
                        <select id="bBarco" name="bBarco" class="form-control selectpicker" data-live-search="true" onclick="buscarBarco()" onchange="buscarBarco()">
                        </select>
                    </div>
                    <div class="form-group col-md-12">
                        <label for="nombreBarco" class="col-form-label">Nombre Barco(*):</label>
                        <input type="text" name="nombreBarco" id="nombreBarco" class="form-control" onkeyup="mayusculas(this)">
                    </div>
                    <div class="form-group col-md-12">
                        <label for="bandera" class="col-form-label">Bandera(Flag):</label>
                        <input type="text" name="bandera" id="bandera" class="form-control" onkeyup="mayusculas(this)">
                        <input type="hidden" name="idbarco" id="idbarco">
                        <input type="hidden" name="quienllamaBarco" id="quienllamaBarco">
                    </div>
                    <div class="form-group">
                        <label for="" class="col-form-label">.</label>
                    </div>
                </form>
            </div>
            <div class="modal-footer">

                <button type="button" class="btn btn-default" onclick="nuevoBarco()">Nuevo
                    <span class="fa fa-file-o"></span></button>

                <button type="button" class="btn btn-primary" id="btnGrabaBarco" onclick="grabarBarco()"  disabled>Grabar
                    <span class="fa fa-floppy-o"></span></button>

                <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar
                    <span class="fa fa-close"></span></button>
            </div>
        </div>
    </div>
</div>