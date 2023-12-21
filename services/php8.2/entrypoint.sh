#!/bin/sh
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
echo ""
echo "***********************************************************"
echo "   Starting LARAVEL PHP-FPM Container                      "
echo "***********************************************************"

set -e

## Check if the supervisor config file exists
if [ -f /var/www/html/conf/worker/supervisor.conf ]; then
    echo "additional supervisor config found"
    cp /var/www/html/conf/worker/supervisor.conf /etc/supervisor/conf.d/supervisor.conf
    else
    echo "${Red} Supervisor.conf not found"
    echo "${Green} If you want to add more supervisor configs, create config file in /var/www/html/conf/worker/supervisor.conf"
    echo "${Green} Start supervisor with default config..."
    fi
## Check if php.ini file exists
if [ -f /var/www/html/conf/php/php.ini ]; then
    cp /var/www/html/conf/php/php.ini $PHP_INI_DIR/conf.d/
    echo "Custom php.ini file found and copied in  $PHP_INI_DIR/conf.d/"
else
    echo "Custom php.ini file not found"
    echo "If you want to add a custom php.ini file, you add it in /var/www/html/conf/php/php.ini"
fi

# echo ""
# echo "**********************************"
# echo "     Starting Supervisord...     "
# echo "***********************************"
# supervisord -c /etc/supervisor/supervisord.conf

# echo ""
# echo "**********************************"
# echo "     Starting PHP-FPM...     "
# echo "***********************************"

# rm -rf /usr/local/etc/php-fpm.d/zz-docker.conf

# set the permission to storage folders
chmod -R o+w /var/www/html/storage /var/www/html/bootstrap/cache

# Run composer install/update if vendor folder does not exists
# if [ ! -d "/var/www/html/vendor" ]; then
#     composer update
# fi

# # Run npm install if node_modules folder does not exists
# if [ ! -d "/var/www/html/node_modules" ]; then
#     npm install
# fi

php-fpm --nodaemonize
