#!/usr/bin/make -f

REGISTRY=skpr/node
ALPINE_VERSION=3.20
NODE_VERSION=20
ARCH=amd64
VERSION_TAG=v2-latest

IMAGE=${REGISTRY}:${NODE_VERSION}-${VERSION_TAG}
IMAGE_DEV=${REGISTRY}:dev-${NODE_VERSION}-${VERSION_TAG}

build:
	# Building production image.
	docker build --build-arg FROM_IMAGE=node:${NODE_VERSION}-alpine${ALPINE_VERSION} -t ${IMAGE}-${ARCH} .
	# Building development image.
	docker build --build-arg FROM_IMAGE=${IMAGE}-${ARCH} -t ${IMAGE_DEV}-${ARCH} dev

push:
	# Pushing production image.
	docker push ${IMAGE}-${ARCH}
	# Pushing development image.
	docker push ${IMAGE_DEV}-${ARCH}

manifest:
	# Creating manifest for production image.
	docker manifest create ${IMAGE} --amend ${IMAGE}-arm64 --amend ${IMAGE}-amd64
	docker manifest push ${IMAGE}
	# Creating manifest for development image.
	docker manifest create ${IMAGE_DEV} --amend ${IMAGE_DEV}-arm64 --amend ${IMAGE_DEV}-amd64
	docker manifest push ${IMAGE_DEV}

.PHONY: *
