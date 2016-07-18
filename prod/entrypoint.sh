#!/usr/bin/env bash

cd /var/www
chown -R www-data:www-data /var/www
chmod -R 775 /var/www

if [[  $* == "bash" ]]
then
    bash
else
    if [[ $* == "test" ]]
    then
        /var/www/vendor/bin/phpunit
    else
        /usr/bin/supervisord
    fi
fi
