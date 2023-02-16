FROM alpine:latest as build
COPY entrypoint.sh target/example.jar ./
RUN mkdir dep app && \
    cd dep && \
    unzip ../example.jar && \
    cd ../app && \
    mv ../entrypoint.sh ../dep/BOOT-INF/lib ../dep/META-INF ../dep/BOOT-INF/classes/* . && \
    chmod 700 entrypoint.sh

FROM eclipse-temurin:17.0.6_10-jre-alpine
WORKDIR /app
COPY --from=build app .
ENTRYPOINT ["./entrypoint.sh"]
