#!/bin/bash
set -eux

directory="/var/www/html"
index_file="${directory}/index.php"
config_file="${directory}/wp-config.php"

# check if wordpress is already downloaded
if [ ! -f "$index_file" ]; then
  gosu www-data wp core download
fi

# check if wp-config.php exists
if [ ! -f "$config_file" ]; then
  gosu www-data wp config create --dbname=${WORDPRESS_DB_NAME} --dbuser=${WORDPRESS_DB_USER} --dbpass=${WORDPRESS_DB_PASSWORD} --dbhost=${WORDPRESS_DB_HOST}
  gosu www-data wp db create
fi

# check if WordPress is already installed
if ! gosu www-data wp core is-installed; then
  gosu www-data wp core install
  gosu www-data wp option update permalink_structure /%postname%/
fi

tail -f /dev/null

