FROM debian:bullseye

RUN set -x; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    nginx \
    vim; \
  rm -rf /var/lib/apt/lists/*

RUN rm -rf /etc/nginx/sites-enabled/*
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/sites-available/* /etc/nginx/sites-available/
COPY ./ssl/* /etc/nginx/ssl/
RUN ln -s /etc/nginx/sites-available/* /etc/nginx/sites-enabled/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
