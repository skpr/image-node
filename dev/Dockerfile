ARG FROM_IMAGE
FROM ${FROM_IMAGE}

USER root
RUN apk add --no-cache \
  chromium

WORKDIR /data

USER skpr
