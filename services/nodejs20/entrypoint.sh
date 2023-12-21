#!/bin/sh
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
echo ""
echo "***********************************************************"
echo "   Starting Node server                    "
echo "***********************************************************"

set -e

# npm install if node_modules folder does not exists
if [ ! -d "/var/www/html/node_modules" ]; then
    npm install
fi

# Run the nodejs server
node widget.js --port=3000
