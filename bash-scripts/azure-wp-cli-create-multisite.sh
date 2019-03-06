#!/bin/bash

#Variables --------------------
#$1 = db name
#$2 = db user 
#$3 = db password
#$4 = db host
#$5 = site url 
#$6 = admin user 
#$7 = admin password 
#$8 = admin email

#Go to web root
#cd site/wwwroot;

#Get the 4.9.9 wp core
wp core download --version=4.9.9 ;

#Create wp-config.php
wp config create --dbname=$1 --dbuser=$2 --dbpass=$3 --dbhost=$4 ;

#Subfolder multisite
wp core multisite-install --title=$5 --url=$5 --admin_user=$6 --admin_password=$7 --admin_email=$8 ;

#Create .htaccess file
cat >.htaccess <<EOL
RewriteEngine On
RewriteBase /
RewriteRule ^index\.php$ - [L]

# add a trailing slash to /wp-admin
RewriteRule ^([_0-9a-zA-Z-]+/)?wp-admin$ \$1wp-admin/ [R=301,L]

RewriteCond %{REQUEST_FILENAME} -f [OR]
RewriteCond %{REQUEST_FILENAME} -d
RewriteRule ^ - [L]
RewriteRule ^([_0-9a-zA-Z-]+/)?(wp-(content|admin|includes).*) \$2 [L]
RewriteRule ^([_0-9a-zA-Z-]+/)?(.*\.php)$ \$2 [L]
RewriteRule . index.php [L]
EOL

#cat .htaccess ;

#Install aiom
wp plugin install all-in-one-wp-migration https://servmask.com/purchase/f2de6bb7-d3b8-442c-b40d-07a25856f822 https://servmask.com/purchase/49fb4af3-acaf-4e63-91a5-ca3df9f67ab7 --activate ;

#Update plugins just in case
wp plugin update --all ;


echo "*****************************************************" ;
echo "INSTALL COMPLETE! You can now go to: $5" ;
echo "*****************************************************" ;
