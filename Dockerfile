FROM debian:stable-slim
RUN apt-get update
RUN (DEBIAN_FRONTEND=noninteractive apt-get install -y curl wget git unzip nano)
RUN (DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https lsb-release ca-certificates curl)
RUN curl -sSL -o /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
RUN apt-get update
RUN (DEBIAN_FRONTEND=noninteractive apt-get install -y php8.0)
RUN (DEBIAN_FRONTEND=noninteractive apt-get install -y php8.0-mbstring php8.0-zip php8.0-xml php8.0-gd php8.0-curl php8.0-soap)
RUN (DEBIAN_FRONTEND=noninteractive apt-get install -y php8.0-dev php-pear)
RUN yes 'no' | pecl install apcu
COPY apcu.ini /etc/php/8.0/mods-available/apcu.ini
RUN cd /etc/php/8.0/cli/conf.d && ln -s /etc/php/8.0/mods-available/apcu.ini 20-apcu.ini
RUN cd /etc/php/8.0/apache2/conf.d && ln -s /etc/php/8.0/mods-available/apcu.ini 20-apcu.ini
RUN (DEBIAN_FRONTEND=noninteractive apt-get install -y apache2) && a2enmod vhost_alias
RUN (DEBIAN_FRONTEND=noninteractive apt-get install -y redis)
COPY ./bootstrap.sh /bootstrap.sh
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
ENTRYPOINT /bootstrap.sh

