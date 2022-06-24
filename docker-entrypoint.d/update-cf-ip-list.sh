#!/bin/bash
set -euo pipefail

### Updates the real-ip.conf for nginx with the latest IP CIDRs for Cloudflare
# this is so that we know what IPs can be trusted to give us correct 
# proxy headers like X-Forwarded-For etc.

CF_NGINX_CONF=$(curl -sLf https://cf-do-firewall-sync.strombergs.workers.dev/)
NGINX_REAL_IP_CONF=/etc/nginx/conf.d/real-ip.conf

# check to see if this response was even a valid one
if echo "${CF_NGINX_CONF}" | grep -q "set_real_ip_from"; then
    printf '%s\n' "${CF_NGINX_CONF}" > "${NGINX_REAL_IP_CONF}"
fi
