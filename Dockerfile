###
# Mainflux NGINX Dockerfile
###
FROM nginx:alpine
MAINTAINER Mainflux

env MFX_CORE_HOST mainflux-core
env MFX_CORE_PORT 7070

env MFX_AUTH_HOST mainflux-auth
env MFX_AUTH_PORT 8180

RUN apk update && apk add git && apk add wget && rm -rf /var/cache/apk/*

# Copy custom configuration file from the current directory
COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d/* /etc/nginx/conf.d

VOLUME /var/log/nginx/log

# Dockerize
ENV DOCKERIZE_VERSION v0.2.0
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
	&& tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

###
# Run main command with dockerize
###
CMD dockerize -wait tcp://$MFX_CORE_HOST:$MFX_CORE_PORT \
				-wait tcp://$MFX_AUTH_HOST:$MFX_AUTH_PORT \
				-timeout 10s nginx -g "daemon off;"
