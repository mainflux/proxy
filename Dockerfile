###
# Mainflux NGINX Dockerfile
###
FROM nginx
MAINTAINER Mainflux

# Copy custom configuration file from the current directory
COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d/* /etc/nginx/conf.d

VOLUME /var/log/nginx/log
