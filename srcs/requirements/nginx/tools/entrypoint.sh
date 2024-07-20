#!/bin/bash

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

exec nginx
