FROM appsvcorg/wordpress-alpine-php:0.72
MAINTAINER ODI DevOps  "devops@state.ca.gov"

COPY wp-cli.phar /usr/local/bin/wp

COPY bash-scripts /usr/local/bin/devops/


#RUN apt-get install -y \
#    mysql-client


EXPOSE 2222 8080 80
