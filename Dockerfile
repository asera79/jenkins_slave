FROM docker:edge

MAINTAINER asera79@gmail.com

ENV JAVA_HOME=/usr/lib/jvm/default-jvm

RUN apk add --no-cache --virtual=build-dependencies wget ca-certificates && \
    cd "/tmp" && \
    wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
    http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz && \
    tar -xzf "jdk-8u131-linux-x64.tar.gz" && \
    mkdir -p "/usr/lib/jvm" && \
    mv "/tmp/jdk1.8.0_131" "/usr/lib/jvm/java-8-oracle" && \
    ln -s "java-8-oracle" "$JAVA_HOME" && \
    ln -s "$JAVA_HOME/bin/"* "/usr/bin/" && \
    rm -rf "$JAVA_HOME/"*src.zip && \
    rm -rf "$JAVA_HOME/lib/missioncontrol" \
    "$JAVA_HOME/lib/visualvm" \
    "$JAVA_HOME/lib/"*javafx* \
    "$JAVA_HOME/jre/lib/plugin.jar" \
    "$JAVA_HOME/jre/lib/ext/jfxrt.jar" \
    "$JAVA_HOME/jre/bin/javaws" \
    "$JAVA_HOME/jre/lib/javaws.jar" \
    "$JAVA_HOME/jre/lib/desktop" \
    "$JAVA_HOME/jre/plugin" \
    "$JAVA_HOME/jre/lib/"deploy* \
    "$JAVA_HOME/jre/lib/"*javafx* \
    "$JAVA_HOME/jre/lib/"*jfx* \
    "$JAVA_HOME/jre/lib/amd64/libdecora_sse.so" \
    "$JAVA_HOME/jre/lib/amd64/"libprism_*.so \
    "$JAVA_HOME/jre/lib/amd64/libfxplugins.so" \
    "$JAVA_HOME/jre/lib/amd64/libglass.so" \
    "$JAVA_HOME/jre/lib/amd64/libgstreamer-lite.so" \
    "$JAVA_HOME/jre/lib/amd64/"libjavafx*.so \
    "$JAVA_HOME/jre/lib/amd64/"libjfx*.so && \
    apk del build-dependencies && \
    rm "/tmp/"*
