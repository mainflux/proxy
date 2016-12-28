###
# Mainflux NGINX Dockerfile
###
FROM nginx
MAINTAINER Mainflux

# Copy custom configuration file from the current directory
#COPY nginx.conf /etc/nginx/nginx.conf
COPY auth_req.conf /etc/nginx/conf.d/auth_req.conf

VOLUME /var/log/nginx/log
