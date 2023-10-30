ARG NODE_VERSION=16
ARG ALPINE_VERSION=3.18
ARG VERSION_TAG=v2-latest
FROM docker.io/skpr/node:${NODE_VERSION}-v2-latest

USER root
RUN apk add --no-cache \
  chromium

WORKDIR /data

USER skpr
