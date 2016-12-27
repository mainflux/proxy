###
# Mainflux NGINX Dockerfile
###
FROM nginx
MAINTAINER Mainflux

# Copy custom configuration file from the current directory
COPY nginx.conf /etc/nginx/nginx.conf
COPY auth_req.cfg /etc/nginx/conf/auth_req.conf

VOLUME /var/log/nginx/log
