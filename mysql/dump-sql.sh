#!/usr/bin/env bash

mysql --user=root --password="$MYSQL_ROOT_PASSWORD" $MYSQL_DATABASE < /var/www/db/$MYSQL_DATABASE.sql