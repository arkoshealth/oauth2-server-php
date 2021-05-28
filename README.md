oauth2-server-php
===

Carepointe  OAuth Server Setup Pre-Requsites. Please follow the steps in the order provided

<br />

<<<<<<< HEAD
### Table of Contents
=======
## Table of Contents
>>>>>>> 61d6ea1f2de3df03855b250ae345ce7e71ead5a8
| Step | Description |
|---|---|
|[Database Updates](#-Database-Updates)|Update the database|
|[Virtual Host Updates](#-Virtual-Host-Updates)| VM Virtual host setup |
|[Setup DNS](#-Setup-DNS)| Set up steps for DNS configurations |
<<<<<<< HEAD
|[Configure `.env` File](#-Configure-.env-File)|Set up .env and update database values |
|[Create New Clients (Client Credentials)](#-Create-new-clients-(Client-Credentials))| Create new OAuth credentials for the project. |
|[Additional Information](#-Additional-Information)| Link(s) to additional information |
---

<br />

## Database Updates

=======
|[Configure .env File](#-Configure-.env-File)|Set up .env and update database values |
|[Additional Information](#-Additional-Information)| Link(s) to additional information |
---

## Database Updates

>>>>>>> 61d6ea1f2de3df03855b250ae345ce7e71ead5a8
Execute the below  SQL scripts against the Carepointe MySQL database.

> **Note: This is required for BOTH carepointe-docker and VM installations.**
>   - [`oauth2-server-php/oauth_tables.sql`](./oauth_tables.sql)
>   - `keys.sql` *(shared outside of source control for security)*
   
## Virtual Host Updates  
   
> **Note: This is applicable ONLY for VM installations, NOT docker-carepointe.**

Update the apache configuration as shown below:
```apache
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

## Setup DNS

Follow the below to set up DNS

1. add oauth.local to `/etc/hosts` for 127.0.0.1 (local use)
1. Put key into Apache env
   - from Carepointe-docker repo get addl-settings and envvars (in docker directory)
   - put addl-settings in /tmp
   - run `cat /path/to/envvars >> /etc/apache2/envvars` after that envvars file is no longer needed
   - restart apache  
    
<<<<<<< HEAD
## Configure `.env` File
=======
## Configure .env File
>>>>>>> 61d6ea1f2de3df03855b250ae345ce7e71ead5a8

> **Note: This is required for BOTH carepointe-docker and VM installations.**

1. Locate the `oauth2-server-php/.env.example` file, copy to a new file named `.env`
1. Update the database values accordingly

   > **Note: Passwords and other secrets should be encrypted with php-encryption sample code:

   ```php
   <?php
   $_SERVER['DOCUMENT_ROOT'] = '/var/www/html';
   require_once $_SERVER['DOCUMENT_ROOT'] . '/vendor/autoload.php';

   $keyContents = file_get_contents($_SERVER['DOCUMENT_ROOT'] . '/path/to/key');
   $key = \Defuse\Crypto\Key::loadFromAsciiSafeString($keyContents);

   $secret = 'secret';

   $ciphertext = \Defuse\Crypto\Crypto::encrypt($secret, $key);

   echo 'secret: ' . $ciphertext . PHP_EOL;
<<<<<<< HEAD

   ?>
   ```

1. Copy the `oauth2-server-php/find_cost.php` to the installation directory of Carepointe.
        
   > **Note: For carepointe-docker installations you will need to bash into the running container:**
      
   ```zsh
   docker exec -it arkos-docker_carepointe_1 bash
   ```

   1. Run `php find_cost.php`
   1. Update the `COST` variable in the `.env` to match the output of the `find_cost.php` script output (default is 11)
      - this value will need to be updated in the carepointe .env file as well (they must match)

## Create New Clients (Client Credentials)
> **Note:** These instructions must be followed while inside the container of Oauth2-server-php project.
 1. Locate the root folder `/.../oauth2-server-php/`
 1. Run the script:
      ```php
      php scripts/create_clientCredentials.php client_id="MyClient" client_secret="MySecret" public_key="-----BEGIN PUBLIC KEY-----..." private_key="-----BEGIN RSA PRIVATE KEY-----..."
      ```
      > **Note:** Can add additional params:
      ```
      redirect_uri, scope, user_id, encryption_algorithm
      ```
      Should return: 
      ```
      MyClient created successfully
      ```
 1. For testing, use the following cURL code:
      ```
      curl -u MyClient:MySecret http://oauth.local/token.php -d 'grant_type=client_credentials'
      ```
      The response should be:
      ```
      {"access_token":"JWT_TOKEN", "expires_in":false, "token_type":"bearer", "scope":null}
      ```

<br />

## Additional Information

=======

   ?>
   ```

1. Copy the `oauth2-server-php/find_cost.php` to the installation directory of Carepointe.
        
   > **Note: For carepointe-docker installations you will need to bash into the running container:**
      
   ```zsh
   docker exec -it arkos-docker_carepointe_1 bash
   ```

   1. Run `php find_cost.php`
   1. Update the `COST` variable in the `.env` to match the output of the `find_cost.php` script output (default is 11)
      - this value will need to be updated in the carepointe .env file as well (they must match)

## Additional Information

>>>>>>> 61d6ea1f2de3df03855b250ae345ce7e71ead5a8
[OAuth Server Complete Documentation](https://bshaffer.github.io/oauth2-server-php-docs/) | More information on the oauth server.