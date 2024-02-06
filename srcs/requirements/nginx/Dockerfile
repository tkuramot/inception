FROM debian:bullseye

RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    gettext \
    nginx \
    vim; \
  rm -rf /var/lib/apt/lists/*

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/default.conf.template /etc/nginx/template/default.conf.template
COPY ./ssl/* /etc/nginx/ssl/

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 443

CMD ["entrypoint.sh"]
