###
# Mainflux NGINX Dockerfile
###
FROM nginx:alpine
MAINTAINER Mainflux

ENV MFX_MANAGER_HOST mainflux-manager
ENV MFX_MANAGER_PORT 7070

ENV MFX_AUTH_HOST mainflux-auth
ENV MFX_AUTH_PORT 8180

RUN apk update && apk add git wget openssl && rm -rf /var/cache/apk/*

# Copy custom configuration file from the current directory
COPY . /var/opt/mainflux-nginx
RUN cd /var/opt/mainflux-nginx && sh install-env.sh && rm install-env.sh

VOLUME /var/log/nginx/log

# Dockerize
ENV DOCKERIZE_VERSION v0.2.0
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
	&& tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

###
# Run main command with dockerize
###
CMD dockerize -wait tcp://$MFX_MANAGER_HOST:$MFX_MANAGER_PORT \
				-wait tcp://$MFX_AUTH_HOST:$MFX_AUTH_PORT \
				-timeout 10s nginx -g "daemon off;"
