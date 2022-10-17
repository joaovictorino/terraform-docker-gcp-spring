FROM openjdk:11.0-jre
EXPOSE 80
COPY ./springapp/target/spring-petclinic-2.7.3.jar /app.jar
ENTRYPOINT ["java","-Dspring.profiles.active=mysql","-jar","/app.jar", "--server.port=80"]
