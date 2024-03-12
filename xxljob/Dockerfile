FROM xuxueli/xxl-job-admin:2.4.0 AS builder

FROM ibm-semeru-runtimes:open-8-jre-jammy

COPY --from=builder /app.jar /app.jar

ENV XMS=512m XMX=512m

WORKDIR /

ENTRYPOINT java -Xms${XMS} -Xmx${XMX} -jar $JAVA_OPTS /app.jar $PARAMS