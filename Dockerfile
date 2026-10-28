# ---------- Stage 1: build (Kamilla Bekmukhametova) ----------
FROM eclipse-temurin:21-jdk AS build
WORKDIR /workspace

# Copy Gradle wrapper first so dependency downloads are cached
COPY gradlew settings.gradle build.gradle ./
COPY gradle gradle
RUN chmod +x gradlew && ./gradlew dependencies --no-daemon > /dev/null

COPY src src
RUN ./gradlew bootJar --no-daemon -x test

# ---------- Stage 2: runtime ----------
FROM eclipse-temurin:21-jre
LABEL maintainer="Kamilla Bekmukhametova" \
      app="bekmukhametova-kamilla-student-api"
WORKDIR /app

COPY --from=build /workspace/build/libs/app.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
