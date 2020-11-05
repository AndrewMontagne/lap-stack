FROM debian:stable-slim
RUN apt-get update
RUN (DEBIAN_FRONTEND=noninteractive apt-get install -y curl wget git unzip nano)
RUN (DEBIAN_FRONTEND=noninteractive apt-get install -y php)
RUN (DEBIAN_FRONTEND=noninteractive apt-get install -y php-mbstring php-zip php-xml php-gd php-curl php-redis php-soap)
RUN (DEBIAN_FRONTEND=noninteractive apt-get install -y apache2) && a2enmod vhost_alias
RUN (DEBIAN_FRONTEND=noninteractive apt-get install -y redis)
COPY ./bootstrap.sh /bootstrap.sh
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
ENTRYPOINT /bootstrap.sh

