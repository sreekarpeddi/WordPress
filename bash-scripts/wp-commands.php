<?php
$output = shell_exec("wp --info");
echo "<pre>".$output."</pre>";