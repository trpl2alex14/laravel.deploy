#!/bin/sh
set -e

echo "Deploying application ..."

# Enter maintenance mode
(php artisan down) || true

  composer install --optimize-autoloader --no-dev

  composer dump-autoload

  php artisan key:generate

  php artisan config:cache

  php artisan route:cache

  (php artisan route:update) || true

  php artisan view:cache

  php artisan migrate

  #artisan storage:link

  #artisan db:seed

# Exit maintenance mode
php artisan up

echo "Application deployed!"