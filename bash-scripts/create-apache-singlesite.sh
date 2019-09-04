#!/bin/bash

#Go to web root
echo "Going to site root" ;
cd /home/site/wwwroot/ ;

# Get the wp core
wp core download --allow-root ;

#Copy wp-commands.php
echo "copying wp-commands.php..."
cp /usr/local/bin/devops/wp-commands.php /home/site/wwwroot/wp-commands.php ;
echo "copied wp-commands.php"

# Run wp-commands.php directly
wp eval-file wp-commands.php --allow root ;

#Remove wp-commands file
echo "deleting wp-commands.php..."
rm /home/site/wwwroot/wp-commands.php ;
echo "deleted wp-commands.php"

# Create .htaccess file
cat >.htaccess <<EOL
# BEGIN WordPress

RewriteEngine On
RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [L]

# END WordPress

RewriteCond %{HTTP:X-ARR-SSL} ^$
RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]
EOL

echo ".htaccess created" ;

# Add SSL force to wp-config

sed -i '/table_prefix/a define("FORCE_SSL_ADMIN", true); if ( isset($_SERVER["HTTP_X_ARR_SSL\"]) ) $_SERVER["HTTPS"]="on";' wp-config.php

echo "updated wp-config with Azure specific SSL lines" ;

__odi="
   ______      ______                     
  / ____/___ _/ / __ \________  __________
 / /   / __  / / /_/ / ___/ _ \/ ___/ ___/
/ /___/ /_/ / / ____/ /  /  __(__  |__  ) 
\____/\__,_/_/_/   /_/   \___/____/____/
"
echo "$__odi"
echo "Install completed, you can now go to: $1" ;