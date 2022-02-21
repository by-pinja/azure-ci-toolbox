FROM mcr.microsoft.com/azure-powershell:7.2.0-alpine-3.14

COPY ./Login.ps1 /etc/util-scripts/Login.ps1

ENV DOCKER_HOST unix:///var/run/docker.sock
ARG DOCKER_PATH="/usr/bin"
ARG DOCKER_VERSION="18.03.1"
ARG DOCKER_URI="https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}-ce.tgz"
ARG DOCKER_GID="412"
ARG BICEP_VERSION="v0.4.1272"

RUN apk add --no-cache curl && \
    curl ${DOCKER_URI} -o /tmp/docker-${DOCKER_VERSION}.tgz && \
    cd /tmp && \
    tar -xvzf /tmp/docker-${DOCKER_VERSION}.tgz docker/docker && \
    mv -v docker/docker ${DOCKER_PATH}/docker && \
    rmdir -v docker && \
    rm -v /tmp/docker-${DOCKER_VERSION}.tgz && \
    chmod -v +x ${DOCKER_PATH}/docker

RUN addgroup --system --gid ${DOCKER_GID} docker && \
    adduser --system --ingroup docker docker && \
    adduser --ingroup docker -u 1000 --disabled-password jenkins

RUN curl -Lo bicep https://github.com/Azure/bicep/releases/download/${BICEP_VERSION}/bicep-linux-musl-x64 && \
    chmod +x ./bicep && \
    mv ./bicep /usr/local/bin/bicep

RUN chmod +x /etc/util-scripts/Login.ps1
