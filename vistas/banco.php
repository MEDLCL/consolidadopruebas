<div class="row" id="divBanco">
    <form action="" role="form" id="frmbanco">
        <div class="col-md-6">
            <div class="box box-info">
                <div class="box-header with-border">
                    <div class="col-md-12">
                        <label for="slcBanco" class="">Busqueda(*) </label>
                        <div class="input-group input-group-sm">
                            <select id="slcBanco" name="slcBanco" class="form-control selectpicker"
                                data-live-search="true">
                            </select>
                            <span class="input-group-btn">
                                <button type="button" class="btn btn-info"></button>
                            </span>
                            <input type="hidden" name="idbanco" id="idbanco">
                        </div>
                    </div>

                </div>
                <div class="box-body">
                    <div class="form-horizontal">

                        <div class="col-md-12">
                            <label for="">Nombre Banco(*): </label>
                            <div class="form-group input-group-sm">
                                <div class="col-md-12">
                                    <input type="text" class="form-control input-sm" name="nombreBanco"
                                        id="nombreBanco">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <label for="">Ejecutivo(*): </label>
                            <div class="form-group input-group-sm">
                                <div class="col-md-12">
                                    <input type="number" class="form-control input-sm" name="ejecutivo" id="ejecutivo">
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <label>Telefono(*)</label>
                            <div class="form-group input-group-sm">
                                <div class="col-md-12">
                                    <input type="text" class="form-control input-sm" name="telefonobanco"
                                        id="telefonobanco">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label>Extension</label>

                            <div class="col-md-12">
                                <input type="number" class="form-control input-sm" name="extensionBanco"
                                    id="extensionBanco">
                            </div>
                        </div>
                        <div class="col-md-12">
                            <label>E-Mail</label>
                            <div class="form-group">
                                <div class="col-md-12">
                                    <input type="email" class="form-control input-sm" name="correo" id="correo">
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <label>Observaciones:</label>
                            <div class="form-group input-group-sm">
                                <div class="col-md-12">
                                    <textarea class="form-control input-sm" id="bancoObser" name="bancoObser" rows="2"
                                        onkeyup="mayusculas(this)"></textarea>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-9">
                                <button class="btn btn-default" type="button" onclick="" id="">Nuevo
                                    <span class="fa fa-file-o"></span>
                                </button>

                                <button class="btn btn-primary" type="button" onclick="" id="btnGrabarBanco">Graba
                                    <span class="fa fa-floppy-o"></span>
                                </button>

                                <button class="btn btn-danger" type="button" onclick="" id="">Cancelar
                                    <span class="fa fa-close"></span>
                                </button>
                            </div>
                        </div>
                    </div> <!-- form id horizontal  -->
                </div> <!-- body box  -->
            </div>
        </div><!-- /.col -->
        <div class="col-md-6">
            <!-- area de factruas proveedores -->
            <div class="box box-primary">
                <div class="box box-solid">
                    <div class=" box-header with-border">
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="form-horizontal">
                                <div class="col-md-12">
                                    <label>Nombre Cuenta(*)</label>
                                    <div class="form-group">
                                        <div class="col-md-12">
                                            <input type="text" class="form-control input-sm" name="nombreCuentaNuevo"
                                                id="nombreCuentaNuevo">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <label>No. Cuenta(*)</label>
                                    <div class="form-group input-group-sm">
                                        <div class="col-md-12">
                                            <input type="text" class="form-control input-sm" name="correo" id="correo">
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-12">
                                    <label for="slcBanco" class="">Moneda(*) </label>
                                    <div class="input-group input-group-sm">
                                        <select id="slcBanco" name="slcBanco" class="form-control selectpicker"
                                            data-live-search="true">
                                        </select>
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-info"></button>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-12">.</div>

                            </div>
                            <div class="box-footer">
                                <button type="button" class="btn btn-large btn-primary col-xs-offset-2">Nuevo
                                    <span class="fa  fa-plus"></span>
                                </button>

                                <button type="button" class="btn btn-large btn-info" onclick="grabarCalculo()">Grabar
                                    <span class="fa fa-floppy-o"></span>
                                </button>

                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div> <!-- fin col 6 proveedores -->
        <div class="col-md-6">
            <!-- area de factruas proveedores -->
            <div class="box box-primary">
                <div class="box box-solid">
                    <div class=" box-header with-border">
                        <button type="button" class="btn btn-primary">Nueva Cuenta
                            <span class="fa fa-plus"></span>
                        </button>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-body table-responsive">
                            <table class="table table-bordered table-hover table-responsive table-hover"
                                id="tblCuentasBancos">
                                <thead>
                                    <tr>
                                        <th>Nombre cuenta</th>
                                        <th>No. Cuenta</th>
                                        <th>Moneda</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div> <!-- fin col 6 proveedores -->
    </form><!--  form almacen -->
</div><!-- /.col row -->