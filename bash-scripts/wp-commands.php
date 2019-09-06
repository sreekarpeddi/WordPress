<?php
$connectstr_dbhost = getenv('DATABASE_HOST');
$connectstr_dbname = getenv('DATABASE_NAME');
$connectstr_dbusername = getenv('DATABASE_USERNAME');
$connectstr_dbpassword = getenv('DATABASE_PASSWORD');

$admin_user = getenv('ADMIN_USER');
$admin_password = getenv('ADMIN_PASSWORD');
$admin_email = getenv('ADMIN_EMAIL');

$site_url = getenv('SITE_URL');

// create wp-config

echo shell_exec("wp config create --dbname='$connectstr_dbname' --dbuser='$connectstr_dbusername' --dbpass='$connectstr_dbpassword' --dbhost='$connectstr_dbhost' --allow-root ;");

// install WP 

echo shell_exec("wp core install --title='$site_url' --url='$site_url' --admin_user='$admin_user' --admin_password='$admin_password' --admin_email='$admin_email' --allow-root ;");

// install theme

echo shell_exec("wp theme install https://github.com/timloden/CAWeb-Standard/archive/master.zip --activate --allow-root ;");

// Install Updraft Plus, 2FA, SEO Framework, WP-Optimize and ReSmush.it

echo shell_exec("wp plugin install updraftplus two-factor autodescription wp-optimize resmushit-image-optimizer wp-mail-smtp --activate --allow-root ;");

// Update plugins just in case

echo shell_exec("wp plugin update --all --allow-root ;");