#Stage 0

FROM maven:3.8.3-openjdk-17 AS BUILD
WORKDIR /app
COPY .  .
RUN mvn package -DskipTests


#Stage 1

FROM openjdk:18-alpine as RUN
WORKDIR /run
COPY --from=BUILD /app/target/demo-0.0.1-SNAPSHOT.jar demo.jar

ARG USER=devops
ENV HOME /home/$USER
RUN adduser -D $USER && \
    chown $USER:$USER /run/demo.jar
USER $USER 

EXPOSE 8080
CMD java  -jar /run/demo.jar
