FROM centos:latest
RUN yum -y update
WORKDIR /etc/yum.repos.d/
RUN  yum -y install wget
RUN wget http://download.opensuse.org/repositories/security://shibboleth/CentOS_7/security:shibboleth.repo
RUN yum -y install shibboleth.x86_64
RUN yum -y install mod_ssl
COPY 00_aerogear.conf /etc/httpd/conf.d/00_aerogear.conf
RUN apachectl -k restart
EXPOSE 80
EXPOSE 443
EXEC /sbin/shibd -F
