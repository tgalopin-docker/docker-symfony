FROM alpine:latest

ENV LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    TERM="xterm"

COPY run.sh /usr/local/bin/run.sh

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories && \
    echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk --update add \
        curl \
        git \
        nginx \
        php7 \
        php7-amqp \
        php7-curl \
        php7-ctype \
        php7-dom \
        php7-fpm \
        php7-gd \
        php7-iconv \
        php7-intl \
        php7-json \
        php7-mbstring \
        php7-mcrypt \
        php7-mysql \
        php7-opcache \
        php7-openssl \
        php7-pdo \
        php7-pdo_pgsql \
        php7-phar \
        php7-session \
        php7-xml \
        php7-zip \
        tzdata \
        nodejs \
    && rm -rf /var/cache/apk/* \
    && ln -s /usr/bin/php7 /usr/bin/php \
    && ln -s /usr/sbin/php-fpm7 /usr/bin/php-fpm \
    && npm install -g yarn \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer \
    && composer global require phpunit/phpunit \
    && composer global require symfony/framework-standard-edition \
    && ln -s /root/.composer/vendor/bin/phpunit /usr/local/bin/phpunit \
    && mkdir /app \
    && mkdir /app/web \
    && echo "<?php phpinfo();" > /app/web/app.php \
    && chmod a+x /usr/local/bin/run.sh

RUN cp /usr/share/zoneinfo/Europe/Paris /etc/localtime && echo "Europe/Paris" > /etc/timezone

COPY php.ini /etc/php7/conf.d/50-setting.ini
COPY www.conf /etc/php7/php-fpm.d/www.conf
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
WORKDIR /app

CMD ["/usr/local/bin/run.sh"]
