# Stage 1: build
FROM maven:3.8.6-eclipse-temurin-17-slim AS build
WORKDIR /app
COPY samere /app
RUN mvn clean package -DskipTests

# Stage 2: runtime
FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
