#!/bin/bash
set -e

echo " NOW STARTING THE SINGE SITE CONFIGURATION" 

	if [ "$1" = 'single' ]; then
        
         rm -rf /home/site/wwroot/* 
	  /usr/local/bin/devops/create-apache-singlesite.sh

	fi

exec "$@"
