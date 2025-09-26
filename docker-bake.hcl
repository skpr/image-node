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

group "default" {
  targets = ["prod", "dev"]
}

target "prod" {
  context = "."

  contexts = {
    base = "docker-image://node:${NODE_VERSION}-alpine${ALPINE_VERSION}"
  }

  platforms = PLATFORMS

  tags = [
    "docker.io/skpr/node:${NODE_VERSION}-${VERSION}-${STREAM}",
    "ghcr.io/skpr/node:${NODE_VERSION}-${VERSION}-${STREAM}",
  ] 
}

target "dev" {
  context = "dev"

  contexts = {
    base = "target:prod"
  }

  platforms = PLATFORMS

  tags = [
    "docker.io/skpr/node:dev-${NODE_VERSION}-${VERSION}-${STREAM}",
    "ghcr.io/skpr/node:dev-${NODE_VERSION}-${VERSION}-${STREAM}",
  ]
}
