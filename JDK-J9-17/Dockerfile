FROM ibm-semeru-runtimes:open-17-jdk-jammy
ADD ./arthas-bin /app/arthas-bin
ADD ./skywalking-agent /skywalking-agent
RUN apt-get update && apt-get install -y curl telnet vim iputils-ping net-tools unzip procps fontconfig libsasl2-2 libpq5 libyaml-0-2 &&  cp -a /usr/lib/x86_64-linux-gnu/libsasl2.so.2 /usr/lib/x86_64-linux-gnu/libsasl2.so.3 && locale-gen zh_CN.UTF-8 && update-locale LANG=zh_CN.UTF-8
