FROM maven:3.6.0-jdk-8-alpine As builder

WORKDIR /capstone

COPY . .

RUN mvn package -DskipTests



FROM openjdk:18-jdk-alpine3.15

WORKDIR /cap

COPY --from=builder /capstone/target/StudentRegistration-0.0.1-SNAPSHOT.jar  .

EXPOSE 8081


ENV SQL_URL=localhost SQL_PORT=3306 SQL_USR=root SQL_PW=root@1234 SQL_TABLE=mydb


ENTRYPOINT ["java","-jar"]

CMD ["StudentRegistration-0.0.1-SNAPSHOT.jar"]

