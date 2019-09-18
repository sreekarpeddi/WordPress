FROM appsvc/php:7.3-apache_1908260522
MAINTAINER ODI DevOps  "devops@state.ca.gov"

COPY wp-cli.phar /usr/local/bin/wp

COPY bash-scripts /usr/local/bin/devops/
COPY htaccesssubdomain /usr/local/bin/devops/
COPY htaccesssubfolder /usr/local/bin/devops/
COPY docker-entrypoint.sh /usr/local/bin/devops/
RUN chmod -R 755 /usr/local/bin/devops/

#RUN apt-get update
RUN apt-get install -y mysql-client 
#CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
EXPOSE 2222 8080 80

#RUN ln -s /usr/local/bin/devops/docker-entrypoint.sh /
ENTRYPOINT [ "/usr/local/bin/devops/docker-entrypoint.sh" ]
CMD apachectl -D FOREGROUND

