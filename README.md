# Spring Boot Hello World with PostgreSQL using Docker

This project demonstrates a simple Spring Boot application connected to a PostgreSQL database, containerized with Docker. It includes debug variants to enable remote debugging.

---

## **Prerequisites**

Before running the application, ensure you have the following installed:

### **1. Docker**

- **Installation:**
   - [Docker Desktop (Windows & Mac)](https://www.docker.com/products/docker-desktop/)
   - [Docker Engine (Linux)](https://docs.docker.com/engine/install/)
- **Verify Installation:**
  ```bash
  docker --version
  ```

### **2. Docker Compose**

Docker Desktop includes Docker Compose by default.

- **Verify Installation:**
  ```bash
  docker-compose --version
  ```

### **3. Java (JDK 23)**

- **Installation:** [Eclipse Temurin JDK](https://adoptium.net/temurin/releases/)
- **Verify Installation:**
  ```bash
  java -version
  ```

### **4. Maven**

- **Installation:** [Maven Installation Guide](https://maven.apache.org/install.html)
- **Verify Installation:**
  ```bash
  mvn -v
  ```

---

## **Building the Application**

Compile and package the application into a JAR file:

```bash
mvn clean package -DskipTests
```

> **Note:** The compiled JAR will be placed in the `target/` directory.

---

## **Running the Application**

### **1. Without Debugging**

Run the application using Docker Compose:

```bash
docker-compose up --build
```

This will:

- Build the Docker image for the Spring Boot app.
- Start the PostgreSQL database container.
- Start the Spring Boot app container once PostgreSQL is healthy.

**Access the application:**\
Open [http://localhost:8080](http://localhost:8080) in your browser.

---

### **2. With Debugging**

Use the debug variants to enable remote debugging on port `5005`.

#### **Run Debug Variant:**

```bash
docker-compose -f docker-compose.debug.yml up --build
```

#### **Debug Configuration (in your IDE):**

- **Host:** `localhost`
- **Port:** `5005`
- **Transport:** Socket
- **Connection Type:** Attach to remote JVM

**Access the application:**

- Web: [http://localhost:8080](http://localhost:8080)
- Debugger: Attach via IDE on port `5005`

---

## **Stopping and Cleaning Up**

To stop the containers:

```bash
docker-compose down
```

To stop and remove all containers, networks, and volumes:

```bash
docker-compose down -v
```

---

## **Project Structure**

```plaintext
├── Dockerfile                 # Production Dockerfile
├── Dockerfile.debug           # Debug-enabled Dockerfile
├── docker-compose.yml         # Docker Compose for production
├── docker-compose.debug.yml   # Docker Compose for debugging
├── target/                    # Maven output directory containing app.jar
└── README.md                  # Project documentation
```

---

## **Ports**

| **Port** | **Service** | **Description**                 |
| -------- | ----------- | ------------------------------- |
| 8080     | Spring Boot | Application endpoint            |
| 5005     | Debug Port  | Remote debugger (debug variant) |
| 5432     | PostgreSQL  | Database access                 |

---

## **Common Issues & Troubleshooting**

### **1. Port Already in Use**

If you get an error about ports being used:

```bash
lsof -i :8080  # Find process using port 8080
kill <PID>     # Replace <PID> with the process ID
```

### **2. Database Connection Errors**

- Ensure the PostgreSQL container is healthy.
- Wait a few seconds after starting the services; PostgreSQL needs time to initialize.

### **3. Docker Build Caching Issues**

To force a clean rebuild:

```bash
docker-compose build --no-cache
```