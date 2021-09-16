<?php
ob_start();
session_start();

if (!$_SESSION['nombre']) {
    header('LOCATION: ../index.php');
} else {
    require_once("../inc/head.php");
    require_once("../inc/header.php");
?>

    <div class="content-wrapper">
        <section class="content">
            <?php include_once("../vistas/modal/modalempresa.php");
            include_once("crearmaritimo.php");
            include_once("../vistas/modal/barco.php");
            include_once("../vistas/modal/ciudad.php");
            ?>
            <div class="row" id="listadoEmbarquesMaritimo">

                <div class="col-md-12">
                    <div class="box">
                        <div class="box-header with-border">
                            <h3>Maritimo</h3>
                            <button class="btn btn-primary" onclick="nuevoEmbarque()">Agregar
                                Nuevo
                                <span class="glyphicon glyphicon-plus"></span>
                            </button>
                        </div>
                        <div class="panel-body table-responsive">
                            <table class="table table-condensed table-hover table-bordered" id="TlistadoMaritimo">
                                <thead>
                                    <tr>
                                        <th>Acciones</th>
                                        <th>Fecha Ingreso</th>
                                        <th>Codigo</th>
                                        <th>Consecutivo</th>
                                        <th>Tipo Carga</th>
                                        <th>Tipo Servicio</th>
                                        <th>Courier</th>
                                        <th>Barco</th>
                                        <th>Viaje</th>
                                        <th>Cant. Clientes</th>
                                        <th>Agente Embarcador</th>
                                        <th>Naviera/Agencia Carga</th>
                                        <th>Origen</th>
                                        <th>Destino</th>
                                        <th>Usuario Asignado</th>
                                        <th>Observaciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><button type="submit" class="btn btn-warning glyphicon glyphicon-pencil" data-target="" data-toggle="">
                                            </button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div> <!-- box -->
                </div> <!-- columna 12 -->
            </div><!-- row -->
        </section>
    </div>

    <?php
    include_once "../inc/footer.php";
    include_once "../inc/scritps.php";
    ?>
    <script type="text/javascript" src="scritps/empresa.js"></script>
    <script type="text/javascript" src="scritps/maritimo.js"></script>
    <script type="text/javascript" src="scritps/barco.js"></script>
    <script type="text/javascript" src="scritps/ciudad.js"></script>
    <script>
        $(function(){
            $("#tipocarga").bind("click change",function(event){
                event.preventDefault();
                llenaNAVAGE();
            });
        });
    </script>
<?php
}
ob_end_flush();
?>