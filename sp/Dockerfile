FROM centos:latest

ENV HOST_IP=172.17.42.1

RUN yum -y update

WORKDIR /etc/yum.repos.d/
RUN  yum -y install wget
RUN wget http://download.opensuse.org/repositories/security://shibboleth/CentOS_7/security:shibboleth.repo
RUN yum -y install shibboleth.x86_64
RUN yum -y install mod_ssl

RUN mkdir /etc/httpd/certs/
ADD certs/certificate.sh /etc/httpd/certs/
WORKDIR /etc/httpd/certs
RUN ./certificate.sh

COPY 00_aerogear.conf /etc/httpd/conf.d/00_aerogear.conf

EXPOSE 80
EXPOSE 443

COPY shibboleth/shibboleth2.xml /etc/shibboleth/shibboleth2.xml

WORKDIR /opt
COPY startup.sh /opt/startup.sh
ENTRYPOINT ["/opt/startup.sh"]
