# Use a base image that has Java 17 installed and is available in Artifactory
ARG REGISTRY=tomjfrog.jfrog.io/petclinicmonolith-docker-dev-virtual
FROM $REGISTRY/amazoncorretto:17 as builder

# Set the working directory to /app
WORKDIR /app

#Define ARG Again -ARG variables declared before the first FROM need to be declered again
ARG APP_REPO=https://tomjfrog.jfrog.io/artifactory/petclinicmonolith-maven-dev-local

# Ensure you supply an environment variable for the JFrog access token at build time
# For example: docker build -t petclinic-test:latest . --build-arg JF_TOKEN=${JF_TOKEN}
ARG JF_TOKEN

# Download the Spring Pet Clinic app jar file artifact from Artifactory into the container
# RUN yum update && yum install -y curl
RUN curl $APP_REPO/org/springframework/samples/spring-petclinic/3.0.0-SNAPSHOT/spring-petclinic-3.0.0-20230329.143015-1.jar --output app.jar -u docker:$JF_TOKEN

# 2nd stage, build the runtime image
ARG REGISTRY=tomjfrog.jfrog.io/petclinicmonolith-docker-dev-virtual
FROM $REGISTRY/amazoncorretto:17-alpine-jdk
WORKDIR /app

COPY --from=builder /app/app.jar .


# Set the JAVA_OPTS environment variable
ENV JAVA_OPTS=""

# Expose port 8080 for the Spring Boot app
EXPOSE 8080

# Set the entry point for the container to run the Spring Boot app
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -jar /app/app.jar" ]
