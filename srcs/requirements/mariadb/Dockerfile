FROM debian:bullseye

RUN mkdir /docker-entrypoint-initdb.d

RUN set -x \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
  mariadb-server \
  # mariadb-backup \
  # socat \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/lib/mysql /etc/mysql/mariadb.conf.d/50-mysqld_safe.cnf \
	&& mkdir -p /var/lib/mysql /run/mysqld \
	&& chown -R mysql:mysql /var/lib/mysql /run/mysqld \
	&& chmod 1777 /run/mysqld

COPY ./tools/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306

CMD ["mysqld"]
