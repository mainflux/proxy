#!/bin/sh

# Copy config files:
cp nginx.conf /etc/nginx/nginx.conf

# Copy TLS certificate and key:
cp certs/mainflux-server.crt /etc/ssl/certs/
cp certs/mainflux-server.key /etc/ssl/private/

# Ensure that you have Diffie-Hellman group: `ls /etc/ssl/certs/dhparam.pem`, or crate one:
openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

# Copy nginx config snippets:
cp snippets/* /etc/nginx/snippets/

# Copy `sites-avalable/mainflux-proxy`:
cp sites-available/mainflux-proxy /etc/nginx/sites-available/mainflux-proxy

# Enable it:
ln -s /etc/nginx/sites-available/mainflux-proxy /etc/nginx/sites-enabled/mainflux-proxy
