# Stage 1: Build the application using a Maven base image
FROM maven:3.8.6-openjdk-17-slim AS build

WORKDIR /work
COPY . .
RUN mvn clean package -Pnative -Dquarkus.native.container-build=true

# Stage 2: Create the final image
FROM ubuntu:22.04
WORKDIR /work
COPY --from=build /work/target/radiag /work/radiag
EXPOSE 8080
CMD ["./radiag"]
