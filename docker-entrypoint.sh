#!/bin/bash
set -e

echo " NOW STARTING THE SINGE SITE CONFIGURATION" 

/usr/local/bin/devops/create-apache-singlesite.sh

exec "$@"
