#!/bin/bash
SHOPWAREBUILD_GIT_REPO="https://github.com/shopware/shopware.git"
SHOPWAREBUILD_DB_HOST="db"
SHOPWAREBUILD_DB_NAME="shopware"
SHOPWAREBUILD_DB_USER="root"
SHOPWAREBUILD_DB_PASSWORD="shopware"
SHOPWAREBUILD_DB_PORT="3306"
SHOPWAREBUILD_APP_PATH=""
SHOPWAREBUILD_APP_HOST="shopwaredemo.in"
SHOPWAREBUILD_ANT_TARGET="build-unit"
SHOPWAREBUILD_DEMO_ZIP="http://releases.s3.shopware.com/test_images.zip"


if [ ! -e /var/www/html/shopware.php ]; then
    "Shopware not found, installing...\n"
    rm -f /var/www/html/index.html
	git clone $SHOPWAREBUILD_GIT_REPO /var/www/html
printf "%s\t%s\n" "$(date)" "Configuring Build properties..."
	cat > /var/www/html/build/build.properties << EOF
db.host=$SHOPWAREBUILD_DB_HOST
db.name=$SHOPWAREBUILD_DB_NAME
db.user=$SHOPWAREBUILD_DB_USER
db.password=$SHOPWAREBUILD_DB_PASSWORD
db.port=$SHOPWAREBUILD_DB_PORT
app.path=$SHOPWAREBUILD_APP_PATH
app.host=$SHOPWAREBUILD_APP_HOST
EOF
    if [ $SHOPWAREBUILD_ANT_TARGET != "" ]; then
	    ant -f /var/www/html/build/build.xml  $SHOPWAREBUILD_ANT_TARGET
	fi

	if [ $SHOPWAREBUILD_DEMO_ZIP != "" ]; then
printf "%s\t%s\n" "$(date)" "Loading Demo-Data"
		curl -Lo /var/www/html/demo_data.zip #$SHOPWAREBUILD_DEMO_ZIP
		unzip /var/www/html/demo_data.zip
		rm /var/www/html/demo_data.zip
	fi
printf "%s\t%s\n" "$(date)" "done building"
fi

printf "%s\t%s\n" "$(date)" "Setting permissions..."
	chown -R www-data:www-data /var/www/html/*
printf "%s\t%s\n" "$(date)" "Done"