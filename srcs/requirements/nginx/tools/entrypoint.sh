#!/bin/bash

envsubst '$$DOMAIN_BLOG$$DOMAIN_GALLERY' < /etc/nginx/template/default.conf.template > /etc/nginx/conf.d/default.conf

nginx
