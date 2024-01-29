ARG FROM_IMAGE
FROM ${FROM_IMAGE}

# Libuv 1.45.0 is affected by a kernel bug on certain kernels.
# This leads to errors where Garden tool downloading errors with ETXTBSY
# Apparently file descriptor accounting is broken when using USE_IO_URING
# on older kernels
# See also: https://github.com/libuv/libuv/pull/4141/files
# TODO: Remove this once libuv 1.47 landed in a future NodeJS version, and we upgraded to it.
ENV UV_USE_IO_URING=0

RUN apk add --no-cache \
  bash \
  ca-certificates \
  g++ \
  git \
  make \
  openssh-client \
  python3 \
  tar \
  # Below are for packages such as https://www.npmjs.com/package/imagemin
  autoconf \
  automake \
  libpng-dev \
  libtool \
  nasm \
  util-linux \
  vips-dev


RUN deluser node
RUN adduser -D -u 1000 skpr
RUN mkdir /data && chown skpr:skpr /data

WORKDIR /data

USER skpr

ENV PATH /data/node_modules/.bin:$PATH
