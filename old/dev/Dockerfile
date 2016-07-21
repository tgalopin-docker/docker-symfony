FROM php:7-fpm

ADD entrypoint.sh /usr/local/bin/entrypoint

RUN echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" > /etc/apt/sources.list.d/nginx.list && \
    curl http://nginx.org/keys/nginx_signing.key | apt-key add - && \
    apt-get update && \
    apt-get install -y \
        # Root packages
        ca-certificates \
        curl \
        tar \
        openssh-client \

        # For PHP extensions
        libssl-dev \
        libicu-dev \
        libzip-dev \
        libmcrypt-dev \
        libpq-dev \

        # For the app
        supervisor \
        nginx && \

    # Clean
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \

    # PHP extensions
    docker-php-ext-install -j$(nproc) intl zip mcrypt pdo_pgsql && \
    yes | pecl install xdebug && \
    echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini && \

    # nginx and PHP-FPM configuration
    sed -e 's/;daemonize = yes/daemonize = no/' -i /usr/local/etc/php-fpm.conf \
    && sed -e 's/;listen\.owner/listen.owner/' -i /usr/local/etc/php-fpm.d/www.conf \
    && sed -e 's/;listen\.owner/listen.owner/' -i /usr/local/etc/php-fpm.d/www.conf \
    && sed -e 's/;listen\.group/listen.group/' -i /usr/local/etc/php-fpm.d/www.conf \
    && sed -e 's/listen = 127\.0\.0\.1:9000/listen = unix:\/run\/php\/php7.0-fpm.sock/' -i /usr/local/etc/php-fpm.d/www.conf \
    && echo "\ndate.timezone=Europe/Paris" >> /usr/local/etc/php/conf.d/docker-php-timezone.ini \
    && echo "\ndaemon off;" >> /etc/nginx/nginx.conf \
    && usermod -u 1000 www-data \
    && curl https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && usermod -u 1000 www-data \
    && chmod a+x /usr/local/bin/entrypoint

ADD supervisor.conf /etc/supervisor/conf.d/supervisor.conf
ADD nginx.conf /etc/nginx/nginx.conf

WORKDIR /var/www
EXPOSE 80
ENTRYPOINT ["/usr/local/bin/entrypoint"]
