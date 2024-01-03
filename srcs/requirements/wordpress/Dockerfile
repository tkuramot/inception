FROM debian:bullseye

WORKDIR /var/www/html

RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
  wget \
  ca-certificates \
  php \
  php-fpm; \
  rm -rf /var/lib/apt/lists/*; \
  wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp; \
  chmod +x /usr/local/bin/wp;

COPY ./tools/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chown -R www-data:www-data /var/www; \
  chmod +x /usr/local/bin/docker-entrypoint.sh

USER www-data
RUN wp core download --locale=ja

EXPOSE 9000

CMD ["docker-entrypoint.sh"]
