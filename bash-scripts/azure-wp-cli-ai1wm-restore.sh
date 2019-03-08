#!/bin/bash

# move to ai1wm folder /wp-content/ai1wm-backups/
cd /home/site/wwwroot/wp-content/ai1wm-backups ;

# find the most recent .wpress file and put it into a variable
BACKUP=$(ls -t *.wpress | head -1) ;

# restore site from that variable
wp ai1wm restore $BACKUP --yes --allow-root ;

__odi="
  ________  ______  ___           ____         
 / ___/ _ \/_  __/ / _ \___ _  __/ __ \___  ___
/ /__/ // / / /   / // / -_) |/ / /_/ / _ \(_-<
\___/____/ /_/   /____/\__/|___/\____/ .__/___/
                                    /_/                                                                      
"
echo "$__odi"