FROM openjdk:11 AS BUILD_IMAGE
RUN command apd-get update && apt-get install -y maven
COPY . /vprofile-project
RUN cd vprofile-project && mvn install

FROM tomcat:10-jre11
LABEL "Project"="Vprofile"
LABEL "Author"="Imran"

RUN rm -rf /usr/local/tomcat/webapps/*
COPY target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
WORKDIR /usr/local/tomcat/
VOLUME /usr/local/tomcat/webapps