#!/usr/bin/env bats

setup() {
  # load helper libraries when using the official Docker image
  bats_load_library bats-support
  bats_load_library bats-assert
}

@test "npm --help exits 1 and mentions DISCLAIMER" {
  run npm --help
  [ "$status" -eq 1 ]
  assert_output --partial "DISCLAIMER"
}

@test "yarn --help exits 0 and mentions DISCLAIMER" {
  run yarn --help
  [ "$status" -eq 0 ]
  assert_output --partial "DISCLAIMER"
}

@test "pnpm --help exits 0 and mentions 'Usage: pnpm [command] [flags]'" {
  run pnpm --help
  [ "$status" -eq 0 ]
  assert_output --partial "Usage: pnpm [command] [flags]"
}
