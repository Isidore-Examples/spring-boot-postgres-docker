# 🚀 Spring Boot + Docker + PostgreSQL: Build & Deployment Summary

## 🛠️ Build Process Overview

1. **Two-Stage Build (Dockerfile):**
    - **Stage 1 (Build):**  
      Uses a Maven image to:
        - Download dependencies.
        - Build the application JAR file.
    - **Stage 2 (Run):**  
      Uses a lightweight Java image to:
        - Copy the built JAR from Stage 1.
        - Run the JAR file.

2. **Running with Docker Compose:**
    - **Brings up multiple services** (Spring Boot app + PostgreSQL).
    - Manages dependencies (`depends_on` ensures the database starts first).
    - Handles environment variables for configuration.

3. **Commands:**
    - Maven Build:
       ```bash
       mvn clean package -DskipTests
       ```
    - Build & Run:
      ```bash
      docker compose up --build
      ```
    - Stop & Remove Containers:
      ```bash
      docker compose down
      ```

---

## 📝 Dockerfile Breakdown

```dockerfile
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
```

# 🐳 Docker Compose: Spring Boot + PostgreSQL

This `docker-compose.yml` sets up:

- **PostgreSQL** with a health check.
- **Spring Boot** that starts only after the DB is ready.

---

## 📦 Services

### 🗄️ `postgres-hello-world`

```yaml
services:
  postgres-hello-world:
    image: postgres:13
    container_name: postgres-hello-world
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres
      - POSTGRES_DB=postgres
    ports:
      - "5432:5432"
    healthcheck:
      test: [ "CMD-SHELL", "pg_isready -U postgres" ]
      interval: 10s
      timeout: 5s
      retries: 5

  spring-boot-app:
    build:
      context: .
    container_name: spring-boot-hello-world
    depends_on:
      postgres-hello-world:
        condition: service_healthy
    environment:
      - SPRING_DATASOURCE_URL=jdbc:postgresql://postgres-hello-world:5432/postgres
      - SPRING_DATASOURCE_USERNAME=postgres
      - SPRING_DATASOURCE_PASSWORD=postgres
    ports:
      - "8080:8080"
```