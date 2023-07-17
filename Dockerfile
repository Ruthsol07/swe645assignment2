FROM tomcat:9.0-jdk15
LABEL maintainer="ssolipu@gmu.edu"
COPY studentsurform.war /usr/local/tomcat/webapps
EXPOSE 8080
CMD ["catalina.sh","run"]