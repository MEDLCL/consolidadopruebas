<div class="row" id="crearMaritimo">
    <div class="col-md-12">
        <div class="box box-info">
            <div class="box-header with-border"></div>
            <div class="box-body">

                <form action="" method="POST" class="" role="form" id="frmCrearMaritimo" enctype="multipart/form-data">
                    <ul class="nav nav-tabs" id="tabCrearMaritimo">
                        <li><a class="active" id="TabCreaM" data-toggle="tab" href="#CrearMar">Datos Generales</a></li>
                        <li><a id="tabCreaMDetalle" data-toggle="tab" href="#DetalleCreaM">Detalles</a></li>
                        <li><a id="tabArchivos" data-toggle="tab" href="#CreaMArchivos">Archivos</a></li>

                        <!-- <li class="nav-item">
                            <a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab"
                                aria-controls="contact" aria-selected="false">Contact</a>
                        </li> -->
                    </ul>
                    <div class="tab-content" id="myTabContentCreaM">
                        <div class="tab-pane fade active" id="CrearMar">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="panel panel-primary">
                                        <div class="panel-heading"></div>
                                        <div class="panel-body">
                                            <!-- <form class="form-horizontal"> -->
                                            <div class="col-md-6">
                                                <div class="form-group col-md-4">
                                                    <label for="fechaingreso" class="control-label">Fecha(*):</label>
                                                    <input type="text" id="fechaingreso" name="fechaingreso" class="form-control input-sm">
                                                </div>

                                                <div class="form-group col-md-4">
                                                    <label for="codigoMaritimo" class="control-label">Codigo:</label>
                                                    <input type="text" name="codigoMaritimo" id="codigoMaritimo" class="form-control input-sm" readonly>
                                                    <input type="hidden" name="idembarquemaritimo" id="idembarquemaritimo">
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <label for="consecutivo" class="control-label">Consecutivo:</label>
                                                    <input type="text" name="consecutivo" id="consecutivo" class="form-control input-sm" readonly>
                                                </div>

                                                <div class="col-md-6">
                                                    <label for="tipocarga" class="">T. Carga(*)</label>
                                                    <div class="input-group input-group-sm">
                                                        <select id="tipocarga" name="tipocarga" class="form-control selectpicker" data-live-search="true" >
                                                        </select>
                                                        <span class="input-group-btn">
                                                            <button type="button" class="btn btn-info fa-circle-thin"></button>
                                                        </span>
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <label for="tipoServicio" class="">T. Servicio(*)</label>
                                                    <div class="input-group input-group-sm">
                                                        <select id="tipoServicio" name="tipoServicio" class="form-control selectpicker" data-live-search="true">
                                                        </select>
                                                        <span class="input-group-btn">
                                                            <button type="button" class="btn btn-info fa-circle-thin"></button>
                                                        </span>
                                                    </div>
                                                </div>
                                
                                                <div class="col-md-12">
                                                    <span class="label">.</span>
                                                </div>
                                                <!--  -->
                                                <div class="col-md-6">
                                                    <label for="envioCourier" class="">Courier</label>
                                                    <div class="input-group input-group-sm">
                                                        <select id="envioCourier" name="envioCourier" class="form-control selectpicker" data-live-search="true">
                                                        </select>
                                                        <span class="input-group-btn">
                                                            <button type="button" class="btn btn-info fa-circle-thin"></button>
                                                        </span>
                                                    </div>
                                                </div>
                                                <div class="col-md-12">
                                                    <span class="label">.</span>
                                                </div>
                                                <div class="col-md-12">
                                                    <label for="barco" class="">Barco(*)</label>
                                                    <div class="input-group input-group-sm">
                                                        <select id="barco" name="barco" class="form-control selectpicker" data-live-search="true">
                                                        </select>
                                                        <span class="input-group-btn">
                                                            <button type="button" class="btn btn-success fa fa-plus" data-target="#modalBarco" onclick="nuevoBarcoM()"></button>
                                                        </span>
                                                    </div>
                                                </div>
                                                <div class="col-md-12">
                                                    <span class="label">.</span>
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <label for="Viaje" class="control-label">Viaje(*):</label>
                                                    <input type="text" class="form-control input-sm" id="Viaje" name="Viaje" onkeyup="mayusculas(this)">
                                                </div>

                                                <div class="form-group col-md-6">
                                                    <label for="cntClientes" class="control-label">Cant. Clientes(*):</label>
                                                    <input type="number" name="cntClientes" id="cntClientes" class="form-control input-sm" onkeyup="this.value=numeroTelefono(this.value)">
                                                </div>

                                                <div class="col-md-12">
                                                    <label for="agente" class="">Agente Embarcador(*)</label>
                                                    <div class="input-group input-group-sm">
                                                        <select id="agente" name="agente" class="form-control selectpicker" data-live-search="true">
                                                        </select>
                                                        <span class="input-group-btn">
                                                            <button type="button" class="btn btn-success fa fa-plus" data-target="#modalempresa" onclick="nuevoAgente()"></button>
                                                        </span>
                                                    </div>
                                                </div>

                                                <div class="col-md-12">
                                                    <span class="label">.</span>
                                                </div>

                                                <div class="col-md-12">
                                                    <label for="naviera" class="">Naviera / Agencia de Carga(*)</label>
                                                    <div class="input-group input-group-sm">
                                                        <select id="naviera" name="naviera" class="form-control selectpicker" data-live-search="true">
                                                        </select>
                                                        <span class="input-group-btn">
                                                            <button type="button" class="btn btn-success fa fa-plus" data-target="#modalempresa" onclick="nuevaNaviera()"></button>
                                                        </span>
                                                    </div>
                                                </div>

                                                

                                            </div>

                                            <div class="col-md-6">

                                                <label for="PaisOrigen" class="">Pais Origen(*) </label>
                                                <div class="input-group input-group-sm">
                                                    <select id="PaisOrigen" name="PaisOrigen" class="form-control selectpicker" data-live-search="true" onclick="llenaCiudadOrigenMar(0)" onchange="llenaCiudadOrigenMar()">
                                                    </select>
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-info fa-circle-thin"></button>
                                                    </span>
                                                </div>
                                                <div class="col-md-12">
                                                    <span class="label">.</span>
                                                </div>
                                                <label for="Origen" class="">Origen(*) </label>
                                                <div class="input-group input-group-sm">
                                                    <select id="Origen" name="Origen" class="form-control selectpicker" data-live-search="true">
                                                    </select>
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-success fa fa-plus" data-target="#modalCiudad" onclick="nuevoOrigen()"></button>
                                                    </span>
                                                </div>

                                                <div class="col-md-12">
                                                    <span class="label">.</span>
                                                </div>

                                                <label for="PaisDestino" class="">Pais Destino(*) </label>
                                                <div class="input-group input-group-sm">
                                                    <select id="PaisDestino" name="PaisDestino" class="form-control selectpicker" data-live-search="true" onclick="llenaciudadDestinoMar(0)" onchange="llenaciudadDestinoMar()">
                                                    </select>
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-info fa-circle-thin"></button>
                                                    </span>
                                                </div>
                                                <div class="col-md-12">
                                                    <span class="label">.</span>
                                                </div>
                                                <label for="Destino" class="">Destino(*) </label>
                                                <div class="input-group input-group-sm">
                                                    <select id="Destino" name="Destino" class="form-control selectpicker" data-live-search="true">
                                                    </select>
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-success fa fa-plus" data-target="#modalCiudad" onclick="nuevoDestino()"></button>
                                                    </span>
                                                </div>
                                                <div class="col-md-12">
                                                    <span class="label">.</span>
                                                </div>
                                                <label for="usuarioAsignado" class="">Usuario Asignado(*) </label>
                                                <div class="input-group input-group-sm">
                                                    <select id="usuarioAsignado" name="usuarioAsignado" class="form-control selectpicker" data-live-search="true">
                                                    </select>
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-info fa-circle-thin"></button>
                                                    </span>
                                                </div>
                                                <div class="col-md-12">
                                                    <span class="label">.</span>
                                                </div>

                                                <div class="form-group col-md-12">
                                                    <label for="obervaciones" class="control-label">Observaciones:</label>
                                                    <textarea class="form-control input-sm" id="obervaciones" name="obervaciones" rows="3" onkeyup="mayusculas(this)"></textarea>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-1"></div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="DetalleCreaM">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="col-md-12">
                                        <div class="panel panel-primary">
                                            <div class="panel-heading">
                                            </div>
                                            <div class="panel-body">
                                                <label for="noContenedor" class="control-label">No Contenedor:</label>
                                                <div class="input-group input-group-sm">
                                                    <input type="text" name="noContenedor" id="noContenedor" class="form-control">
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-success fa fa-plus" onclick="agregarContenedor()"></button>
                                                    </span>
                                                </div>

                                                <div class="panel-body table-responsive">
                                                    <table class="table table-condensed table-hover table-bordered" id="tContenedor">
                                                        <thead>
                                                            <tr>
                                                                <th>Acciones</th>
                                                                <th>No Contenedor</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="tbodyContenedores">
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div><!--  fin panel  -->
                                    </div> <!-- fin col 4 -->
                                </div>

                                <div class="col-md-8">
                                    <div class="form-group col-md-6">
                                        <label for="tipodocumento" class="col-form-label">Tipo Documento(*):</label>
                                        <select id="tipodocumento" name="tipodocumento" class="form-control selectpicker" data-live-search="true" onclick="activaCliente()" onchange="activaCliente()">
                                        </select>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="noventa" class="col-form-label">No Venta/No RO(*):</label>
                                        <select id="noventa" name="noventa" class="form-control selectpicker" data-live-search="true" >
                                        </select>
                                    </div>
                                    <div class="form-group col-md-12">
                                        <label for="clientes" class="control-label">Cliente(*):</label>
                                        <input type="text" class="form-control input-sm" id="clientes" name="clientes" onkeyup="mayusculas(this)">
                                    </div>

                                    <div class="form-group col-md-4">
                                        <label for="nodocs" class="control-label">No. Documento(*):</label>
                                        <input type="nodocs" class="form-control input-sm" id="nodocs" name="nodocs" onkeyup="mayusculas(this)">
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label for="cantOriginal" class="control-label">Cant. Original:</label>
                                        <input type="number" class="form-control input-sm" id="cantOriginal" name="cantOriginal">
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label for="cantCopias" class="control-label">Cant. Copias:</label>
                                        <input type="number" class="form-control input-sm" id="cantCopias" name="cantCopias">
                                    </div>
                                    <div class="form-group col-md-12">
                                        <label for="obervacionesdoc" class="control-label">Observaciones:</label>
                                        <textarea class="form-control input-sm" id="obervacionesdoc" name="obervacionesdoc" rows="3" onkeyup="mayusculas(this)"></textarea>
                                    </div>
                                    <div class="form-group col-md-12">
                                        <button type="button" class="btn btn-large btn-primary" onclick="registraDocumentos()">Registrar</button>
                                    </div>
                                    <div class="panel-body table-responsive col-md-12">
                                        <table class="table table-condensed table-hover table-bordered" id="tDetalleCreaM">
                                            <thead>
                                                <th>Acciones</th>
                                                <th>Tipo</th>
                                                <th>Venta/RO</th>
                                                <th>idv</th>
                                                <th>Cliente</th>
                                                <th>No. Documento</th>
                                                <th>Original</th>
                                                <th>Copias</th>
                                                <th>Observaciones</th>

                                            </thead>
                                            <tbody id="tbodyDocumentos">
                                            </tbody>
                                        </table>
                                    </div>
                                </div><!--  fin col 8 -->
                            </div>
                        </div> <!-- contactos -->

                        <div class="tab-pane fade" id="CreaMArchivos"> <!-- comienza tab archivos -->
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group col-md-12">
                                        <label for="tipodocumento" class="col-form-label">Tipo Documento(*):</label>
                                        <input type="file" name="CMarchivos" id="CMarchivos" class = "form-control" multiple>
                                    </div>
                                    <div class="form-group col-md-12">
                                        <button type="button" class="btn btn-large btn-primary" onclick="registraDocumentos()">Registrar</button>
                                    </div>
                                    <div class="panel-body table-responsive col-md-12">
                                        <table class="table table-condensed table-hover table-bordered" id="tDetalleCreaM">
                                            <thead>
                                                <th>#</th>
                                                <th>Nombre Archivo</th>
                                                <th>Archivo</th>
                                                <th>Eliminar</th>
                                                <th>Descargar</th>
                                                <th>Ver</th>
                                            </thead>
                                            <tbody id="">
                                            </tbody>
                                        </table>
                                    </div>
                                </div><!--  fin col 8 -->
                            </div>
                        </div> <!-- archivos -->
                    </div>

                    <div class="col-md-12"></div>
                    <div class="box-footer col-md-12">
                        <button type="button" class="btn btn-large btn-primary" onclick="nuevoEmbarqueFueraTabla()">Nuevo</button>

                        <button type="button" class="btn btn-large btn-info" id="btnGrabarCreaM" onclick="grabarEditarCreaMaritimo()">Grabar
                            <span class="fa fa-floppy-o"></span>
                        </button>

                        <button type="button" class="btn btn-large btn-danger" onclick="cancelar()">Cancelar
                            <span class="fa fa-close"></span>
                        </button>

                    </div>

                </form>
            </div> <!-- box body -->
        </div>
    </div>
</div>