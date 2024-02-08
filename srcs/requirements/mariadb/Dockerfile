FROM debian:bullseye

RUN set -ux \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
  mariadb-server \
  vim \
  && rm -rf /var/lib/apt/lists/*

RUN set -ux \
  && mkdir -p /var/lib/mysql /run/mysqld \
  && chown -R mysql:mysql /var/lib/mysql /run/mysqld \
  && chmod 1777 /run/mysqld

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3306

CMD ["entrypoint.sh"]
