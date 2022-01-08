FROM php:8.1.0-alpine3.15

ENV ARTISAN_OPTIMIZE 0

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions \
    && sync

RUN install-php-extensions bcmath curl mcrypt pdo_mysql redis sqlite3 zip

COPY php.ini /usr/local/etc/php/conf.d/99-custom.ini

RUN apk --no-cache add bash curl

WORKDIR /var/www/html

COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["sh", "/usr/local/bin/docker-entrypoint.sh"]

EXPOSE 8080

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8080"]