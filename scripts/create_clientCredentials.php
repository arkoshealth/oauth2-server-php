<?php
/* Execute example
 * php create-clientCredentials.php client_id="MyClient" client_secret="MySecret" public_key="-----BEGIN PUBLIC KEY-----..." private_key="-----BEGIN RSA PRIVATE KEY-----..."  redirect_uri="" scope="" user_id="" encryption_algorithm=""
 */

/*
 *  $params = [
 *      client_id               = "MyClient"
 *      client_secret           = "MySecret"
 *      public_key              = "-----BEGIN PUBLIC KEY-----..."
 *      private_key             = "-----BEGIN RSA PRIVATE KEY-----..."
 *      redirect_uri            = "https://carepointe.cloud/"
 *      scope                   = ""
 *      user_id                 = ""
 *      encryption_algorithm    = "RS256"
 *  ]
 */
$entry_params = array_slice($argv, 1);
$required_params = ["client_id", "client_secret", "public_key", "private_key"];
$optional_params = ["redirect_uri", "scope", "user_id", "encryption_algorithm"];

$data = [];
foreach ($entry_params as $param) {
    list($key, $value) = explode("=", $param);
    if (in_array($key, $required_params)) {
        $data[$key] = $value;
    }
}
// All parameters are required
if (count($data) !== count($required_params)) {
    echo "Error: \r\n";
    echo "Missing parameters: [client_id, client_secret, public_key, private_key] \r\n";
    echo "Execute example: " . 'php scripts/create-clientCredentials.php client_id="MyClient" client_secret="MySecret" public_key="-----BEGIN PUBLIC KEY-----..." private_key="-----BEGIN RSA PRIVATE KEY-----..."';
    die;
}
foreach ($entry_params as $param) {
    list($key, $value) = explode("=", $param);
    if (in_array($key, $optional_params)) {
        $data[$key] = $value;
    }
}

// Required
$client_id = $data['client_id'];
$client_secret = $data['client_secret'];
$public_key = $data['public_key'];
$private_key = $data['private_key'];
// Optional
$redirect_uri = isset($data['redirect_uri']) ? $data['redirect_uri'] : 'https://carepointe.cloud/';
$scope = isset($data['scope']) ? $data['scope'] : '';
$user_id = isset($data['user_id']) ? $data['user_id'] : '';
$encryption_algorithm = isset($data['encryption_algorithm']) ? $data['encryption_algorithm'] : 'RS256';

// Route from scripts to root
$homedir = $_SERVER["DOCUMENT_ROOT"] = __DIR__.'/../';

require_once $_SERVER['DOCUMENT_ROOT'] . '/vendor/autoload.php';
$dotenv = Dotenv\Dotenv::createImmutable($homedir);
$dotenv->load();

// Path to export key file
$keyContents = getKey('/tmp/addl-settings');
$key = \Defuse\Crypto\Key::loadFromAsciiSafeString($keyContents);

$dbHost = getenv('DB_HOST');
$dbName = getenv('DB_NAME');
$dsn = "mysql:dbname=$dbName;host={$dbHost}";
$username = getenv('DB_USERNAME');
$password = \Defuse\Crypto\Crypto::decrypt(getenv('DB_PASSWORD'), $key);

// Autoloading (composer is preferred, but for this example let's just do this)
require_once('src/OAuth2/Autoloader.php');
OAuth2\Autoloader::register();

try {
    $storage = new OAuth2\Storage\Pdo(array('dsn' => $dsn, 'username' => $username, 'password' => $password));
    if ($storage->getClientDetails($client_id) || $storage->getPublicKey($client_id)) {
        echo "Error: \r\n";
        echo $client_id . " already exists \r\n";
        die;
    }
    // Insert into 'oauth_clients' table
    $storage->setClientDetails($client_id, $client_secret, $redirect_uri, 'client_credentials', $scope, $user_id);
    // Insert into 'oauth_public_keys' table
    $storage->setClientKeys($client_id, $public_key, $private_key, $encryption_algorithm);

} catch (Exception $exception){
    echo $exception->getMessage();
}
echo $client_id . " created successfully \r\n";


/**
 * @abstract - Function to get the key from a file with the key in an export statement
 * @param string $keyFile - filename and path of the file with the key
 * @return string $key - retrieved key
 */
function getKey($keyFile) {
    $exportKey = file_get_contents($keyFile);
    list($export, $key) = explode('=', $exportKey);
    return trim($key);
}
?>