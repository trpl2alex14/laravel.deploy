FROM php:8.1-fpm

USER root
# Install dependencies
RUN apt-get update && apt-get install -y \
    libonig-dev \
    build-essential \
    libzip-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libwebp-dev libjpeg62-turbo-dev libpng-dev libxpm-dev \
    libfreetype6 \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    exif \
    vim \
    unzip \
    git \
    curl
# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
# Install extensions
RUN docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl
#RUN docker-php-ext-install pdo mbstring zip exif pcntl

RUN apt-get update && apt-get install -y \
    imagemagick libmagickwand-dev --no-install-recommends \
    && (pecl install imagick) || true \
    && docker-php-ext-enable imagick \
    && (php -m | grep -q 'imagick')

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY ./laravel.ini /usr/local/etc/php/conf.d
COPY ./scripts /var/www/scripts

RUN chmod +x /var/www/scripts/*

# Configure non-root user.
ARG PUID=1000
ENV PUID=${PUID}
ARG PGID=1000
ENV PGID=${PGID}

RUN groupmod -o -g ${PGID} www-data && \
    usermod -o -u ${PUID} -g www-data www-data

# Set working directory
WORKDIR /var/www

# Expose port 9000 and start php-fpm server
EXPOSE 9000

CMD ["php-fpm"]