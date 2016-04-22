FROM php:7.0-fpm

# Install packages
RUN apt-get update && apt-get install -my \
    curl \
    wget \
    zip

# Install curl
RUN apt-get install -y \
        libcurl4-openssl-dev \
    && docker-php-ext-install -j$(nproc) curl

# Install mcrypc
RUN apt-get install -y \
        libmcrypt-dev \
    && docker-php-ext-install -j$(nproc) mcrypt

# Install intl
RUN apt-get install -y \
        libicu-dev \
    && docker-php-ext-install -j$(nproc) intl

# Install gd
RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# Install imagick
RUN apt-get install -y \
        libmagickwand-dev \
        imagemagick \
    && pecl install imagick \
    && docker-php-ext-enable imagick

# Install memcached
RUN apt-get install -y \
        libmemcached-dev \
        zlib1g-dev \
        libncurses5-dev \
    && cd /usr/src/php/ext \
    && wget -q https://github.com/php-memcached-dev/php-memcached/archive/php7.zip \
    && unzip php7.zip \
    && rm php7.zip \
    && docker-php-ext-install php-memcached-php7

# Install redis
RUN cd /usr/src/php/ext \
    &&wget -q https://github.com/phpredis/phpredis/archive/php7.zip \
    && unzip php7.zip \
    && rm php7.zip \
    && docker-php-ext-install phpredis-php7

# Install PDO
RUN docker-php-ext-install pdo_mysql mysqli

WORKDIR /var/www

RUN usermod -u 1000 www-data