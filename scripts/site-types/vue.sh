#!/usr/bin/env bash

declare -A params=$6       # Create an associative array
declare -A headers=${9}    # Create an associative array
declare -A rewrites=${10}  # Create an associative array
paramsTXT=""
if [ -n "$6" ]; then
   for element in "${!params[@]}"
   do
      paramsTXT="${paramsTXT}
      fastcgi_param ${element} ${params[$element]};"
   done
fi
headersTXT=""
if [ -n "${9}" ]; then
   for element in "${!headers[@]}"
   do
      headersTXT="${headersTXT}
      add_header ${element} ${headers[$element]};"
   done
fi
rewritesTXT=""
if [ -n "${10}" ]; then
   for element in "${!rewrites[@]}"
   do
      rewritesTXT="${rewritesTXT}
      location ~ ${element} { if (!-f \$request_filename) { return 301 ${rewrites[$element]}; } }"
   done
fi

if [ "$7" = "true" ]
then configureXhgui="
location /${7} {
        try_files \$uri \$uri/ /${7}/index.html;
}
"
else configureXhgui=""
fi

listen_80="${3:-80}"
listen_443="${4:-443} ssl http2"
server_name=".$1"
if [[ "${11}" != "false" ]]; then
    listen_80="${3:-80} default_server"
    listen_443="${4:-443} default_server"
    server_name="_"
fi

sudo service apache2 stop
sudo systemctl disable apache2
sudo systemctl enable nginx

block="server {
    listen $listen_80;
    listen $listen_443;
    server_name $server_name;
    root \"$2\";

    index index.html index.htm;

    charset utf-8;
    client_max_body_size 100m;

    $rewritesTXT

    location / {
        try_files \$uri \$uri/ /index.html;
        $headersTXT
    }

    $configureXhgui

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    access_log off;
    error_log  /var/log/nginx/$1-error.log error;

    sendfile off;

    ssl_certificate     /etc/ssl/certs/$1.crt;
    ssl_certificate_key /etc/ssl/certs/$1.key;
}
"

echo "$block" > "/etc/nginx/sites-available/$1"
ln -fs "/etc/nginx/sites-available/$1" "/etc/nginx/sites-enabled/$1"
