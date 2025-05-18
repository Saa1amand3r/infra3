FROM eclipse-temurin:21-jre-alpine AS base

FROM base AS builder
WORKDIR /app

RUN apk add --no-cache curl bash unzip openjdk21

RUN java -version

COPY . .

RUN curl -sSL https://services.gradle.org/distributions/gradle-8.13-bin.zip -o gradle-8.13-bin.zip \
    && unzip gradle-8.13-bin.zip \
    && mv gradle-8.13 /opt/gradle

ENV PATH="/opt/gradle/bin:${PATH}"

RUN ./gradlew bootJar

FROM base AS final
WORKDIR /app

COPY --from=builder /app/build/libs/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
