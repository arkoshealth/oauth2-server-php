/*
    @Created on:    2021-03-08 20:12:00
    @Created by:    tripolonelm
    @Detail:
        Purpose -   add refresh_token grant type (CAR-6009)
        Table(s)-   oauth_clients
*/

UPDATE `carepointe`.`oauth_clients`
SET `grant_types` = 'password refresh_token'
WHERE `client_id` = 'carepointe';