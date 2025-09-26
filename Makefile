#!/usr/bin/make -f

NODE_VERSION=22
VERSION=v3
STREAM=latest
PLATFORMS="linux/amd64,linux/arm64"

# Example build command for local development.
# See Github Action for multi-arch and multi-stream building.
nbake:
	NODE_VERSION=${NODE_VERSION} STREAM=${STREAM} PLATFORMS=${PLATFORMS} docker buildx bake

test:
	docker run --rm \
		-v .:/etc/cstest:ro \
		-v /var/run/docker.sock:/var/run/docker.sock:ro \
		ghcr.io/googlecontainertools/container-structure-test:1.19.3 test \
		-c /etc/cstest/tests.yml \
		-i ghcr.io/skpr/node:${NODE_VERSION}-${VERSION}-${STREAM}

.PHONY: *
