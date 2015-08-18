FROM centos/wildfly:latest

ENV SHIBBOLETH_VERSION=3.1.2
ENV SHIBBOLETH_DIRECTORY=shibboleth-identity-provider
ENV SHIBBOLETH_ARCHIVE=$SHIBBOLETH_DIRECTORY-$SHIBBOLETH_VERSION.tar.gz
ENV SHIBBOLETH_URL=http://shibboleth.net/downloads/identity-provider/latest/$SHIBBOLETH_ARCHIVE
ENV JAVA_HOME=/usr/lib/jvm/java/
ENV HOST_IP=172.17.42.1

#Prepare System
USER root
RUN yum -y update
RUN yum -y install wget
RUN yum -y install java-1.8.0-*
RUN yum -y remove java-1.7.0-*

#Download and unpack Shibboleth
WORKDIR /opt
RUN wget $SHIBBOLETH_URL

RUN tar -zxvf $SHIBBOLETH_ARCHIVE
RUN mkdir  $SHIBBOLETH_DIRECTORY
RUN rm $SHIBBOLETH_ARCHIVE

RUN sed -i -r "s/('::1\\/128')/\1,'$HOST_IP'/g" /opt/$SHIBBOLETH_DIRECTORY-$SHIBBOLETH_VERSION/conf/access-control.xml

#Install Xerces and add to shibboleth

RUN wget http://apache.arvixe.com//xerces/j/binaries/Xerces-J-bin.2.11.0.tar.gz
RUN tar -zxvf Xerces-J-bin.2.11.0.tar.gz
RUN cp xerces-2_11_0/resolver.jar shibboleth-identity-provider-3.1.2/webapp/WEB-INF/lib/
RUN cp xerces-2_11_0/serializer.jar shibboleth-identity-provider-3.1.2/webapp/WEB-INF/lib/
RUN cp xerces-2_11_0/xercesImpl.jar shibboleth-identity-provider-3.1.2/webapp/WEB-INF/lib/
RUN cp xerces-2_11_0/xml-apis.jar shibboleth-identity-provider-3.1.2/webapp/WEB-INF/lib/


COPY feedhenry.idp.properties /opt/$SHIBBOLETH_DIRECTORY-$SHIBBOLETH_VERSION/conf/feedhenry.idp.properties
COPY jboss-deployment-structure.xml /opt/$SHIBBOLETH_DIRECTORY-$SHIBBOLETH_VERSION/webapp/META-INF/jboss-deployment-structure.xml

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

# COPY War file to wildfly
WORKDIR /opt
RUN cp $SHIBBOLETH_DIRECTORY/war/idp.war /opt/wildfly/standalone/deployments/


# Expose SSL default port
EXPOSE 8443
