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

# Rename the original configuration file
RUN mv /opt/wildfly/standalone/configuration/standalone-full.xml /opt/wildfly/standalone/configuration/standalone-full.xml.orig

# WildFly configuration file ready for HTTPS
ADD configuration/xml/standalone-full-sample.xml /opt/wildfly/standalone/configuration/standalone-full.xml

# Add the certificate.sh script into $JBOSS_HOME/standalone/configuration/certs
ADD configuration/certs/ /opt/wildfly/standalone/configuration/certs

# Switch to $JBOSS_HOME/configuration/certs
WORKDIR /opt/wildfly/standalone/configuration/certs

# Execute the script to generate self signed certificates
RUN ./certificate.sh

WORKDIR /opt/$SHIBBOLETH_DIRECTORY-$SHIBBOLETH_VERSION
RUN ./bin/install.sh -Didp.merge.properties=/opt/$SHIBBOLETH_DIRECTORY-$SHIBBOLETH_VERSION/conf/feedhenry.idp.properties -Didp.target.dir=/opt/$SHIBBOLETH_DIRECTORY -Didp.host.name=idp -Didp.scope=feedhenry -Didp.keystore.password=password -Didp.sealer.password=password

# Expose SSL default port
EXPOSE 8443
