FROM debian:bullseye

ENV WORKDIR_PATH /var/www/html/wp
WORKDIR $WORKDIR_PATH

RUN set -eux \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
  ca-certificates gosu \
  wget lsof mariadb-client php7.4 php7.4-mysqli php-fpm vim \
  && rm -rf /var/lib/apt/lists/*

RUN set -eux \
  && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp \
  && chmod +x /usr/local/bin/wp \
  && mkdir -p /run/php

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
RUN chmod +x /usr/local/bin/entrypoint.sh

VOLUME $WORKDIR_PATH

EXPOSE 9000

CMD ["entrypoint.sh"]
