#!/bin/bash

#Go to web root

echo "Going to site root" ;
cd /home/site/wwwroot/ ;

#Copy wp-commands.php
echo "copying wp-commands.php..."
cp /usr/local/bin/devops/wp-commands.php /home/site/wwwroot/wp-commands.php ;
echo "copied wp-commands.php"

#Run wp-commands.php

content=$(wget $1/wp-commands.php -q -O -) ;
echo $content ;

#Remove wp-commands file

echo "deleting wp-commands.php..."
rm /home/site/wwwroot/wp-commands.php ;
echo "deleted wp-commands.php"

__odi="
   ______      ______                     
  / ____/___ _/ / __ \________  __________
 / /   / __  / / /_/ / ___/ _ \/ ___/ ___/
/ /___/ /_/ / / ____/ /  /  __(__  |__  ) 
\____/\__,_/_/_/   /_/   \___/____/____/
"
echo "$__odi"
echo "Install completed, you can now go to: $1" ;