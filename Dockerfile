FROM php:8.4-fpm-alpine AS builder

RUN echo http://mirror.yandex.ru/mirrors/alpine/latest-stable/main > /etc/apk/repositories; \
    echo http://mirror.yandex.ru/mirrors/alpine/latest-stable/community >> /etc/apk/repositories && \
    apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache \
     g++ \
     gcc \
     curl \
     icu-dev \
     sqlite-libs \
     sqlite-dev \
     autoconf \
     make \
     pkgconf && \
    curl https://getcomposer.org/installer -o /tmp/composer-installer && \
    php /tmp/composer-installer --install-dir=/usr/local/bin --filename=composer

FROM php:8.4-fpm-alpine AS final

WORKDIR /var/www/app

ENV COMPOSER_ALLOW_SUPERUSER=1

COPY --from=builder /usr/local/bin/composer /usr/local/bin/composer
COPY ./symfony-app .

RUN composer install --optimize-autoloader && \
    chown -R www-data:www-data /var/www/app
