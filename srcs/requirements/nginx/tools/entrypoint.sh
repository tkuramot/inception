#!/bin/bash
set -eux

envsubst '$$DOMAIN_BLOG$$DOMAIN_GALLERY' < /etc/nginx/template/default.conf.template > /etc/nginx/conf.d/default.conf

exec nginx
