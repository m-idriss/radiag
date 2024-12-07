# Stage 1: Build the application using a Maven base image
FROM maven:3.9.9-eclipse-temurin-17-alpine AS build

WORKDIR /work
COPY . .
RUN mvn clean package -Pnative -Dquarkus.native.container-build=true

# Stage 2: Create the final image
FROM ubuntu:22.04
WORKDIR /work
COPY --from=build /work/target/radiag /work/radiag
EXPOSE 8080
CMD ["./radiag"]
