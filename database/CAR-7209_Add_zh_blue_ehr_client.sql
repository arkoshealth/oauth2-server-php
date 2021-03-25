/*
    @Created on:    2021-03-25 20:12:00
    @Created by:    gaviriac
    @Detail:
        Purpose -   add ZH Blue EHR client (CAR-7209)
        Table(s)-   oauth_clients
*/

INSERT INTO oauth_clients (client_id, client_secret, redirect_uri, grant_types)
VALUES ("zh-blue-ehr", "secretzh", "https://carepointe.cloud/", 'client_credentials');