FROM amazoncorretto:17 AS build
WORKDIR /app

COPY samere /app

# Torna o mvnw executável (importante)
RUN chmod +x ./mvnw

# Usa o wrapper para build
RUN ./mvnw clean package -DskipTests

FROM amazoncorretto:17-jdk-alpine
WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
