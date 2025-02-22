# Spring Boot + Docker + PostgreSQL: Build & Deployment Summary

## Build Process Overview

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