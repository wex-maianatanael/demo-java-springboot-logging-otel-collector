# Step 1: Build (using Maven like temporary image)
FROM maven:3.9.6-amazoncorretto-21 AS build

WORKDIR /app

# Firstly copy pom.xml and resolve dependencies (for better caching)
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the rest of the code and compile the project
COPY src ./src
RUN mvn clean package -DskipTests

# Step 2: Runtime
FROM amazoncorretto:21

# Application directory
WORKDIR /app

# Copy the JAR generated in the previous step
COPY --from=build /app/target/*.jar app.jar

# Expose the port for the API
EXPOSE 8080

# Allow envrionment variables for OTEL and others
ENV JAVA_OPTS=""

# Startup command
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
