FROM maven:3.6-jdk-11-slim AS build
COPY springapp/. /src
WORKDIR /src
RUN mvn package -DskipTests

FROM openjdk:11.0-jre
EXPOSE 80
COPY --from=build /src/target/spring-petclinic-2.7.3.jar /app.jar
ENTRYPOINT ["java","-Dspring.profiles.active=mysql","-jar","/app.jar", "--server.port=80"]
