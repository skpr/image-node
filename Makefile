#!/usr/bin/make -f

NODE_VERSION=22
STREAM=latest

# Example build command for local development.
# See Github Action for multi-arch and multi-stream building.
nbake:
	NODE_VERSION=${NODE_VERSION} STREAM=${STREAM} docker buildx bake

.PHONY: *
