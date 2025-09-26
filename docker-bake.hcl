variable "NODE_VERSION" {
  default = "22"
}

variable "STREAM" {
  default = "latest"
}

variable "VERSION" {
  default = "v3"
}

group "default" {
  targets = ["prod", "dev"]
}

target "prod" {
  context = "."

  contexts = {
    base = "docker-image://node:${NODE_VERSION}-alpine3.21"
  }

  platforms = [
    "linux/amd64",
    "linux/arm64",
  ]

  tags = [
    "docker.io/skpr/node:${NODE_VERSION}-${VERSION}-${STREAM}",
    "ghrc.io/skpr/node:${NODE_VERSION}-${VERSION}-${STREAM}",
  ] 
}

target "dev" {
  context = "dev"

  contexts = {
    base = "target:prod"
  }

  platforms = [
    "linux/amd64",
    "linux/arm64",
  ]

  tags = [
    "docker.io/skpr/node:dev-${NODE_VERSION}-${VERSION}-${STREAM}",
    "ghrc.io/skpr/node:dev-${NODE_VERSION}-${VERSION}-${STREAM}",
  ]
}
