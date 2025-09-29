Skpr Node Images
================

Images for building and running Node applications.

## Streams

This image suite provides 2 streams for images:

* `stable` - Our production/stable upstream for projects. Use this by default.
* `latest` - Recently merged changes which will be merged into `stable` as part of a release.

## Images

Images are available in the following registries:

* `ghcr.io`
* `docker.io`

## Image List

Below is the list of Node images we provide.

By default we recommend the following registry and stream:

```
REGISTRY=docker.io
STREAM=stable
```

```
docker.io/skpr/node:24-v3-STREAM
docker.io/skpr/node:22-v3-STREAM
docker.io/skpr/node:20-v3-latest
```

## Building

You need to specify `NODE_VERSION` to build locally:
```
make build NODE_VERSION=24
```
