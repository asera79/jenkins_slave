FROM asera79/java8:alpine

MAINTAINER asera79@gmail.com

RUN apk add --no-cache ca-certificates

ENV DOCKER_CHANNEL edge
ENV DOCKER_VERSION 17.05.0-ce

RUN set -ex && \
    apk add --no-cache --virtual .fetch-deps curl tar && \
    cd /tmp && \
    curl -fL -o docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/${dockerArch}/docker-${DOCKER_VERSION}.tgz" && \
    tar xzvf docker.tgz && mv ./docker /usr/lib/docker && \
    ln -s /usr/lib/docker/docker /usr/bin/docker && \
    rm -rf /tmp/*
