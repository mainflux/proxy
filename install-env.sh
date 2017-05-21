#!/bin/sh

# Copy config files:
cp nginx.conf /etc/nginx/nginx.conf

# Copy TLS certificate and key:
cp certs/mainflux-server.crt /etc/ssl/certs/
cp certs/mainflux-server.key /etc/ssl/private/

# Ensure that you have Diffie-Hellman group: `ls /etc/ssl/certs/dhparam.pem`, or crate one:
openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

# Copy nginx config snippets:
mkdir -p /etc/nginx/snippets
cp snippets/* /etc/nginx/snippets/

# Enable proxy as default:
rm /etc/nginx/conf.d/default.conf
cp conf.d/mainflux-proxy.conf /etc/nginx/conf.d/mainflux-proxy.conf
