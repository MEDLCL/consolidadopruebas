<?php
ob_start();
session_start();

if (!$_SESSION['nombre']) {
    header('LOCATION: ../index.php');
} else {

    require_once("../inc/head.php");
    require_once("../inc/header.php");

    $tipoe = isset($_GET['tipo']) ? $tipoe = $_GET['tipo'] : $tipoe = '';
    if ($tipoe == 'agentee') {
        $tipoempresa = 'AGENTE EMBARCADOR';
        unset($_SESSION['Iniciale']);  $_SESSION['Iniciale']='AE';
    } else if ($tipoe == 'agenciac') {
        $tipoempresa = 'AGENCIA DE CARGA';
        unset($_SESSION['Iniciale']);  $_SESSION['Iniciale']='AC';
    } else if ($tipoe == 'aereolinea') {
        $tipoempresa = 'Aereo-Linea';
        unset($_SESSION['Iniciale']);  $_SESSION['Iniciale']='AL';
    } else if ($tipoe == 'almacen') {
        $tipoempresa = 'Almacenadora';
        unset($_SESSION['Iniciale']); $_SESSION['Iniciale']='AM'; 
    } else if ($tipoe == 'cliente') {
        $tipoempresa = 'Consignatario';
        unset($_SESSION['Iniciale']); $_SESSION['Iniciale']='CL';
    } else if ($tipoe == 'consignado') {
        $tipoempresa = 'Consignado';
        unset($_SESSION['Iniciale']); $_SESSION['Iniciale']='CO';
    } else if ($tipoe == 'embarcador') {
        $tipoempresa = 'Embarcador';
        unset($_SESSION['Iniciale']); $_SESSION['Iniciale']='EM';
    } else if ($tipoe == 'naviera') {
        $tipoempresa = 'Naviera';
        unset($_SESSION['Iniciale']); $_SESSION['Iniciale']='NA';
    } else if ($tipoe == 'proveedor') {
        $tipoempresa = 'Proveedor';
        unset($_SESSION['Iniciale']); $_SESSION['Iniciale']='PR';
    } else if ($tipoe == 'transporte') {
        $tipoempresa = 'Transportista';
        unset($_SESSION['Iniciale']); $_SESSION['Iniciale']='TR';
    } else {
        $tipoempresa = "";
        unset($_SESSION['Iniciale']); $_SESSION['Iniciale']='';
    }
    require_once("../inc/head.php");
    require_once("../inc/header.php");
?>

    <div class="content-wrapper">
        <section class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="box">
                        <div class="box-header with-border">
                            <h3><?php echo $tipoempresa ?> </h3>
                            <button class="btn btn-primary" data-toggle="modal" data-target="#modalempresa" onclick="nuevo('<?php echo $tipoe  ?>')">Agregar
                                Nuevo
                                <span class="glyphicon glyphicon-plus"></span>
                            </button>
                        </div>
                        <div class="panel-body table-responsive">
                            <table class="table table-condensed table-hover table-bordered" id="Tempresas">
                                <thead>
                                    <tr>
                                        <th>Editar</th>
                                        <th>Codigo</th>
                                        <th>Razon Social</th>
                                        <th>Nombre Comercial</th>
                                        <th>Nit</th>
                                        <th>Telefono</th>
                                        <th>Direccion</th>
                                        <th>%Comision</th>
                                        <th>Tipo Comision</th>
                                        <th>Nombre</th>
                                        <th>Apellido</th>
                                        <th>Correo</th>
                                        <th>Tel</th>
                                        <th>Puesto</th>

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
            <?php
            include_once "modal/modalempresa.php";
            ?>
        </section>
    </div>

    <?php
    include_once "../inc/footer.php";
    include_once "../inc/scritps.php";
    ?>
    <script type="text/javascript" src="scritps/empresa.js"></script>
    <script>
        $(document).ready(function() {
            $('#tabempresa li:first-child a').tab('show')
        });
    </script>
<?php
}
ob_end_flush();
?>