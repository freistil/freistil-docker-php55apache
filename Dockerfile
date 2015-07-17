FROM freistil/php55
MAINTAINER Jochen Lillich <jochen@freistil.it>

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get -y install \
    apache2 \
    libapache2-mod-php5 \
  && apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Container initialisation
ADD docker/ /docker/

# Apache
ADD apache/default_vhost.conf /etc/apache2/sites-available/000-default.conf
ADD apache/index.php /var/www/html/index.php
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN a2enmod rewrite

# Expose HTTP port
EXPOSE 80
