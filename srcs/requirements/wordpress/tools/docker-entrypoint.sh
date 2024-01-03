#!/bin/bash
set -eux

directory="/var/www/html/wordpress"

# Set up WordPress website using wp-cli if it's not configured yet.
if [ ! -f "${directory}/wp-config.php" ]; then
  wp config create \
    --dbhost="${WORDPRESS_DB_HOST}" \
    --dbuser="${WORDPRESS_DB_USER}" \
    --dbpass="${WORDPRESS_DB_PASSWORD}" \
    --dbname="${WORDPRESS_DB_NAME}"
    --path="${directory}"

  wp core install \
    --url="${DOMAIN_NAME}" \
    --title="${WORDPRESS_TITLE}" \
    --admin_user="${WORDPRESS_ADMIN_USER}" \
    --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
    --admin_email="${WORDPRESS_ADMIN_EMAIL}"
    --path="${directory}"

  wp option update permalink_structure /%postname%/
fi

tail -f /dev/null
