FROM centos/wildfly:latest

ENV SHIBBOLETH_VERSION=3.1.2
ENV SHIBBOLETH_DIRECTORY=shibboleth-identity-provider
ENV SHIBBOLETH_ARCHIVE=$SHIBBOLETH_DIRECTORY-$SHIBBOLETH_VERSION.tar.gz
ENV SHIBBOLETH_URL=http://shibboleth.net/downloads/identity-provider/latest/$SHIBBOLETH_ARCHIVE
ENV JAVA_HOME=/usr/lib/jvm/java/

#Prepare System
USER root
RUN yum -y update
RUN yum -y install wget
RUN yum -y install java-1.8.0-*
RUN yum -y remove java-1.7.0-*

#INSTALL Shibboleth
WORKDIR /opt
RUN wget $SHIBBOLETH_URL 

RUN tar -zxvf $SHIBBOLETH_ARCHIVE
RUN mkdir  $SHIBBOLETH_DIRECTORY
RUN rm $SHIBBOLETH_ARCHIVE

COPY feedhenry.idp.properties /opt/$SHIBBOLETH_DIRECTORY-$SHIBBOLETH_VERSION/conf/feedhenry.idp.properties

WORKDIR /opt/$SHIBBOLETH_DIRECTORY-$SHIBBOLETH_VERSION
RUN ./bin/install.sh -Didp.merge.properties=/opt/$SHIBBOLETH_DIRECTORY-$SHIBBOLETH_VERSION/conf/feedhenry.idp.properties -Didp.target.dir=/opt/$SHIBBOLETH_DIRECTORY -Didp.host.name=idp -Didp.scope=feedhenry -Didp.keystore.password=password -Didp.sealer.password=password
