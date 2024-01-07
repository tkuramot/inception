FROM debian:bullseye

RUN set -x; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    nginx \
    vim; \
  rm -rf /var/lib/apt/lists/*

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

# RUN nginx -t

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
