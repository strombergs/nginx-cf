# nginx-cf

## Extensible NGINX Container for Cloudflare and Docker-Compose

Creates an nginx container with sensible defaults. It is designed for using 
Cloudflare as a reverse proxy. It trusts only Cloudflare IP blocks for the 
`CF-Connecting-IP` header.

### Sites

Add sites by doing making a `docker-compose.override.yml` and putting 
additional site `.conf` files in this container's `/etc/nginx/conf.d/sites`
folder.

### Cloudflare IPs

There is a script called `update-cf-ip-list.sh` that goes into the 
`/docker-entrypoint.d/` folder to make it run each time the container is run.
It updates the file `/etc/nginx/conf.d/real-ip.conf` with the latest Cloudflare 
netblocks by querying this [Cloudflare Worker's URL][cfupdater].

### Logging

The log format is modified slightly from default to include Cloudflare headers
like `CF-IPCountry`, `CF-Ray`, and what Cloudflare Worker (if any) was used 
(header `CF-Worker`).

### SSL

A self-signed certificate is generated on `docker run` thanks to the 
`self-signed.sh` script in `/docker-entrypoint.d`. This means you can use 
Cloudflare's "Full" SSL setting but not "Full (Strict)". For that you would 
need to use one of their SSL certificates and mount it into the container 
instead. This is just meant to get you bootstrapped fast.

   [cfupdater]: <https://cf-do-firewall-sync.strombergs.workers.dev/>
