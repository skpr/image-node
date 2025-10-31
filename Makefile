#!/usr/bin/make -f

NODE_VERSION=22

# Example build command for local development.
# See Github Action for multi-arch and multi-stream building.
nbake:
	NODE_VERSION=${NODE_VERSION} docker buildx bake --pull --no-cache

.PHONY: *
