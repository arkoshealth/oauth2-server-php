<?php
require_once $_SERVER['DOCUMENT_ROOT'] . '/vendor/autoload.php';
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

$dbHost = getenv('DB_HOST');
$dbName = getenv('DB_NAME');
$dsn = "mysql:dbname=$dbName;host={$dbHost}";
$username = getenv('DB_USERNAME');
$password = getenv('DB_PASSWORD');

// error reporting (this is a demo, after all!)
ini_set('display_errors',1);
error_reporting(E_ALL);

// Autoloading (composer is preferred, but for this example let's just do this)
require_once('src/OAuth2/Autoloader.php');
OAuth2\Autoloader::register();

// $dsn is the Data Source Name for your database, for exmaple "mysql:dbname=my_oauth2_db;host=localhost"
$storage = new OAuth2\Storage\Pdo(array('dsn' => $dsn, 'username' => $username, 'password' => $password));

// Pass a storage object or array of storage objects to the OAuth2 server class
$server = new OAuth2\Server($storage, array(
    'use_jwt_access_tokens' => true
));

// Add the "User Credentials" grant type. Note this is the minimal required grant for Carepointe oauth flow/usage.
$server->addGrantType(new OAuth2\GrantType\UserCredentials($storage));

?>
