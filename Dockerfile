FROM php:5.6-apache

MAINTAINER "Jan Zaeske" <mail@jzaeske.de>

RUN buildDeps=" \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
        libxml2-dev \
        libssl-dev \
        libcurl3-dev \
        libldap2-dev \
        libicu-dev \
        libmcrypt-dev \
        libz-dev \
      " \
      && apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
      && docker-php-ext-configure intl \
      && docker-php-ext-configure ldap --with-libdir=/lib/x86_64-linux-gnu/ \
      && docker-php-ext-install \
        bcmath \
        curl \
        dom \
        intl \
        gd \
        mbstring \
        mcrypt \
        mysqli \
        pdo \
        pdo_mysql \
        phar \
        ldap \
        soap \
        zip \
      && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommaendsImportant=false -o APT::AutoRemove::SuggestsImportant=false $buildDeps

COPY config/php.ini /usr/local/etc/php/

RUN a2enmod authz_core \
  && a2enmod headers \
  && a2enmod mime \
  && a2enmod deflate \
  && a2enmod filter \
  && a2enmod expires \
  && a2enmod rewrite
