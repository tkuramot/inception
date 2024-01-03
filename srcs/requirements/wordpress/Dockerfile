FROM debian:bullseye

WORKDIR /var/www/html

RUN set -x \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
  wordpress \
  mariadb-client \
  && rm -rf /var/lib/apt/lists/*
