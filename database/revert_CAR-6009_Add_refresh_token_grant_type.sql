/*
    @Created on:    2021-03-08 20:12:00
    @Created by:    tripolonelm
    @Detail:
        Purpose -   remove refresh_token grant type (CAR-6009)
        Table(s)-   oauth_clients
*/

UPDATE `carepointe`.`oauth_clients`
SET `grant_types` = 'password'
WHERE `client_id` = 'carepointe';