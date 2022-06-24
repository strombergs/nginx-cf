ARG NGINX_TAG=1.23.0

FROM nginx:${NGINX_TAG}

LABEL org.opencontainers.image.version=${NGINX_TAG}
LABEL org.opencontainers.image.authors="phillip@strombergs.com"
LABEL org.opencontainers.image.description="Nginx container ready for Cloudflare traffic"

RUN rm /etc/nginx/conf.d/default.conf \
    && mkdir -p /etc/nginx/conf.d/sites /var/www

COPY ./docker-entrypoint.d/* /docker-entrypoint.d/
COPY ./conf.d/* /etc/nginx/conf.d/
COPY ./content/* /var/www/default/
COPY ./includes/* /etc/nginx/includes/
COPY ./ssl/* /etc/nginx/ssl/

RUN chmod +x /docker-entrypoint.d/*

EXPOSE 80/tcp
EXPOSE 443/tcp
EXPOSE 443/udp
