FROM php:8.1.6-fpm-alpine3.15

LABEL maintainer="Hannes Daus (hannes@daus.family)"

ARG BUILD_COMMIT

ENV ARTISAN_OPTIMIZE="0" \
    PHP_OPCACHE_VALIDATE_TIMESTAMPS="0" \
    PHP_OPCACHE_MAX_ACCELERATED_FILES="10000" \
    PHP_OPCACHE_MEMORY_CONSUMPTION="192" \
    PHP_OPCACHE_MAX_WASTED_PERCENTAGE="10"

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions \
    && sync

RUN install-php-extensions bcmath gd mcrypt opcache pcntl pdo_mysql redis zip

RUN apk --no-cache add bash curl supervisor nginx

WORKDIR /var/www/html

RUN echo "${BUILD_COMMIT}" > BUILD_COMMIT

COPY php/php.ini /usr/local/etc/php/conf.d/z-custom.ini
COPY php/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/vhost.conf /etc/nginx/conf.d/default.conf
COPY supervisord.conf /etc/supervisord.conf
COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT [ "sh", "/usr/local/bin/docker-entrypoint.sh" ]

CMD [ "supervisord", "-n", "-c", "/etc/supervisord.conf" ]



