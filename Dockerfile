# Use Gradle image to build the application
FROM gradle:8.5-jdk17 AS build
WORKDIR /app

# Copy source code
COPY --chown=gradle:gradle . .

# Build the application
RUN gradle build --no-daemon

# Use a smaller JDK image for runtime
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app

# Copy the built jar from the previous stage
COPY --from=build /app/build/libs/*.jar app.jar

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
