<?php
$connectstr_dbhost = getenv('DATABASE_HOST');
$connectstr_dbname = getenv('DATABASE_NAME');
$connectstr_dbusername = getenv('DATABASE_USERNAME');
$connectstr_dbpassword = getenv('DATABASE_PASSWORD');

$config_cmd = 'wp config set DB_NAME $connectstr_dbname ;
wp config set DB_USER $connectstr_dbusername ;
wp config set DB_PASSWORD $connectstr_dbpassword ;
wp config set DB_HOST $connectstr_dbhost ;';

echo shell_exec($config_cmd);