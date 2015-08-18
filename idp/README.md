#  Shibboleth-IDP

This is the docker config for the IDP for a demo shibboleth install.

## Usage

```
docker build --tag shibboleth-id .
docker run --name shibboleth-idp -p 80:80 -p 8080:8080 -p 443:443 -p 9443:8443 -p 9990:9990 shibboleth-idp /opt/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement=0.0.0.0 -c standalone-full.xml
```
