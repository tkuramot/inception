FROM debian:bullseye

RUN set -x \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    nginx \
    vim \
  && rm -rf /var/lib/apt/lists/* \
  && nginx -t

COPY ./conf/conf.d /etc/nginx/conf.d
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
