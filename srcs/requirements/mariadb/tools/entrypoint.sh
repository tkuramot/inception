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
  user=$1
  password=$2

  if [ -z $user ] || [ -z $password ]; then
    echo "user and password are required"
    exit 1
  fi

  if mysql -u root -e "SELECT 1 FROM mysql.user WHERE user = '$user'" | grep -q 1; then
    return
  fi

  mysql -u root <<-EOSQL
		CREATE USER '$user'@'%' IDENTIFIED BY '$password';
		GRANT ALL PRIVILEGES ON *.* TO '$user WITH GRANT OPTION;
		FLUSH PRIVILEGES;
	EOSQL
}

create_db () {
  db=$1
  if [ -z $db ]; then
    echo "db is required"
    exit 1
  fi
  mysql -u root <<-EOSQL
		CREATE DATABASE IF NOT EXISTS $db;
	EOSQL
}

main () {
  # insatall db when it is not
  if [ ! -d /var/lib/mysql/mysql ]; then
    install
  fi

  temp_server_start
  create_user "$MYSQL_USER" "$MYSQL_PASSWORD"
  create_db "$MYSQL_DB_NAME"
  temp_server_stop

  exec mariadbd \
    --datadir=/var/lib/mysql \
    --default-authentication-plugin=mysql_native_password \
    --skip-bind-address
}

main
