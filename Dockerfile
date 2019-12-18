FRON appsvc/php:7.3-apache_20191031.7

MAINTAINER ODI DevOps  "devops@state.ca.gov"
 
COPY wp-cli.phar /usr/local/bin/wp

ADD https://github.com/CA-CODE-Works/wordpress-azure.git /home/site/wwwroot/

COPY bash-scripts /usr/local/bin/devops/
COPY htaccesssubdomain /usr/local/bin/devops/
COPY htaccesssubfolder /usr/local/bin/devops/
COPY docker-entrypoint.sh /usr/local/bin/devops/
RUN chmod -R 755 /usr/local/bin/devops/ 
#RUN apt-get update mysql-client
RUN apt-get install -y \
    mysql-client
EXPOSE 2222 8080 80
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
#CMD [ "/usr/local/bin/devops/create-apache-singlesite.sh" ]
CMD [ "/usr/local/bin/devops/docker-entrypoint.sh", "single" ]
#ENTRYPOINT ["bash", "/usr/local/bin/devops/docker-entrypoint.sh"  ]
