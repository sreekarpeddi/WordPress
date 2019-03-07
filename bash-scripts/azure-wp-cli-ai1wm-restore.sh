#!/bin/bash

# move to ai1wm folder /wp-content/ai1wm-backups/
# find the most recent .wpress file and put it into a variable
# restore site from that variable


#cd /home/site/wwwroot/wp-content/ai1wm-backups ;

cd wp-content/ai1wm-backups ;

BACKUP= ls -t *.wpress | head -1 ;

#echo $BACKUP ;

wp ai1wm restore $BACKUP --yes --allow-root ;

__odi="
   __________  ______   ____  ____  ____   _       __               ______                     
  / ____/ __ \/_  __/  / __ \/ __ \/  _/  | |     / /___  _________/ / __ \________  __________
 / /   / / / / / /    / / / / / / // /    | | /| / / __ \/ ___/ __  / /_/ / ___/ _ \/ ___/ ___/
/ /___/ /_/ / / /    / /_/ / /_/ // /     | |/ |/ / /_/ / /  / /_/ / ____/ /  /  __(__  |__  ) 
\____/_____/ /_/     \____/_____/___/     |__/|__/\____/_/   \__,_/_/   /_/   \___/____/____/  
                                                                                               
"
echo "$__odi"