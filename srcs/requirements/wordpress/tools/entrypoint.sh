#!/bin/bash
set -eux

directory="/var/www/html"
index_file="${directory}/index.php"
config_file="${directory}/wp-config.php"

env

# check if wordpress is already downloaded
if [ ! -f "$index_file" ]; then
  gosu www-data wp core download --locale=ja --version="${WORDPRESS_VERSION}"
fi

# check if wp-config.php exists
if [ ! -f "$config_file" ]; then
  gosu www-data wp config create \
    --dbname="${WORDPRESS_DB_NAME}" \
    --dbuser="${WORDPRESS_DB_USER}" \
    --dbpass="${WORDPRESS_DB_PASSWORD}" \
    --dbhost="${WORDPRESS_DB_HOST}"
  gosu www-data wp db create
fi

# check if WordPress is already installed
if ! gosu www-data wp core is-installed; then
  gosu www-data wp core install \
    --url="${DOMAIN_NAME}" \
    --title="${WORDPRESS_TITLE}" \
    --admin_user="${WORDPRESS_ADMIN_USER}" \
    --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
    --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
    --skip-email
  gosu www-data wp option update permalink_structure /%postname%/
fi

exec php-fpm7.4 -F
