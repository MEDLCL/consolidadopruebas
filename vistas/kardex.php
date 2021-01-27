<?php
ob_start();
session_start();

if (!$_SESSION['nombre']) {
    header('LOCATION: ../index.php');
} else {

    require_once("../inc/head.php");
    require_once("../inc/header.php");
?>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Main content -->
        <section class="content">

            <form action="" method="POST" role="form">
                <legend>Form title</legend>
                <div class="row">
                    <div class="col-md-12">
                        <div class="box">
                            <div class="form-group">
                                <label for="">label</label>
                                <input type="text" class="form-control" id="" placeholder="Input field">
                            </div>
                            <button type="submit" class="btn btn-primary">Submit</button>
                        </div><!-- /.box -->
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </form> <!-- final formulario -->
        </section><!-- /.content -->

    </div><!-- /.content-wrapper -->
    <?php
    require_once("../inc/footer.php");
    require_once("../inc/scritps.php");
    ?>

<?php }
ob_end_flush();
?>