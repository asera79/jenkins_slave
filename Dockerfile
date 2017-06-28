FROM asera79/java8:alpine

MAINTAINER asera79@gmail.com

ENV DOCKER_CHANNEL edge
ENV DOCKER_VERSION 17.05.0-ce

ADD docker-entrypoint.sh /usr/local/bin

RUN apk update && apk add --no-cache ca-certificates && \
    set -ex && \
    apk add --no-cache --virtual .fetch-deps curl tar openssh && \
    cd /tmp && \
    curl -fL -o docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" && \
    tar xzvf docker.tgz && mv ./docker /usr/lib/docker && \
    ln -s /usr/lib/docker/docker /usr/bin/docker && \
    rm -rf /tmp/* && \
    rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key

EXPOSE 22
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/sbin/sshd","-D"]
