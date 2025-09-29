variable "NODE_VERSION" {
  default = "22"
}

variable "ALPINE_VERSION" {
  default = "3.21"
}

variable "STREAM" {
  default = "latest"
}

variable "VERSION" {
  default = "v3"
}

variable "PLATFORMS" {
  type    = list(string)
  default = [
    "linux/amd64",
    "linux/arm64",
  ]
}

variable "REGISTRIES" {
  default = ["docker.io", "ghcr.io"]
}

# Common target: Everything inherits from this
target "_common" {
  platforms = PLATFORMS
}

group "default" {
  targets = [
    "prod",
    "dev",
    "test",
  ]
}

target "prod" {
  inherits = ["_common"]
  context = "."

  contexts = {
    from_image = "docker-image://node:${NODE_VERSION}-alpine${ALPINE_VERSION}"
  }

  tags = [
    for r in REGISTRIES :
    "${r}/skpr/node:${NODE_VERSION}-${VERSION}-${STREAM}"
  ]
}

target "dev" {
  inherits = ["_common"]
  context = "dev"

  contexts = {
    from_image = "target:prod"
  }

  tags = [
    for r in REGISTRIES :
    "${r}/skpr/node:dev-${NODE_VERSION}-${VERSION}-${STREAM}"
  ]
}

target "test" {
  matrix = {
    variant = ["prod",]
  }

  name = "${variant}-test"

  inherits = [variant]

  # Run this stage from the Dockerfile.
  target = "test"

  # Only build the test target locally.
  output = ["type=cacheonly"]
}
