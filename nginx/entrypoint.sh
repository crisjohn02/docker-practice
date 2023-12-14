#!/bin/sh
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
echo ""
echo "***********************************************************"
echo " Starting Nginx-FPM Docker Container                 "
echo "***********************************************************"

set -e

  TASK=/etc/nginx/conf.d/default.conf
  touch $TASK
  cat > "$TASK"  <<EOF
   server {
    listen 80 default_server;
    listen [::]:80 default_server;  
    server_name $DOMAIN;
    # Add index.php to setup Nginx, PHP & PHP-FPM config
    index index.php index.html index.htm index.nginx-debian.html;
    error_log  /var/log/nginx/error.log;
    access_log /var/log/nginx/access.log;
    root $DOCUMENT_ROOT;
    # pass PHP scripts on Nginx to FastCGI (PHP-FPM) server
    location ~ \.php$ {
        try_files \$uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        # Nginx php-fpm config:
        fastcgi_pass $PHP_FPM_HOST;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_param PATH_INFO \$fastcgi_path_info;
        
    }
    client_max_body_size $CLIENT_MAX_BODY_SIZE;

     # Hide PHP headers 
    fastcgi_hide_header X-Powered-By; 
    fastcgi_hide_header X-CF-Powered-By;
    fastcgi_hide_header X-Runtime;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
        gzip_static on;
    }
    location ~ \.css {
    add_header  Content-Type    text/css;
    }
    location ~ \.js {
    add_header  Content-Type    application/x-javascript;
    }
  # Deny access
  location ~ /\.ht    {deny all;}
	location ~ /\.svn/  {deny all;}
	location ~ /\.git/  {deny all;}
	location ~ /\.hg/   {deny all;}
	location ~ /\.bzr/  {deny all;}
}
EOF

echo ""
echo "**********************************"
echo "     Starting Nginx web server...     "
echo "***********************************"
/usr/sbin/nginx -g "daemon off;"