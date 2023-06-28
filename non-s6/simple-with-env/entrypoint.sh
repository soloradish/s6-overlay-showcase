#!/bin/sh
set -a # automatically export all variables
source /env/.env
set +a

exec "$@"
