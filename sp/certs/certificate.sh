#!/bin/sh

DOMAIN="aerogear.dev"

openssl req -x509 -newkey rsa:2048 -subj "/C=US/ST=North Carolina/O=Red Hat/L=Raleigh/CN=server.aerogear.dev/OU=DEVELOPMENT/emailAddress=aerogear@aerogear.org" -keyout "/etc/httpd/certs/$DOMAIN-key.pem" -out "/etc/httpd/certs/$DOMAIN-cert.pem" -days 3650 -nodes -sha256
