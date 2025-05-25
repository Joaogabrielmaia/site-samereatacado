# Stage 1: build
FROM openjdk:21-slim AS build

# Instalar Maven
RUN apt-get update && apt-get install -y maven

WORKDIR /app

COPY samere /app

RUN mvn clean package -DskipTests

# Stage 2: runtime
FROM openjdk:21-jdk-slim

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
