# Traefik Proxy
Traefik configuration for Mainflux cloud.

## Install
### Docker
```
docker pull traefik
docker run -d -p 8080:8080 -p 80:80 \
    -v $PWD/traefik.toml:/etc/traefik/traefik.toml \
    -v /var/run/docker.sock:/var/run/docker.sock \
    traefik
```

### Local Machine
```
wget https://github.com/containous/traefik/releases/download/v1.4.0-rc2/traefik_linux-amd64
```
## Run
```
sudo ./traefik --configFile=traefik.toml
```
