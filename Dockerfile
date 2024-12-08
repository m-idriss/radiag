### STAGE 1: Build ###
FROM maven:3.9.9-eclipse-temurin-17-alpine AS build
WORKDIR /opt/apt
COPY pom.xml .
COPY src ./src
# Build app
RUN mvn clean package -Pnative -Dquarkus.native.container-build=true

# Stage 2: Create the final image
FROM ubuntu:22.04
WORKDIR /work
COPY --from=build /opt/apt/target/*-runner /work/radiag
EXPOSE 8080
CMD ["./radiag"]