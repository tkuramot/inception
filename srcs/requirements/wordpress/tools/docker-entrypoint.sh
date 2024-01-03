#!/bin/bash
set -eux

directory="/var/www/html"
config_file="${directory}/wp-config.php"

# Set up WordPress website using wp-cli if it's not configured yet.
if [ ! -f "$config_file" ]; then
  wp core download
  wp config create
  wp db create
  wp core install
  wp option update permalink_structure /%postname%/
fi

tail -f /dev/null

