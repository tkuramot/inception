#!/bin/bash
set -eux

directory="/var/www/html"
index_file="${directory}/index.php"
config_file="${directory}/wp-config.php"

# check if wordpress is already downloaded
if [ ! -f "$index_file" ]; then
  gosu www-data wp core download --version="${WORDPRESS_VERSION}" --path="${directory}"
fi

# check if wp-config.php exists
if [ ! -f "$config_file" ]; then
  gosu www-data wp config create \
    --dbname="${WORDPRESS_DB_NAME}" \
    --dbuser="${WORDPRESS_DB_USER}" \
    --dbpass="${WORDPRESS_DB_PASSWORD}" \
    --dbhost="${WORDPRESS_DB_HOST}" \
    --path="${directory}"
  gosu www-data wp db create --path="${directory}"
fi

# check if WordPress is already installed
if ! gosu www-data wp core is-installed --path="${directory}"; then
  gosu www-data wp core install \
    --url="${DOMAIN_NAME}" \
    --title="${WORDPRESS_TITLE}" \
    --admin_user="${WORDPRESS_ADMIN_USER}" \
    --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
    --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
    --skip-email \
    --path="${directory}"
fi

exec php-fpm7.4 -F
