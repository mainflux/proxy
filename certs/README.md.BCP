# TLS in Mainflux

> *N.B.* Most of the procedures about setting-up TLS in NGINX are taken from
> [How To Create a Self-Signed SSL Certificate for Nginx in Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04)

## Key and Certificate Generation

### CSR, CA and KEY
Following the instructions [here](https://help.github.com/enterprise/11.10.340/admin/articles/using-self-signed-ssl-certificates/), [here](http://uwsgi-docs.readthedocs.io/en/latest/HTTPS.html) and especially [here](http://www.shellhacks.com/en/HowTo-Create-CSR-using-OpenSSL-Without-Prompt-Non-Interactive)

Here is how we can do it:

- Create the private key:
```bash
openssl genrsa -out mainflux.key 2048
```

- Use this key to generate [CSR](https://en.wikipedia.org/wiki/Certificate_signing_request):
```bash
openssl req -new -key mainflux.key -out mainflux.csr
```
> Answer questions here and make sure the Common Name (CN) is set to the FQDN, hostname or IP address of the machine you're going to put this on. In our case we use `localhost`, as we do development on `localhost`

- Use the same key to sign certificate. Normally it does not work this way - you would send `.csr` file to [CA](https://en.wikipedia.org/wiki/Certificate_authority) which will use their key (for example `ca.key`) to create `.crt` file for you and then send it back to you.
But in our case we are creating self-signed certificate, and we use our private key to sign it:
```bash
openssl x509 -req -days 365 -in mainflux.csr -signkey mainflux.key -out mainflux.crt
```

Note that creating private key and creating `.csr` file can be done in one command:
```bash
openssl req -nodes -newkey rsa:2048 -keyout mainflux.key \
  -out mainflux.csr -subj "/C=FR/ST=IDF/L=Paris/O=Mainflux/OU=IoT/CN=localhost"
openssl x509 -req -days 365 -in mainflux.csr -signkey mainflux.key -out mainflux.crt
```

Finally, note that since we are not sending CSR to CA, but we are signing our certificate with our private key instead - we do not even need to generate `.csa` file. Then whole procedure can be done in just one command:
```bash
openssl req -x509 -nodes -newkey rsa:2048 \
  -keyout mainflux.key -out mainflux.crt -days 365 \
  -subj "/C=FR/ST=IDF/L=Paris/O=Mainflux/OU=IoT/CN=localhost"
```

### Diffie-Hellman
We should also create a strong Diffie-Hellman group, which is used in negotiating [Perfect Forward Secrecy](https://en.wikipedia.org/wiki/Forward_secrecy) with clients.

```bash
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
```
This may take a few minutes, but when it's done you will have a strong DH group at `/etc/ssl/certs/dhparam.pem`.

## SSL Debugging
Following the instructions [here](https://www.kamailio.org/wiki/tutorials/tls/testing-and-debugging)
```bash
openssl s_client -connect localhost:443 -no_ssl2 -bugs
```

```bash
openssl s_client -showcerts -debug -connect localhost:443 -no_ssl2 -bugs
```

### Curl Testing
```bash
curl --cacert tls/mainflux.crt https://localhost:443/devices
```
or more verbose and with prett-print:
```bash
curl -v -s -i -H "Accept: application/json" -H "Content-Type: application/json" \
  --cacert tls/mainflux.crt https://localhost:443/devices | json | pygmentize -l json
```

