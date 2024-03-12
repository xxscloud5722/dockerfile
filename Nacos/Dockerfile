FROM nacos/nacos-server:v2.3.1 AS builder

FROM ibm-semeru-runtimes:open-8-jre-jammy

ENV MODE=cluster PREFER_HOST_MODE=ip BASE_DIR=/home/nacos CLASSPATH=.:/home/nacos/conf: CLUSTER_CONF=/home/nacos/conf/cluster.conf FUNCTION_MODE=all NACOS_USER=nacos JAVA=/opt/java/openjdk/bin/java JVM_XMS=384m JVM_XMX=384m JVM_XMN=128m JVM_MS=128m JVM_MMS=320m NACOS_DEBUG=n TOMCAT_ACCESSLOG_ENABLED=false TIME_ZONE=Asia/Shanghai

COPY --from=builder /home/nacos /home/nacos
ADD ./docker-startup.sh /home/nacos/bin/docker-startup.sh

WORKDIR /home/nacos

EXPOSE 8848

ENTRYPOINT ["bin/docker-startup.sh"]