ARG NODE_VERSION=16
ARG ALPINE_VERSION=3.18
ARG VERSION_TAG=v2-latest
FROM docker.io/skpr/node:${NODE_VERSION}-${VERSION_TAG}

RUN apk add --no-cache \
  bash \
  ca-certificates \
  g++ \
  git \
  make \
  openssh-client \
  python2 \
  tar \
  # Below are for packages such as https://www.npmjs.com/package/imagemin
  autoconf \
  automake \
  libpng-dev \
  libtool \
  nasm \
  util-linux \
  vips-dev \
  chromium


RUN deluser node
RUN adduser -D -u 1000 skpr
RUN mkdir /data && chown skpr:skpr /data

WORKDIR /data

USER skpr

ENV PATH /data/node_modules/.bin:$PATH
