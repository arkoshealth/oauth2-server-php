use carepointe;

DROP TABLE IF EXISTS oauth_clients;
CREATE TABLE oauth_clients (
  client_id             VARCHAR(80)   NOT NULL,
  client_secret         VARCHAR(80),
  redirect_uri          VARCHAR(2000),
  grant_types           VARCHAR(80),
  scope                 VARCHAR(4000),
  user_id               VARCHAR(80),
  PRIMARY KEY (client_id)
);

INSERT INTO oauth_clients (client_id, client_secret, redirect_uri, grant_types) 
  VALUES ("carepointe", "testsecret", "https://carepointe.cloud/", 'password');

DROP TABLE IF EXISTS oauth_access_tokens;
CREATE TABLE oauth_access_tokens (
  access_token         VARCHAR(255)    NOT NULL,
  client_id            VARCHAR(80)    NOT NULL,
  user_id              VARCHAR(80),
  expires              TIMESTAMP      NOT NULL,
  scope                VARCHAR(4000),
  PRIMARY KEY (access_token)
);

DROP TABLE IF EXISTS oauth_authorization_codes;
CREATE TABLE oauth_authorization_codes (
  authorization_code  VARCHAR(40)     NOT NULL,
  client_id           VARCHAR(80)     NOT NULL,
  user_id             VARCHAR(80),
  redirect_uri        VARCHAR(2000),
  expires             TIMESTAMP       NOT NULL,
  scope               VARCHAR(4000),
  id_token            VARCHAR(1000),
  PRIMARY KEY (authorization_code)
);

DROP TABLE IF EXISTS oauth_refresh_tokens;
CREATE TABLE oauth_refresh_tokens (
  refresh_token       VARCHAR(255)     NOT NULL,
  client_id           VARCHAR(80)     NOT NULL,
  user_id             VARCHAR(80),
  expires             TIMESTAMP       NOT NULL,
  scope               VARCHAR(4000),
  PRIMARY KEY (refresh_token)
);

DROP TABLE IF EXISTS oauth_scopes;
CREATE TABLE oauth_scopes (
  scope               VARCHAR(80)     NOT NULL,
  is_default          BOOLEAN,
  PRIMARY KEY (scope)
);

DROP TABLE IF EXISTS oauth_jwt;
CREATE TABLE oauth_jwt (
  client_id           VARCHAR(80)     NOT NULL,
  subject             VARCHAR(80),
  public_key          VARCHAR(2000)   NOT NULL
);

alter table tbl_users add column email_verified tinyint(1) DEFAULT NULL, add column scope varchar(4000) DEFAULT NULL;
alter table tbl_patient add column email_verified tinyint(1) DEFAULT NULL;
alter table tbl_patient_account add column scope varchar(4000) DEFAULT NULL;

CREATE OR REPLACE VIEW oauth_users AS 
  select tbl_users.UserName AS username, tbl_users.Password AS password,
         tbl_users.FirstName AS first_name, tbl_users.LastName AS last_name,
         tbl_users.EmailID1 AS email, tbl_users.email_verified AS email_verified,
         tbl_users.scope AS scope from tbl_users
   UNION      
  select patientAccount.email as username, patientAccount.password as password,
         patient.FirstName as first_name, patient.LastName as last_name,
         patient.EmailID as email, patient.email_verified as email_verified,
         patientAccount.scope as scope
  from   tbl_patient as patient, tbl_patient_account as patientAccount
  Where  patient.patient_ID = patientAccount.patient_id;

CREATE OR REPLACE VIEW oauth_users_password_history AS
  select tbl_users_password_history.id as id, tbl_users_password_history.unique_user_identifer as unique_user_identifer,
         tbl_users_password_history.user_id as user_id, tbl_users_password_history.password as password,
         tbl_users_password_history.created_at as created_at from tbl_users_password_history
   UNION
  select tbl_patient_password_history.id as id, tbl_patient_password_history.patient_id as user_id,
         tbl_patient_password_history.password as password, tbl_patient_password_history.created_at as created_at,
         tbl_patient_password_history.patient_id as unique_user_identifer from tbl_patient_password_history;
  

DROP TABLE IF EXISTS oauth_public_keys;
CREATE TABLE oauth_public_keys (
  client_id VARCHAR(80), 
  public_key VARCHAR(8000), 
  private_key VARCHAR(8000), 
  encryption_algorithm VARCHAR(80) DEFAULT "RS256"
);

DROP TABLE IF EXISTS oauth_jti;
CREATE TABLE oauth_jti (
issuer              VARCHAR(80)   NOT NULL,
subject             VARCHAR(80),
audiance            VARCHAR(80),
expires             TIMESTAMP     NOT NULL,
jti                 VARCHAR(2000) NOT NULL
);
