# Use a base image that has Java 17 installed and is available in Artifactory
ARG REGISTRY=https://tomjfrog.jfrog.io/artifactory/petclinicmonolith-docker-dev-virtual/artifactory
FROM openjdk:17-jdk-slim

# Set the working directory to /app
WORKDIR /app

#Define ARG Again -ARG variables declared before the first FROM need to be declered again
ARG REGISTRY=https://tomjfrog.jfrog.io/artifactory/petclinicmonolith-maven-dev-local
ARG JF_TOKEN

# Download the Spring Pet Clinic app jar file artifact from Artifactory into the container
RUN apt-get update && apt-get install -y curl
RUN curl $REGISTRY/org/springframework/samples/spring-petclinic/3.0.0-SNAPSHOT/spring-petclinic-3.0.0-20230329.143015-1.jar --output app.jar -u docker:$JF_TOKEN

# Set the JAVA_OPTS environment variable
ENV JAVA_OPTS=""

# Expose port 8080 for the Spring Boot app
EXPOSE 8080

# Set the entry point for the container to run the Spring Boot app
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -jar /app/app.jar" ]
