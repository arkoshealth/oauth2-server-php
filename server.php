<?php


$dbHost = getenv('DB_HOST') ? getenv('DB_HOST') : '127.0.0.1';
$dsn = "mysql:dbname=carepointe;host={​​​​$dbHost}​​​​";
$username = getenv('DB_USERNAME') ? getenv('DB_USERNAME') : 'root';
$password = getenv('DB_PASSWORD') ? getenv('DB_PASSWORD') : 'password';

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

// Add the "Client Credentials" grant type (it is the simplest of the grant types)
$server->addGrantType(new OAuth2\GrantType\ClientCredentials($storage));

// Add the "Authorization Code" grant type (this is where the oauth magic happens)
$server->addGrantType(new OAuth2\GrantType\AuthorizationCode($storage));

// Add the "User Credentials" greant type
$server->addGrantType(new OAuth2\GrantType\UserCredentials($storage));

?>