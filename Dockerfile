FROM openjdk:17-jdk-slim

# Set the working directory inside the container.
WORKDIR /app


COPY target/*.jar /app/my-jar-file

EXPOSE 8080

CMD ["java", "-jar", "my-jar-file"]
