<div class="modal fade" id="modalCiudad" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title text-center" id="tituloCiudad">Ciudades/Lugares</h4>
            </div>
            <div class="modal-body">
                <form id="frmCiudad">
                    
                    <div class="form-group col-md-12">
                        <label for="bPaisCiudad" class="col-form-label">Busqueda Pais:</label>
                        <select id="bPaisCiudad" name="bPaisCiudad" class="form-control selectpicker" data-live-search="true" onclick="llenaCiudadModal()" onchange="llenaCiudadModal()">
                        </select>
                    </div>

                    <div class="form-group col-md-12">
                        <label for="bCiudad" class="col-form-label">Nombre/Lugar:</label>
                        <select id="bCiudad" name="bCiudad" class="form-control selectpicker" data-live-search="true" onclick="buscaCiudad()" onchange="buscaCiudad()">
                        </select>
                    </div>

                    <div class="form-group col-md-12">
                        <label for="paisCiudad" class="col-form-label">Pais(*):</label>
                        <select id="paisCiudad" name="paisCiudad" class="form-control selectpicker" data-live-search="true" onclick="llenaCiudadModal()" onchange="llenaCiudadModal()">
                        </select>
                    </div>

                    <div class="form-group col-md-12">
                        <label for="nombreCiudad" class="col-form-label">Nombre(*):</label>
                        <input type="text" name="nombreCiudad" id="nombreCiudad" class="form-control" onkeyup="mayusculas(this)">
                        <input type="hidden" name="idciudad" id="idciudad">
                        <input type="hidden" name="quienLLamaCiudad" id="quienLLamaCiudad">
                    </div>
                    
                    <div class="form-group">
                        <label for="" class="col-form-label">.</label>
                    </div>
                </form>
            </div>
            <div class="modal-footer">

                <button type="button" class="btn btn-default" onclick="nuevaCiudad()">Nuevo
                    <span class="fa fa-file-o"></span></button>

                <button type="button" class="btn btn-primary" id="btnGrabaCiudad" onclick="grabarCiudad()"  disabled>Grabar
                    <span class="fa fa-floppy-o"></span></button>

                <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar
                    <span class="fa fa-close"></span></button>
            </div>
        </div>
    </div>
</div>