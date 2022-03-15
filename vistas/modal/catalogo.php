<div class="modal fade" id="modalCatalogo" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title text-center" id="mymodalcatalogo">Catalogo de Descripciones</h4>
            </div>
            <div class="modal-body">
                <form id="frmCatalogo">
                    <div class="form-group col-md-12">
                        <label for="bCatalogo" class="col-form-label">Busqueda:</label>
                        <select id="bCatalogo" name="bCatalogo" class="form-control selectpicker" data-live-search="true" onclick="mostrarCatalogo()" onchange="mostrarCatalogo()">
                        </select>
                    </div>
                    <div class="form-group col-md-12" id="divCodigo">
                        <label for="codigoCatalogo" class="col-form-label">Codigo():</label>
                        <input type="text" name="codigoCatalogo" id="codigoCatalogo" class="form-control">
                    </div>
                    <div class="form-group col-md-12">
                        <label for="nombreDescripcion" class="col-form-label">Nombre(*):</label>
                        <input type="text" name="nombreDescripcion" id="nombreDescripcion" class="form-control">
                        <input type="hidden" name="idcatalogo" id="idcatalogo">
                        <input type="hidden" name="llamaCalculoA" id="llamaCalculoA">
                    </div>
                    <div class="form-group col-md-12" id="divIngles">
                        <label for="nombreDescripcionIngles" class="control-label">Nombre en Ingles:</label>
                        <input type="text" name="nombreDescripcionIngles" id="nombreDescripcionIngles" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="" class="col-form-label">.</label>
                    </div>
                </form>
            </div>
            <div class="modal-footer">

                <button type="button" class="btn btn-default" onclick="NuevoCatalogo()">Nuevo
                    <span class="fa fa-file-o"></span></button>

                <button type="button" class="btn btn-primary" id="btnGrabaCatalogo" onclick="grabarcatalogo()" disabled>Grabar
                    <span class="fa fa-floppy-o"></span></button>

                <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar
                    <span class="fa fa-close"></span></button>
            </div>
        </div>
    </div>
</div>