FROM base AS run

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

# Replace npm with a wrapper script to enforce security.
RUN mv /usr/local/bin/npm /usr/local/bin/npm-unsafe
ADD --chown=skpr:skpr bin/npm-wrapper /usr/local/bin/npm
RUN chmod +x /usr/local/bin/npm

# Replace yarn with a wrapper script to enforce security.
RUN mv /usr/local/bin/yarn /usr/local/bin/yarn-unsafe
ADD --chown=skpr:skpr bin/yarn-wrapper /usr/local/bin/yarn
RUN chmod +x /usr/local/bin/yarn

# Install pnpm globally using the "safe" npm wrapper.
# @todo, To be replaced with APK package when available (We want 10+).
RUN npm install -g pnpm@10

USER skpr

ENV PATH /data/node_modules/.bin:$PATH

# Temporary build stage where we can run the test suite.
FROM run AS test
COPY --from=ghcr.io/goss-org/goss:latest /usr/bin/goss /usr/bin/goss
ADD goss.yml /etc/goss/goss.yml
RUN goss --gossfile=/etc/goss/goss.yml validate

# Swap back to the run stage.
FROM run
