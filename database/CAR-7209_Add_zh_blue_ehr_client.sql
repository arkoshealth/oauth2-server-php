/*
    @Created on:    2021-03-25 20:12:00
    @Created by:    gaviriac
    @Detail:
        Purpose -   add ZH Blue EHR client (CAR-7209)
        Table(s)-   oauth_clients
*/

INSERT INTO oauth_clients (client_id, client_secret, redirect_uri, grant_types)
VALUES ("zh-blue-ehr", "secretzh", "https://carepointe.cloud/", 'client_credentials');

INSERT INTO oauth_public_keys (client_id, public_key, private_key, encryption_algorithm)
VALUES ("zh-blue-ehr", "-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2ZH9DebbDi7WpkgcduqY
IaT/VVttAk7ricEB6lUFwWvWUNrNaZ2OoBT1La9evlnDtHKCJEBB00ecgFXJctUv
T3BTrt3O8DvXymZJTmgb358mUdTdO4Dfj7+/Q5cReYQEOH6TYlwPb1QojXSoZKkj
E6sXKlmNT/pSu5qSw8X10ZeDt5FhMajxjRmJVHLnFdGXU3Ve58/wHSmZm8Ngnm4O
AqBoSK7RtN+fl4qhee/1K1jeT/5KHnzF1lArKrIphhPuAhzh3Q0yhExwgsNEvbiD
QTVqEDTwhvjnU7WeLpbFWpVO4+2oKDvlVsNbE5Ifh1A6IO886hNn7XtPZ+Pbivec
XwIDAQAB
-----END PUBLIC KEY-----", "-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEA2ZH9DebbDi7WpkgcduqYIaT/VVttAk7ricEB6lUFwWvWUNrN
aZ2OoBT1La9evlnDtHKCJEBB00ecgFXJctUvT3BTrt3O8DvXymZJTmgb358mUdTd
O4Dfj7+/Q5cReYQEOH6TYlwPb1QojXSoZKkjE6sXKlmNT/pSu5qSw8X10ZeDt5Fh
MajxjRmJVHLnFdGXU3Ve58/wHSmZm8Ngnm4OAqBoSK7RtN+fl4qhee/1K1jeT/5K
HnzF1lArKrIphhPuAhzh3Q0yhExwgsNEvbiDQTVqEDTwhvjnU7WeLpbFWpVO4+2o
KDvlVsNbE5Ifh1A6IO886hNn7XtPZ+PbivecXwIDAQABAoIBAQCPyZukBF3hEbNq
UV3+eSvxkEnu720riVzAvX22kFotakdJSFFY63fG9BLVDoFe65QbPVIlAxJ9v2X+
qrNn4NxTc7jaaFzLB8GlUdRArS0+rL92dWeAW7tkFSUiVkSGOmlPrNdaudy5hrUG
R4LCg8VaykeVBXoO0TC8K3uzRrEewfsfWhKtNqBq2vm7ypJZzBfyXMfN7ahXuBRg
mYu8wiJPlOXnxtB4kKO3TTY8R3hR2A4C46sp/hZD7gqPH3nOs6HMA7N/sVyQDofo
upL9OH/diHg8cV8exbwSe83SZtqbee0uFuuy9ED0RfVE+9FRZE/aSviBDowc/VfM
ZJ1hXFaBAoGBAPpFttCNZaUKH/o/xzXeiAhkYDH8ncRu8YhrtPTKRJUTdG6B1yP4
+sMtenzTIxWasRocmkflNeNOcG8t4bOt/e1Gtq5WXIIFe2fETtElbmkgunLqlNck
PQoT2PHPX4v+mxHMOgiz4NOy8/DCNqZXlapyRXRt3IdQBnkOingYtFw7AoGBAN6M
rktfpRkOljvRyNSnXI54XrDHszia1Gnv800mo6lwN3sStOw/h0JQPXTilPSZWoD9
2rSAVq0ueu6ZXL+2t879kMKvO1nEQnh7fCMR7sPX/aBlyAilYHIl50NpBfiQuHYq
TsD35wJE6oAZRWbDCPO+xUlQAjgGFs6JaWhUIdItAoGASflPJueUUqridsphLHgB
B1H76Op9C3GrbKJBU1Vx3gppELzKBXTzUbtgiAK0TQ9zJ3+qznNecThfHU2Xd8+G
zZpoJrGaGEhciHhKv6DruKEW2x6hLdIlRJRHPHoKCMwRs7oEsUvRuWEcn14YXyRm
NYIfK2HJnCk4MJHutb6/mL8CgYASw932cQwkvrwgMyIx/CKryK6DTXNpNHTwsdDc
EoP+R34GHJ+ww/KNvuJPtsNElKGy+rS0P5YPaDnpYHkXmTqKc4r/P3NLsGbCbfcb
pelyDgZOvgZN5FPrjBKh9nsQaHOFUy/syXprEJCNWJQnhA5/LvjHo71sJ+dIZwHC
UEXByQKBgErRvbGo9vDu3f2lBJua22VvFhXcjX190oLwxTdbq50VIidbW4MiE+LS
TqRyZk2erOO74xfZQJ9daH2/ZCP6ugCa2v/uOhjU+dpPwwvRzZSwD+MixDdJQH6Z
tL5JbLs8Uqcv0PvecNTyR9dLTIc09qeKbKUF63v47jPnV3Xq/sGF
-----END RSA PRIVATE KEY-----", 'RS256');