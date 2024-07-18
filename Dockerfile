# Use an official Maven image to build the application
FROM maven:3.8.1-jdk-11 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the project's pom.xml and source code into the working directory
COPY pom.xml .
COPY src ./src

# Package the application using Maven
RUN mvn clean package

# Use an official OpenJDK runtime as a parent image
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the packaged jar file from the build stage
COPY --from=build /app/target/sample-java-app-*.jar /app/sample-java-app.jar

# Command to run the application
ENTRYPOINT ["java", "-jar", "sample-java-app.jar"]
