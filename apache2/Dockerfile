FROM webdevops/apache:ubuntu-16.04

LABEL maintainer="Eric Pfeiffer <computerfr33k@users.noreply.github.com>"

# RUN apt-get install -y libapache2-mod-fastcgi

# Configure Apache to use our PHP-FPM socket for all PHP files
# COPY php7.0-fpm.conf /etc/apache2/conf-available/php7.0-fpm.conf
# COPY php7.2-fpm.conf /etc/apache2/conf-available/php7.2-fpm.conf

# COPY php70-fcgi /usr/lib/cgi-bin/php70-fcgi
# COPY php72-fcgi /usr/lib/cgi-bin/php72-fcgi

# RUN chmod 755 /usr/lib/cgi-bin/php70-fcgi
# RUN chmod 755 /usr/lib/cgi-bin/php72-fcgi

# Enable Apache modules and configuration
# RUN a2enconf php7.0-fpm

ARG PHP_UPSTREAM_CONTAINER=php-fpm
ARG PHP_UPSTREAM_PORT=9000
ARG PHP_UPSTREAM_TIMEOUT=60
ARG DOCUMENT_ROOT=/var/www/

ENV WEB_PHP_SOCKET=${PHP_UPSTREAM_CONTAINER}:${PHP_UPSTREAM_PORT}

ENV WEB_DOCUMENT_ROOT=${DOCUMENT_ROOT}

ENV WEB_PHP_TIMEOUT=${PHP_UPSTREAM_TIMEOUT}

EXPOSE 80 443

WORKDIR /var/www/

COPY vhost.conf /etc/apache2/sites-enabled/vhost.conf

ENTRYPOINT ["/opt/docker/bin/entrypoint.sh"]

CMD ["supervisord"]
