<?php
// error reporting (this is a demo, after all!)
ini_set('display_errors',1);
error_reporting(E_ALL & ~E_DEPRECATED & ~E_STRICT);

require_once $_SERVER['DOCUMENT_ROOT'] . '/vendor/autoload.php';
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

$key = \Defuse\Crypto\Key::loadFromAsciiSafeString(getenv(getenv('KEY_NAME')));

$dbHost = getenv('DB_HOST');
$dbName = getenv('DB_NAME');
$dsn = "mysql:dbname=$dbName;host={$dbHost}";
$username = getenv('DB_USERNAME');
$password = \Defuse\Crypto\Crypto::decrypt(getenv('DB_PASSWORD'), $key);
$accessLifetime = getenv('ACCESS_LIFETIME');
$idLifetime = getenv('ID_LIFETIME');
$refreshLifetime = getenv('REFRESH_LIFETIME');

// Autoloading (composer is preferred, but for this example let's just do this)
require_once('src/OAuth2/Autoloader.php');
OAuth2\Autoloader::register();

// $dsn is the Data Source Name for your database, for exmaple "mysql:dbname=my_oauth2_db;host=localhost"
$storage = new OAuth2\Storage\Pdo(array('dsn' => $dsn, 'username' => $username, 'password' => $password));

// Pass a storage object or array of storage objects to the OAuth2 server class
/**
 * allowed config items and default vaules
 *   'use_jwt_access_tokens'        => false,
 *   'jwt_extra_payload_callable' => null,
 *   'store_encrypted_token_string' => true,
 *   'use_openid_connect'       => false,
 *   'id_lifetime'              => 3600,
 *   'access_lifetime'          => 3600,
 *   'www_realm'                => 'Service',
 *   'token_param_name'         => 'access_token',
 *   'token_bearer_header_name' => 'Bearer',
 *   'enforce_state'            => true,
 *   'require_exact_redirect_uri' => true,
 *   'allow_implicit'           => false,
 *   'allow_credentials_in_request_body' => true,
 *   'allow_public_clients'     => true,
 *   'always_issue_new_refresh_token' => false,
 *   'unset_refresh_token_after_use' => true,
 */
$server = new OAuth2\Server($storage, array(
    'use_jwt_access_tokens' => true,
    'issuer' => getenv('ISSUER'),
    'access_lifetime' => $accessLifetime,
    'id_lifetime' => $idLifetime,
    'always_issue_new_refresh_token' => true,
    'refresh_token_lifetime' => $refreshLifetime,
));

// Add the "User Credentials" grant type. Note this is the minimal required grant for Carepointe oauth flow/usage.
$server->addGrantType(new OAuth2\GrantType\UserCredentials($storage));
// Add the "Refresh Token" grant type. This allows us to issue a new access token using the Refresh token.
$server->addGrantType(new OAuth2\GrantType\RefreshToken($storage, array('always_issue_new_refresh_token' => true)));
?>