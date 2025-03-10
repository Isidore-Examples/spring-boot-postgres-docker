# Use the Eclipse Temurin JDK 23 image with Alpine Linux as the base image.
# - Eclipse Temurin provides open-source Java builds.
# - The 'alpine' variant is lightweight, making the image smaller and faster.
FROM eclipse-temurin:23-jdk-alpine-3.21

# Set the working directory inside the container to '/app'.
# All subsequent commands (COPY, RUN, CMD) will be executed from this directory.
WORKDIR /app

# Copy the compiled JAR file from the 'target' directory (on your host machine) into the container.
# - The wildcard '*.jar' ensures it picks up any JAR file in the 'target' folder.
# - The copied file is renamed to 'app.jar' inside the container.
COPY target/*.jar app.jar

# Inform Docker that the container will listen on port 8080.
# - This doesn't expose the port on the host; it's just metadata for users and tools.
EXPOSE 8080

# Define the default command to run when the container starts.
# - It runs the Java application using the JAR file we copied earlier.
CMD ["java", "-jar", "app.jar"]
