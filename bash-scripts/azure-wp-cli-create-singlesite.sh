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
#$ sh azure-wp-cli-create-singlesite.sh Site-title http://siteurl.com wp_username wp_userpass wp_useremail

#Go to web root
echo "Going to site root" ;
cd /home/site/wwwroot/ ;

#Get the wp core
#wp core download --allow-root ;

#Update wp-config via wp-commands.php

content=$(wget $2/wp-commands.php -q -O -) ;
echo $content ;


#Install single site
wp core install --title=$1 --url=$2 --admin_user=$3 --admin_password=$4 --admin_email=$5 --allow-root ;

#Install theme
wp theme install https://github.com/timloden/CAWeb-Standard/archive/master.zip --activate --allow-root ;

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