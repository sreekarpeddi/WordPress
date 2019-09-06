FROM appsvc/php:7.2.11-apache_1810291954
MAINTAINER ODI DevOps  "devops@state.ca.gov"

COPY wp-cli.phar /usr/local/bin/wp

COPY bash-scripts /usr/local/bin/devops/
COPY htaccesssubdomain /usr/local/bin/devops/
COPY htaccesssubfolder /usr/local/bin/devops/

#RUN apt-get install -y \
#    mysql-client 


EXPOSE 2222 8080 80

CMD ["eval $(printenv | awk -F= '{print "export " "\""$1"\"""=""\""$2"\"" }' >> /etc/profile)"]

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]

#ENTRYPOINT ["entrypoint.sh"]



