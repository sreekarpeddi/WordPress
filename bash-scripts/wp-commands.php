<?php
$connectstr_dbhost = getenv('DATABASE_HOST');
$connectstr_dbname = getenv('DATABASE_NAME');
$connectstr_dbusername = getenv('DATABASE_USERNAME');
$connectstr_dbpassword = getenv('DATABASE_PASSWORD');

//$config_cmd = 'wp config set DB_NAME' . $connectstr_dbname . '--allow-root ;'

echo shell_exec("wp config set DB_NAME '$connectstr_dbname' --allow-root ;");
echo shell_exec("wp config set DB_HOST '$connectstr_dbhost' --allow-root ;");
echo shell_exec("wp config set DB_USER '$connectstr_dbusername' --allow-root ;");
echo shell_exec("wp config set DB_PASSWORD '$connectstr_dbpassword' --allow-root ;");