#!/bin/bash

# find /etc/nginx/template -type f -name "*.template" \
#   -exec sh -c "envsubst < {} > /etc/nginx/conf.d$(basename {} .template)" \;

envsubst '$$DOMAIN_BLOG' < /etc/nginx/template/blog.conf.template > /etc/nginx/conf.d/blog.conf

nginx
