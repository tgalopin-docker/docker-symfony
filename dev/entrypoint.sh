#!/usr/bin/env bash

chmod -R 775 /var/www/var/cache/*
chmod -R 775 /var/www/var/logs/*
chmod -R 775 /var/www/var/sessions/*

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
