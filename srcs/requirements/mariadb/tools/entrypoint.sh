#!/bin/bash
set -eux

install () {
  mysql_install_db --user=root --datadir=/var/lib/mysql
}

temp_server_start () {
  mariadbd --skip-networking --default-time-zone=SYSTEM --socket="/run/mysqld/mysqld.sock" --wsrep_on=OFF \
    --expire-logs-days=0 \
    --loose-innodb_buffer_pool_load_at_startup=0 &
  declare -g MARIADB_PID
  MARIADB_PID=$!
  echo "Waiting for server to start"

  for i in {30..0}; do
    if mysql --database=mysql <<<'SELECT 1'; then
      break
    fi
    sleep 1
  done
  if [ "$i" = 0 ]; then
    echo "Unable to start server." >&2
  fi
}

temp_server_stop () {
  kill "$MARIADB_PID"
  wait "$MARIADB_PID"
}

create_user () {
  if [ -z $1 ] || [ -z $2 ]; then
    echo "user and password are required"
    exit 1
  fi

  if mysql -u root -e "SELECT 1 FROM mysql.user WHERE user = '$1'" | grep -q 1; then
    return
  fi

  mysql -u root <<-EOSQL
		CREATE USER '$1'@'%' IDENTIFIED BY '$2';
		GRANT ALL PRIVILEGES ON *.* TO '$1'@'%' WITH GRANT OPTION;
		FLUSH PRIVILEGES;
	EOSQL
}

main () {
  # insatall db when it is not
  if [ ! -d /var/lib/mysql/mysql ]; then
    install
  fi

  temp_server_start
  create_user "$MYSQL_USER" "$MYSQL_PASSWORD"
  temp_server_stop

  exec mariadbd \
    --datadir=/var/lib/mysql \
    --default-authentication-plugin=mysql_native_password \
    --skip-bind-address
}

main
