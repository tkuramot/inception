FROM debian:bullseye

RUN mkdir /docker-entrypoint-initdb.d

RUN set -x; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
  mariadb-server; \
  rm -rf /var/lib/apt/lists/*; \

COPY ./tools/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306

CMD ["mysqld"]
