FROM from_image AS base

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

ENV PATH=/data/node_modules/.bin:$PATH

# Temporary build stage where we can run the test suite.
FROM base AS test
COPY --from=ghcr.io/goss-org/goss:latest /usr/bin/goss /usr/bin/goss
ADD goss.yml /tmp/goss.yml
RUN goss --gossfile=/tmp/goss.yml validate

FROM base AS run
CMD ["bash"]
