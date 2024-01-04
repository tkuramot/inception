#!/bin/bash
set -eux

# insatall db when it is not installed
if [ ! -d /var/lib/mysql/mysql ]; then
  mysql_install_db --user=root --datadir=/var/lib/mysql
fi

exec mariadbd --user=root \
  --datadir=/var/lib/mysql \
  --default-authentication-plugin=mysql_native_password \
  --skip-grant-tables \
  --skip-bind-address

