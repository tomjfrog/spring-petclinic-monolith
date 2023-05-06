# Use a base image that has Java 11 installed
FROM openjdk:11-jdk-slim

# Set the working directory to /app
WORKDIR /app

# Copy the Spring Pet Clinic app jar file to the container
COPY target/spring-petclinic-*.jar app.jar

# Expose port 8080 for the Spring Boot app
EXPOSE 8080

# Set the entry point for the container to run the Spring Boot app
ENTRYPOINT ["java", "-jar", "app.jar"]
