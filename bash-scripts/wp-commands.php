<?php

// get db settings
$connectstr_dbhost = getenv('DATABASE_HOST');
$connectstr_dbname = getenv('DATABASE_NAME');
$connectstr_dbusername = getenv('DATABASE_USERNAME');
$connectstr_dbpassword = getenv('DATABASE_PASSWORD');

// get wp user 
$admin_user = getenv('ADMIN_USER');
$admin_password = getenv('ADMIN_PASSWORD');
$admin_email = getenv('ADMIN_EMAIL');

//get redis settings
$redis_port = getenv('WP_REDIS_PORT');
$redis_host = getenv('WP_REDIS_HOST');
$redis_password = getenv('WP_REDIS_PASSWORD');

// get site url
$site_url = getenv('SITE_URL');

// divi theme token
$divi_token = getenv('DIVI_TOKEN');

// create wp-config

echo shell_exec("wp config create --dbname='$connectstr_dbname' --dbuser='$connectstr_dbusername' --dbpass='$connectstr_dbpassword' --dbhost='$connectstr_dbhost' --allow-root ;");

// install WP 

echo shell_exec("wp core install --title='$site_url' --url='$site_url' --admin_user='$admin_user' --admin_password='$admin_password' --admin_email='$admin_email' --allow-root ;");

// install divi and caweb themes
echo shell_exec("wp theme install https://api.github.com/repos/Danny-Guzman/Divi/zipball/master?token=$divi_token --allow-root ;");
echo shell_exec("wp theme install https://github.com/CA-CODE-Works/CAWeb/archive/master.zip --activate --allow-root ;");

// Install Updraft Plus, 2FA, SEO Framework, WP-Optimize and ReSmush.it

echo shell_exec("wp plugin install updraftplus two-factor autodescription wp-optimize resmushit-image-optimizer wp-mail-smtp --activate --allow-root ;");

if ($redis_host ) {
    // get the redis plugin
    echo shell_exec("wp plugin install redis-cache --activate --allow-root ;");
    // set redis variables in wp-config
    echo shell_exec("wp config set WP_REDIS_PORT '$redis_port' --allow-root ;");
    echo shell_exec("wp config set WP_REDIS_HOST '$redis_host' --allow-root ;");
    echo shell_exec("wp config set WP_REDIS_PASSWORD '$redis_password' --allow-root ;");
    echo shell_exec("wp config set WP_REDIS_SELECTIVE_FLUSH true --raw --allow-root ;");
}

// Update plugins just in case

echo shell_exec("wp plugin update --all --allow-root ;");