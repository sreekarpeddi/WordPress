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

# Get the wp core
wp core download --allow-root ;

#Copy wp-commands.php
echo "copying wp-commands.php..."
cp /usr/local/bin/devops/wp-commands-multisite.php /home/site/wwwroot/wp-commands-multisite.php ;
echo "copied wp-commands.php"

# Run wp-commands.php directly
wp eval-file wp-commands-multisite.php --allow root ;

#Remove wp-commands file
echo "deleting wp-commands.php..."
rm /home/site/wwwroot/wp-commands-multisite.php ;
echo "deleted wp-commands.php"

#Create .htaccess file
cat >.htaccess <<EOL
php_value upload_max_filesize 1000M
php_value post_max_size 2000M
php_value memory_limit 3000M
php_value max_execution_time 180
php_value max_input_time 180

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

# BEGIN DEFLATE COMPRESSION
<IfModule mod_deflate.c>
# Compress HTML, CSS, JavaScript, Text, XML and fonts
 AddOutputFilterByType DEFLATE application/javascript
 AddOutputFilterByType DEFLATE application/rss+xml
 AddOutputFilterByType DEFLATE application/vnd.ms-fontobject
 AddOutputFilterByType DEFLATE application/x-font
 AddOutputFilterByType DEFLATE application/x-font-opentype
 AddOutputFilterByType DEFLATE application/x-font-otf
 AddOutputFilterByType DEFLATE application/x-font-truetype
 AddOutputFilterByType DEFLATE application/x-font-ttf
 AddOutputFilterByType DEFLATE application/x-javascript
 AddOutputFilterByType DEFLATE application/xhtml+xml
 AddOutputFilterByType DEFLATE application/xml
 AddOutputFilterByType DEFLATE font/opentype
 AddOutputFilterByType DEFLATE font/otf
 AddOutputFilterByType DEFLATE font/ttf
 AddOutputFilterByType DEFLATE image/svg+xml
 AddOutputFilterByType DEFLATE image/x-icon
 AddOutputFilterByType DEFLATE text/css
 AddOutputFilterByType DEFLATE text/html
 AddOutputFilterByType DEFLATE text/javascript
 AddOutputFilterByType DEFLATE text/plain
 AddOutputFilterByType DEFLATE text/xml
</IfModule>
# END DEFLATE COMPRESSION

# BEGIN GZIP COMPRESSION
<IfModule mod_gzip.c>
mod_gzip_on Yes
mod_gzip_dechunk Yes
mod_gzip_item_include file \.(html?|txt|css|js|php|pl)$
mod_gzip_item_include handler ^cgi-script$
mod_gzip_item_include mime ^text/.*
mod_gzip_item_include mime ^application/x-javascript.*
mod_gzip_item_exclude mime ^image/.*
mod_gzip_item_exclude rspheader ^Content-Encoding:.*gzip.*
</IfModule>
# END GZIP COMPRESSION

#BEGIN EXPIRES HEADERS
<IfModule mod_expires.c>
# Enable expirations
ExpiresActive On
# Default expiration: 1 hour after request
ExpiresDefault "now plus 1 hour"
# CSS and JS expiration: 1 week after request
ExpiresByType text/css "now plus 1 week"
ExpiresByType application/javascript "now plus 1 week"
ExpiresByType application/x-javascript "now plus 1 week"
# Image files expiration: 1 month after request
ExpiresByType image/bmp "now plus 1 month"
ExpiresByType image/gif "now plus 1 month"
ExpiresByType image/jpeg "now plus 1 month"
ExpiresByType image/jp2 "now plus 1 month"
ExpiresByType image/pipeg "now plus 1 month"
ExpiresByType image/png "now plus 1 month"
ExpiresByType image/svg+xml "now plus 1 month"
ExpiresByType image/tiff "now plus 1 month"
ExpiresByType image/vnd.microsoft.icon "now plus 1 month"
ExpiresByType image/x-icon "now plus 1 month"
ExpiresByType image/ico "now plus 1 month"
ExpiresByType image/icon "now plus 1 month"
ExpiresByType text/ico "now plus 1 month"
ExpiresByType application/ico "now plus 1 month"
# Webfonts
ExpiresByType font/truetype "access plus 1 month"
ExpiresByType font/opentype "access plus 1 month"
ExpiresByType application/x-font-woff "access plus 1 month"
ExpiresByType image/svg+xml "access plus 1 month"
ExpiresByType application/vnd.ms-fontobject "access plus 1 month"
</IfModule>
#END EXPIRES HEADERS

# BEGIN Cache-Control Headers
<ifModule mod_headers.c>
 <filesMatch "\.(ico|jpe?g|png|gif|swf)$">
 Header set Cache-Control "max-age=2592000, public"
 </filesMatch>
 <filesMatch "\.(css)$">
 Header set Cache-Control "max-age=604800, public"
 </filesMatch>
 <filesMatch "\.(js)$">
 Header set Cache-Control "max-age=216000, private"
 </filesMatch>
 <filesMatch "\.(x?html?|php)$">
 Header set Cache-Control "max-age=600, private, must-revalidate"
 </filesMatch>
</ifModule>
# END Cache-Control Headers

RewriteCond %{HTTP:X-ARR-SSL} ^$
RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]
EOL

echo ".htaccess created" ;

# Add SSL force to wp-config
sed -i '/table_prefix/a define("FORCE_SSL_ADMIN", true); if ( isset($_SERVER["HTTP_X_ARR_SSL\"]) ) $_SERVER["HTTPS"]="on";' wp-config.php

echo "updated wp-config with Azure specific SSL lines" ;

# Flush rewrite rules
wp rewrite flush --allow-root ;

__odi="
   ______      ______                     
  / ____/___ _/ / __ \________  __________
 / /   / __  / / /_/ / ___/ _ \/ ___/ ___/
/ /___/ /_/ / / ____/ /  /  __(__  |__  ) 
\____/\__,_/_/_/   /_/   \___/____/____/
"
echo "$__odi"
echo "Install completed, you can now go to: $5" ;