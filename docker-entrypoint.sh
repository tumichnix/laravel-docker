#!/bin/sh
set -e

if [[ "${ARTISAN_OPTIMIZE:-0}" = "1" ]]; then
  php artisan optimize:clear
  php artisan optimize
  php artisan event:cache
  php artisan view:cache
fi

exec "$@"