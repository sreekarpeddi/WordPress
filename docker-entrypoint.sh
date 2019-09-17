#!/bin/bash
set -e


/usr/local/bin/devops/azure-wp-cli-create-singlesite.sh

exec "$@"
