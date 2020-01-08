FROM appsvc/php:7.3-apache_20200101.1
MAINTAINER ODI DevOps  "devops@state.ca.gov"
 
COPY wp-cli.phar /usr/local/bin/wp

ADD https://github.com/CA-CODE-Works/wordpress-azure/archive/4.0.1.zip /usr/local/bin/devops/ 
RUN cd /usr/local/bin/devops/ && apt-get install -y unzip && unzip 4.0.1.zip -d ./ && rm -rf 4.0.1.zip && ls -la
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


