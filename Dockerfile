FROM ubuntu:latest

RUN apt-get update\

        && ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime\

        && apt-get install -y tzdata\

        && dpkg-reconfigure --frontend noninteractive tzdata \

        && apt-get install -y nginx\

        && apt-get install -y systemctl php8.1 php8.1-fpm supervisor

RUN mkdir -p /var/run/php/
RUN mkdir /var/www/website
RUN echo "<?php phpinfo(); ?>" >> /var/www/website/index.php
COPY ./config/default /etc/nginx/sites-available/default
#COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#CMD ["/usr/bin/supervisord"] 

ENTRYPOINT ["systemctl"] CMD ['start','nginx'] CMD ['start','php8.1-fpm'] CMD ['status','php8.1-fpm']
