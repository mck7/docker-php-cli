FROM php:7.3-cli
MAINTAINER corycollier@corycollier.com

# Do all of the global system package installations
RUN apt -y update \
    && apt -y upgrade \
    && apt -y install \
        libpng-dev \
        libgmp-dev \
        zlib1g-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libxslt-dev \
        libjpeg-dev \
        libcurl4 \
        libzip-dev \
        less \
        vim \
        curl \
        git \
        ca-certificates \
        sqlite3 \
        libsqlite3-dev \
        less

# Add all of the php specific packages
RUN docker-php-source extract \
    && docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --enable-gd-jis-conv \
    && docker-php-ext-install \
        gmp \
        bcmath \
        exif \
        gd \
        mysqli \
        pcntl \
        pdo \
        pdo_mysql \
        pdo_sqlite \
        xsl \
        zip

# Install modules not able to be installed any other way
RUN pecl install xdebug

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

# Configure composer
RUN export COMPOSER_ALLOW_SUPERUSER=1 \
  && composer global init \
  && composer global require hirak/prestissimo

RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN curl -sfL git.io/antibody | sh -s - -b /usr/local/bin
ADD dotfiles/* /root/

ENV TERM xterm-256color
ENV POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD true
