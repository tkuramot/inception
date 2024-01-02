FROM debian:bullseye

RUN set -x \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    nginx \
    vim \
  && rm -rf /var/lib/apt/lists/* \
  && nginx -t

COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
COPY ./index.html /var/www/index.html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
