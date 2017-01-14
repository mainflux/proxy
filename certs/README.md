# TLS in Mainflux

> *N.B.* Most of the procedures about setting-up TLS in NGINX are taken from
> [How To Create a Self-Signed SSL Certificate for Nginx in Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04)

### Key and Certificate Generation

Use `generate-CA.sh` script (described [here](http://rockingdlabs.dunmire.org/exercises-experiments/ssl-client-certs-to-secure-mqtt)):

For server-side certificates:
```
generate-CA.sh mainflux-server
```

For client side certificates:
```
generate-CA.sh client mainflux-client
```

Then you can SUB with something like:
```
mosquitto_sub -t mainflux/channels/a57cc963-c152-4fd2-9398-59495916babe -p 8883 -v --cafile ./certs/ca.crt
```

or PUB with something like:
```
mosquitto_pub -t mainflux/channels/a57cc963-c152-4fd2-9398-59495916babe -m '[{"bn":"AAAAA","bt":1.276020076001e+09, "bu":"A","bver":5, "n":"voltage","u":"V","v":120.1}, {"n":"current","t":-5,"v":1.2}, {"n":"current","t":-4,"v":1.3}]' -p 8883 --cafile ./certs/ca.crt
```

### CSR, CA and KEY - Manual Generation
All the keys can be generated via `generate-CA.sh` script as mentioned above, but the following chapter explains the process of generation in more details.

Following the instructions [here](https://help.github.com/enterprise/11.10.340/admin/articles/using-self-signed-ssl-certificates/), [here](http://uwsgi-docs.readthedocs.io/en/latest/HTTPS.html) and especially [here](http://www.shellhacks.com/en/HowTo-Create-CSR-using-OpenSSL-Without-Prompt-Non-Interactive)

Here is how we can do it:

- Create the CA root key:
```bash
openssl genrsa -out ca.key 2048
```

- Self-sign rootCA certificate
```
openssl req -x509 -new -nodes -key ca.key -sha256 -days 1024 -out ca.crt \
			-subj "/C=FR/ST=IDF/L=Paris/O=Mainflux/OU=IoT/CN=localhost"
```

- This can be done in one go:
```
openssl req -newkey rsa:2048 -x509 -nodes -sha512 -days 5475 -extensions v3_ca \
			-keyout ca.key -out ca.crt -subj /CN=localhost/O=Mainflux/OU=IoT/emailAddress=info@mainflux.com
```

- Generate new key and [CSR](https://en.wikipedia.org/wiki/Certificate_signing_request):
```bash
openssl req -new -sha512 -out mainflux-server.csr -key mainflux-server.key \
			-subj /CN=Lenin/O=Mainflux/OU=IoT/emailAddress=info@mainflux.com
```

- Use root CA key (`ca.key`) to sign CSR:
```
openssl x509 -req -sha512 -in mainflux-server.csr \
			-CA ca.crt -CAkey ca.key -CAcreateserial -CAserial ca.srl \
			-out mainflux-server.crt -days 5475 -extfile /tmp/cacnf.kAXcnZPl -extensions MFXextensions
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
### MQTT Testing
You can SUB with something like:
```
mosquitto_sub -t mainflux/channels/a57cc963-c152-4fd2-9398-59495916babe -p 8883 -v --cafile ./certs/ca.crt
```

or PUB with something like:
```
mosquitto_pub -t mainflux/channels/a57cc963-c152-4fd2-9398-59495916babe -m '[{"bn":"AAAAA","bt":1.276020076001e+09, "bu":"A","bver":5, "n":"voltage","u":"V","v":120.1}, {"n":"current","t":-5,"v":1.2}, {"n":"current","t":-4,"v":1.3}]' -p 8883 --cafile ./certs/ca.crt
