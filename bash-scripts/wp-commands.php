<?php
$connectstr_dbhost = getenv('DATABASE_HOST');
$connectstr_dbname = getenv('DATABASE_NAME');
$connectstr_dbusername = getenv('DATABASE_USERNAME');
$connectstr_dbpassword = getenv('DATABASE_PASSWORD');

$config_cmd = 'wp config set DB_NAME' . $connectstr_dbname . '--allow-root ;'

echo 'starting wp-config update';
echo '<pre>' . shell_exec($config_cmd) . '</pre>';
echo 'wp-config updated';