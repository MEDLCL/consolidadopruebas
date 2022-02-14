
use PHPJasper\PHPJasper;
ini_set('display_errors',1);
ini_set('display_statup_errors',1);
error_reporting(E_ALL);

$idcalculo = 10;


$pass = "Noviembre2023";
$input = $_SERVER['DOCUMENT_ROOT']. '/consolidadoPruebas/vendor/input/rptCalculo.jasper';  
$output = $_SERVER['DOCUMENT_ROOT'] .'/consolidadoPruebas/vendor/output';    
//$jdbc_dir = 'C:/xampp/htdocs/www/consolidadoPruebas/vendor/lavela/phpjasper/bin/jasperstarter/jdbc';
//$jdbc_dir = $_SERVER['DOCUMENT_ROOT'].'/consolidadoPruebas/vendor/lavela/phpjasper/bin/jasperstarter/jdbc';
$jdbc_url = 'jdbc:mysql://localhost:3307/almadisa';
chmod($input,777);
chmod($output,777);
//chmod($jdbc_dir,777);
$options = [  
    'format' => ['pdf', 'rtf'], 
    'locale' => 'en',
    "params" => ["idcalculo" => $idcalculo],
    'db_connection' => [
        'driver' => 'generic',
        'host' => 'localhost',
        'port' => '3307',
        'database' => 'almadisa',
        'username' => 'root',
        'password' => $pass,
        'jdbc_driver' => 'mysql-connector-java-5.1.48'/*'org.mariadb.jdbc.Driver'*/,
        //'jdbc_driver' => 'mariadb-java-client-2.7.5',
        'jdbc_url' => $jdbc_url,
        //'jdbc_url' => '"jdbc:mysql://localhost:3307;databaseName=almadisa"',
        //'jdbc_dir' => $jdbc_dir
    ]
];
//com.mysql.jdbc.Driver
$jasper = new PHPJasper;
$x=exec($jasper->process(
    $input,
    $output,
    $options
)->output());
echo $x;