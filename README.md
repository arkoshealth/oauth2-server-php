oauth2-server-php
=================

### Carepointe  OAuth Server Setup Pre-Requsites

####1. Database Updates

Execute the below SQL scripts against the Carepointe MySQL database.

**Note: Manually executing oauth_tables.sql is only needed for VM installations. Both Docker and VM installations need to have keys.sql manually executed.**

   - `oauth2-server-php/oauth_tables.sql`
   - `keys.sql` *(shared outside of source control for security)*
   
####2. Virtual Host Updates  
   
**Note: This is applicable ONLY for VM installations, NOT docker-carepointe.**

   - Update the apache configuration as shown below:
```
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        ServerName oauth.local
        DocumentRoot /path/to/oauth2-server-php

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        <Directory /path/to/oauth2-server-php>
           Options Indexes FollowSymLinks Includes ExecCGI
           AllowOverride all
           Require all granted
           Allow from all
        </Directory>
        SetEnv ENC_KEY ${ENC_KEY}
</VirtualHost>   
```
- Setup DNS
   - add oauth.local to `/etc/hosts` for 127.0.0.1 (local use)
- Put key into Apache env
   - from Carepointe-docker repo get addl-settings and envvars (in docker directory)
   - put addl-settings in /tmp
   - run `cat /path/to/envvars >> /etc/apache2/envvars` after that envvars file is no longer needed
   - restart apache  
    
####3. Configure .env File

**Note: This is required for BOTH carepointe-docker and VM installations.**

   - Locate the `oauth2-server-php/.env.example` file, copy to a new file named `.env`
   - Update the database values accordingly
        - **Note: Passwords and other secrets should be encrypted with php-encryption sample code:
```php
<?php
$_SERVER['DOCUMENT_ROOT'] = '/var/www/html';
require_once $_SERVER['DOCUMENT_ROOT'] . '/vendor/autoload.php';

$keyContents = file_get_contents($_SERVER['DOCUMENT_ROOT'] . '/path/to/key');
$key = \Defuse\Crypto\Key::loadFromAsciiSafeString($keyContents);

$secret = 'secret';

$ciphertext = \Defuse\Crypto\Crypto::encrypt($secret, $key);

echo 'secret: ' . $ciphertext . PHP_EOL;

?>
```
   - Copy the `oauth2-server-php/find_cost.php` to the installation directory of Carepointe.
        - **Note: For carepointe-docker installations you will need to bash into the running container:**
        
            `docker exec -it carepointe-docker_carepointe_1 bash`
   
   - Run `php find_cost.php`
   - Update the `COST` variable in the `.env` to match the output of the `find_cost.php` script output (default is 11)
        - this value will need to be updated in the carepointe .ini settings file as well (they must match)

####OAuth Server Complete Documentation

[https://bshaffer.github.io/oauth2-server-php-docs/]()
