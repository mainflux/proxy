# Mainflux NGINX

[![License](https://img.shields.io/badge/license-Apache%20v2.0-blue.svg)](LICENSE) [![Join the chat at https://gitter.im/Mainflux/mainflux](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/Mainflux/mainflux?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

NGINX reverse proxy for Mainflux IoT platform.

### Installation

> *N.B.* Most of the procedures about setting-up TLS in NGINX are taken from
> [How To Create a Self-Signed SSL Certificate for Nginx in Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04)

> Change `nginx.conf` to use `www-data` as a user if you are on Debian
(on Alpine Linux which is used for Docker user is `nginx`).

Prepare NGINX environment by executing [install-env.sh](https://github.com/mainflux/mainflux-nginx/blob/master/install-env.sh):
```bash
sudo sh install-env.sh
```
Reload nginx config:
```bash
sudo service nginx reload
```

### Using
#### Curl Testing
```bash
curl --cacert tls/mainflux-selfsigned.crt https://localhost:443/devices
```
or more verbose and with prett-print:
```bash
curl -v -s -i -H "Accept: application/json" -H "Content-Type: application/json" \
  --cacert tls/mainflux-selfsigned.crt https://localhost:443/devices | json | pygmentize -l json
```

### Documentation
Development documentation can be found on our [Mainflux GitHub Wiki](https://github.com/Mainflux/mainflux/wiki).

Swagger-generated API reference can be foud at [http://mainflux.com/apidoc](http://mainflux.com/apidoc).

### Community
#### Mailing lists
- [mainflux-dev](https://groups.google.com/forum/#!forum/mainflux-dev) - developers related. This is discussion about development of Mainflux IoT cloud itself.
- [mainflux-user](https://groups.google.com/forum/#!forum/mainflux-user) - general discussion and support. If you do not participate in development of Mainflux cloud infrastructure, this is probably what you're looking for.

#### IRC
[Mainflux Gitter](https://gitter.im/Mainflux/mainflux?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

#### Twitter
[@mainflux](https://twitter.com/mainflux)

### License
[Apache License, version 2.0](LICENSE)
