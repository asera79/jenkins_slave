FROM asera79/java8:alpine

MAINTAINER asera79@gmail.com

ENV DOCKER_CHANNEL edge
ENV DOCKER_VERSION 17.05.0-ce

ADD docker-entrypoint.sh /usr/local/bin

RUN apk update && apk add --no-cache ca-certificates && \
    set -ex && \
    apk add --no-cache --virtual .fetch-deps curl tar && \
    cd /tmp && \
    curl -fL -o docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" && \
    tar xzvf docker.tgz && mv ./docker /usr/lib/docker && \
    rm -rf /tmp/*

ADD docker /usr/bin/docker

RUN chmod +x /usr/bin/docker

RUN apk add openssh sudo

RUN rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key

RUN adduser -D -s /bin/sh -h /home/jenkins -g "" jenkins && echo "jenkins:jenkins" | chpasswd

ADD jenkins_sudo /etc/sudoers.d/jenkins

EXPOSE 22
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/sbin/sshd","-D"]
