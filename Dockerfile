FROM maven:3.5.4-jdk-8-alpine as base
WORKDIR /app
COPY . .
RUN mvn clean package

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=base /app/target/my-app-1.0-SNAPSHOT.jar .
CMD ["java", "-jar", "my-app-1.0-SNAPSHOT.jar"]