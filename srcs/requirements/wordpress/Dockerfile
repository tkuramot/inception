FROM debian:bullseye

ENV WORKDIR_PATH /var/www/html
WORKDIR $WORKDIR_PATH

RUN set -ux \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
  ca-certificates gosu \
  wget mariadb-client php7.4 php7.4-mysqli php-fpm vim \
  && rm -rf /var/lib/apt/lists/*

RUN set -ux \
  && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp \
  && chmod +x /usr/local/bin/wp \
  && mkdir -p /run/php

RUN set -ux \
  && mkdir -p /var/www/html \
  && chown -R www-data:www-data $WORKDIR_PATH

VOLUME $WORKDIR_PATH

RUN set -ux \
  && gosu www-data wp core download

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000

CMD ["entrypoint.sh"]
