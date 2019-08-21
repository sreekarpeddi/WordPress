<?php
$connectstr_dbhost = getenv('DATABASE_HOST');
$connectstr_dbname = getenv('DATABASE_NAME');
$connectstr_dbusername = getenv('DATABASE_USERNAME');
$connectstr_dbpassword = getenv('DATABASE_PASSWORD');

$connectstr_dbname = escapeshellarg($connectstr_dbname);

//$config_cmd = 'wp config set DB_NAME' . $connectstr_dbname . '--allow-root ;'

echo 'starting wp-config update';
echo 'dbname: ' . $connectstr_dbname;
echo '<pre>' . shell_exec("wp config set DB_NAME $connectstr_dbname --allow-root ;") . '</pre>';
echo 'wp-config updated';