FROM php:7.1-apache
RUN apt-get update -y -q \
&&  apt-get dist-upgrade -y -q \
&&  apt-get install -y -q --no-install-recommends \
                       libfreetype6-dev \
                       libjpeg62-turbo-dev \
                       libpng-dev

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd

RUN a2enmod remoteip \
&&  touch /etc/apache2/conf-available/remoteip.conf \
&&  a2enconf remoteip

RUN apt-get clean \
&&  apt-get -y autoremove --purge \
&&  rm -rf /var/lib/apt/lists/*
