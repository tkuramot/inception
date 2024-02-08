#!/bin/bash
set -eux

directory="/var/www/html"
config_file="${directory}/wp-config.php"

configure () {
  gosu www-data wp config create \
    --dbname="${MYSQL_DB_NAME}" \
    --dbuser="${MYSQL_USER}" \
    --dbpass="${MYSQL_PASSWORD}" \
    --dbhost="${MYSQL_HOST}" \
    --path="${directory}"
  gosu www-data wp db create --path="${directory}"
}

install () {
  gosu www-data wp core install \
    --url="${DOMAIN_BLOG}" \
    --title="${WORDPRESS_TITLE}" \
    --admin_user="${WORDPRESS_ADMIN_USER}" \
    --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
    --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
    --skip-email \
    --path="${directory}"
}

plugin () {
  gosu www-data wp plugin install redis-cache --activate --path="${directory}"
  gosu www-data wp config set WP_REDIS_HOST "${REDIS_HOST}"
  gosu www-data wp config set WP_REDIS_PORT "${REDIS_PORT}"
  gosu www-data wp redis enable --path="${directory}"
}

main () {
  configure || true
  install || true
  plugin || true

  exec php-fpm7.4 -F
}

main
