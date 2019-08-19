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

#Example of how to call the script:
#$ sh azure-wp-cli-create-multisite.sh db_name db_username db_password db_host https://siteurl.com wp_username wp_userpass wp_useremail

#Go to web root
cd /home/site/wwwroot/ ;

#Get the wp core
#wp core download --allow-root ;

#Create wp-config.php
wp config create --dbname=$1 --dbuser=$2 --dbpass=$3 --dbhost=$4 --allow-root ;

#Subfolder multisite
wp core install --title=$5 --url=$5 --admin_user=$6 --admin_password=$7 --admin_email=$8 --allow-root ;

#Install Updraft Plus, 2FA, SEO Framework, WP-Optimize and ReSmush.it
wp plugin install updraftplus two-factor autodescription wp-optimize resmushit-image-optimizer --activate --allow-root ;

#Update plugins just in case
wp plugin update --all --allow-root ;

__odi="
   ______      ______                     
  / ____/___ _/ / __ \________  __________
 / /   / __  / / /_/ / ___/ _ \/ ___/ ___/
/ /___/ /_/ / / ____/ /  /  __(__  |__  ) 
\____/\__,_/_/_/   /_/   \___/____/____/
"
echo "$__odi"
echo "Install completed, you can now go to: $5" ;