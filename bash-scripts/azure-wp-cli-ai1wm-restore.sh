#!/bin/bash

# move to ai1wm folder /wp-content/ai1wm-backups/
cd /home/site/wwwroot/wp-content/ai1wm-backups ;

# find the most recent .wpress file and put it into a variable
BACKUP=$(ls -t *.wpress | head -1) ;

# restore site from that variable
wp ai1wm restore $BACKUP --yes --allow-root ;

__odi="
   ______      ______                     
  / ____/___ _/ / __ \________  __________
 / /   / __  / / /_/ / ___/ _ \/ ___/ ___/
/ /___/ /_/ / / ____/ /  /  __(__  |__  ) 
\____/\__,_/_/_/   /_/   \___/____/____/                                                             
"
echo "$__odi"