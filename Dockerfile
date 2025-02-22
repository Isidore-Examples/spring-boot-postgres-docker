# Stage 1: Build the application using Maven
FROM maven:3.9.9-eclipse-temurin-21-alpine AS build
WORKDIR /app

# Copy project files and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy source code and package the app
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run the built JAR in a lightweight image
FROM eclipse-temurin:23-jdk-alpine-3.21
WORKDIR /app

# Copy the JAR from the build stage
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]