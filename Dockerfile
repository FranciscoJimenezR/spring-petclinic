ARG GITHUB_USER=FranciscoJimenezR
ARG GITHUB_APP=spring-petclinic
ARG GITHUB_REPOSITORY=FranciscoJimenezR/spring-petclinic
FROM alpine/git:latest AS clone
WORKDIR /${GITHUB_USER}
RUN git clone https://github.com/${GITHUB_REPOSITORY}
FROM maven:alpine AS build
WORKDIR /${GITHUB_REPOSITORY}
COPY --from=clone /${GITHUB_REPOSITORY} .
RUN ./mvnw package && mv target/${GITHUB_APP}-*.jar target/${GITHUB_APP}.jar
FROM openjdk:jre-alpine AS production
ENTRYPOINT ["java","-jar"]
CMD ${GITHUB_APP}.jar
