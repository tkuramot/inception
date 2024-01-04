#!/bin/bash
set -eux

mysql_install_db --user=root --datadir=/var/lib/mysql

exec mariadbd --user=root \
  --datadir=/var/lib/mysql \
  --default-authentication-plugin=mysql_native_password \
  --skip-grant-tables \
  --skip-bind-address

