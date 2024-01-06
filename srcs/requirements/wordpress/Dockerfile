FROM debian:bullseye

WORKDIR /var/www/html
ENV WP_CLI_CONFIG_PATH=/etc/wp-cli.yml

RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
  ca-certificates \
  gosu \
  mariadb-client \
  wget \
  php7.4 \
  php7.4-mysqli \
  php-fpm \
  vim; \
  rm -rf /var/lib/apt/lists/*; \
  wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp; \
  chmod +x /usr/local/bin/wp; \
  chown -R www-data:www-data /var/www; \
  mkdir -p /run/php

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000

CMD ["entrypoint.sh"]
