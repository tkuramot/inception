#!/bin/bash
set -ux

directory="/var/www/html/wp"

chown -R www-data:www-data "${directory}"

install_wp () {
  gosu www-data wp config create \
    --dbname="${MYSQL_DB_NAME}" \
    --dbuser="${MYSQL_USER}" \
    --dbpass="${MYSQL_PASSWORD}" \
    --dbhost="${MYSQL_HOST}" \
    --path="${directory}" \
    --force

  gosu www-data wp core install \
    --url="${DOMAIN_BLOG}" \
    --title="${WORDPRESS_TITLE}" \
    --admin_user="${WORDPRESS_ADMIN_USER}" \
    --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
    --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
    --path="${directory}"

  gosu www-data wp user create \
    --role=editor \
    "${WORDPRESS_EDITOR_USER}" \
    "${WORDPRESS_EDITOR_EMAIL}" \
    --user_pass="${WORDPRESS_EDITOR_PASSWORD}" \
    --path="${directory}"
}

install_plugins () {
  gosu www-data wp config set WP_REDIS_HOST "${REDIS_HOST}"
  gosu www-data wp config set WP_REDIS_PORT "${REDIS_PORT}"
  gosu www-data wp plugin install redis-cache --activate --path="${directory}"
  gosu www-data wp redis enable --path="${directory}"
}

main () {
  if ! gosu www-data wp core is-installed --path="${directory}"; then
    install_wp
  fi
  if ! gosu www-data wp plugin is-installed redis-cache --path="${directory}"; then
    install_plugins
  fi

  exec php-fpm7.4 -F
}

main
