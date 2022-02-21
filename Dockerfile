FROM mcr.microsoft.com\azure-cloudshell@sha256:075eadba1d78d537fa188fe82d4bc0f6e552ab3416d60c0b43bff5fd5372535e

COPY ./Login.ps1 /etc/util-scripts/Login.ps1

ENV DOCKER_HOST unix:///var/run/docker.sock
ARG DOCKER_PATH="/usr/bin"
ARG DOCKER_VERSION="18.03.1"
ARG DOCKER_URI="https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}-ce.tgz"
ARG DOCKER_GID="412"

RUN apk --no-cache add curl && \
    curl ${DOCKER_URI} -o /tmp/docker-${DOCKER_VERSION}.tgz && \
    cd /tmp && \
    tar -xvzf /tmp/docker-${DOCKER_VERSION}.tgz docker/docker && \
    mv -v docker/docker ${DOCKER_PATH}/docker && \
    rmdir -v docker && \
    rm -v /tmp/docker-${DOCKER_VERSION}.tgz && \
    chmod -v +x ${DOCKER_PATH}/docker

RUN addgroup -S -g ${DOCKER_GID} docker && \
    adduser -S -G docker docker && \
    adduser -G docker -u 1000 -D jenkins

RUN chmod +x /etc/util-scripts/Login.ps1
