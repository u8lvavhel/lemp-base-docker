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
RUN apt-get update && apt-get install -y \
        libmcrypt-dev \
    && docker-php-ext-install -j$(nproc) mcrypt

# Install intl
RUN apt-get update && apt-get install -y \
        libicu-dev \
    && docker-php-ext-install -j$(nproc) intl

# Install gd
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# Install memcached
RUN apt-get install -y libmemcached-dev zlib1g-dev libncurses5-dev
RUN mkdir /usr/src/php/ext/memcached-2.2.0
RUN cd /usr/src/php/ext &&  wget -q https://github.com/php-memcached-dev/php-memcached/archive/php7.zip && unzip php7.zip && rm php7.zip
RUN docker-php-ext-install php-memcached-php7

# Install PDO
RUN docker-php-ext-install pdo_mysql

# # Install mongo
# RUN apt-get update && apt-get install -y \
#         libssl-dev \
#     && pecl install mongo \
#     && docker-php-ext-enable mongo

# #Install tools and custom php
# RUN apt-get update && apt-get install -my \
# 	wget

# #Install adminer with pretty theme
# RUN mkdir /var/www/adminer
# RUN wget http://www.adminer.org/latest.php -O /var/www/adminer/index.php
# RUN wget https://raw.githubusercontent.com/vrana/adminer/master/designs/pappu687/adminer.css -O /var/www/adminer.css

WORKDIR /var/www

RUN usermod -u 1000 www-data