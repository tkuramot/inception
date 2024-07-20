FROM debian:bullseye

RUN set -eux \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    gettext nginx vim \
  && rm -rf /var/lib/apt/lists/*

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/default.conf /etc/nginx/template/default.conf
COPY ./ssl/* /etc/nginx/ssl/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
