FROM debian:stretch

RUN apt update && apt upgrade -y

RUN apt install -y \
    apt-transport-https \
    lsb-release \
    ca-certificates \
    wget \
    curl \
    apache2 \
    --no-install-recommends

# Add ondrej sources for old php packages
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

# PHP & Extensions
RUN DEBIAN_FRONTEND=noninteractive apt update && apt upgrade -y && apt install -y \
    php5.6 \
    php5.6-bcmath \
    php5.6-curl \
    php5.6-gd \
    php5.6-mcrypt \
    php5.6-mbstring \
    php5.6-mysql \
    php5.6-sqlite3 \
    php5.6-soap \
    php5.6-xml \
    php5.6-zip \
    php5.6-xdebug

# PHP files should be handled by PHP, and should be preferred over any other file type
ENV APACHE_CONFDIR /etc/apache2
RUN { \
        echo '<FilesMatch \.php$>'; \
        echo '\tSetHandler application/x-httpd-php'; \
        echo '</FilesMatch>'; \
        echo; \
        echo 'DirectoryIndex index.php index.html'; \
        echo; \
        echo '<Directory /var/www/>'; \
        echo '\tOptions +Indexes'; \
        echo '\tAllowOverride All'; \
        echo '</Directory>'; \
    } | tee "$APACHE_CONFDIR/conf-available/docker-php.conf" \
    && a2enconf docker-php && a2enmod rewrite

STOPSIGNAL WINCH
WORKDIR /var/www/html

EXPOSE 80
CMD apachectl -D FOREGROUND
