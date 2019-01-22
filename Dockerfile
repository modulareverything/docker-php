FROM php:7-apache

MAINTAINER Chrish Dunne "hey@chrish.design"

# Install OS components
RUN apt-get update -y && apt-get install -y libpng-dev curl libcurl4-openssl-dev libmcrypt-dev libmagickwand-dev libzip-dev

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql mysqli gd curl fileinfo zip
RUN pecl install imagick mcrypt && docker-php-ext-enable imagick

# Clean Up
RUN rm -rf /var/lib/apt/lists/*

# Configure
COPY config/php.ini /usr/local/etc/php/

# Install Apache modules and restart Apache
RUN a2enmod rewrite
RUN service apache2 restart
