oauth2-server-php
=================

## Pre-Req
1. install sql tables
   - oauth_tables.sql
2. set up virtual host
   - apache config
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
</VirtualHost>   
```
3. set up dns
   - add oauth.local to /etc/hosts for 127.0.0.1 (local use) 
4. find your servers (where oauth is going to run cost)
   - find_cost.php
5. edit Pdo.php to adjust the cost
   - src/OAuth2/Storage/Pdo.php line 445
6. database configuration
   - server.php



View the OAuth Server PHP [complete documentation](https://bshaffer.github.io/oauth2-server-php-docs/)
