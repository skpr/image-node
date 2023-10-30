#!/usr/bin/make -f

REGISTRY=skpr/node
ALPINE_VERSION=3.15
NODE_VERSION=16
ARCH=amd64
VERSION_TAG=v2-latest

build:
	$(eval IMAGE=${REGISTRY}:${NODE_VERSION}-${VERSION_TAG})
	docker build --build-arg ALPINE_VERSION=${ALPINE_VERSION} --build-arg NODE_VERSION=${NODE_VERSION} -t ${IMAGE}-${ARCH} .
	# build dev images
	$(eval IMAGE=${REGISTRY}:dev-${NODE_VERSION}-${VERSION_TAG})
	docker build --build-arg ALPINE_VERSION=${ALPINE_VERSION} --build-arg NODE_VERSION=${NODE_VERSION} -t ${IMAGE}-${ARCH} dev

push:
	$(eval IMAGE=${REGISTRY}:${NODE_VERSION}-${VERSION_TAG})
	docker push ${IMAGE}-${ARCH}
	$(eval IMAGE=${REGISTRY}:dev-${NODE_VERSION}-${VERSION_TAG})
	docker push ${IMAGE}-${ARCH}

manifest:
	$(eval IMAGE=${REGISTRY}:${NODE_VERSION}-${VERSION_TAG})
	docker manifest create ${IMAGE} --amend ${IMAGE}-arm64 --amend ${IMAGE}-amd64
	docker manifest push ${IMAGE}
	$(eval IMAGE=${REGISTRY}:dev-${NODE_VERSION}-${VERSION_TAG})
	docker manifest create ${IMAGE} --amend ${IMAGE}-arm64 --amend ${IMAGE}-amd64
	docker manifest push ${IMAGE}

.PHONY: *
