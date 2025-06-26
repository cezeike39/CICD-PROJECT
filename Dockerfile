FROM openjdk:17-jdk-slim

# Set the working directory inside the container.
WORKDIR /app


COPY my-jar-file /app/your-application.jar

EXPOSE 8080

CMD ["java", "-jar", "your-application.jar"]
