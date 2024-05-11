FROM debian:bullseye

ENV WORKDIR_PATH /var/www/html/wp
WORKDIR $WORKDIR_PATH

RUN set -eux \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
  ca-certificates gosu \
  wget mariadb-client php7.4 php7.4-mysqli php-fpm vim \
  && rm -rf /var/lib/apt/lists/*

RUN set -eux \
  && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp \
  && chmod +x /usr/local/bin/wp \
  && mkdir -p /run/php

RUN set -eux \
  && mkdir -p $WORKDIR_PATH \
  && chown -R www-data:www-data /var/www \
  && gosu www-data wp core download

VOLUME $WORKDIR_PATH

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000

CMD ["entrypoint.sh"]
