FROM openjdk:8-alpine
# Required for starting application up.
RUN apk update && apk add /bin/sh
# create a directory where the application  will be deployed
RUN mkdir -p /opt/app
# set the directory as env variable
ENV PROJECT_HOME /opt/app
# copy the jar package built by maven into the /opt/app directory
COPY target/*.jar $PROJECT_HOME/reg-app.jar
# cd into this directory
WORKDIR $PROJECT_HOME
# expose the application to run on port 8080
EXPOSE 8080
# execute the command to run the application in a docker container
CMD ["java" ,"-jar","./reg-app.jar"]
