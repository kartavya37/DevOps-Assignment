FROM eclipse-temurin:21-jdk

WORKDIR /app

COPY Main.java ./

# compile during the build, so the container starts straight into the app
RUN javac Main.java

EXPOSE 8080

CMD ["java", "Main"]
