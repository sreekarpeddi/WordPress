#!/bin/bash
set -e


/usr/local/bin/devops/create-apache-singlesite.sh

exec "$@"
