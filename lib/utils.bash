#!/usr/bin/env bash

set -euo pipefail

TOOL_NAME="asdf-difftastic-with-elixir-sigils"
TOOL_TEST="difft"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

ensure_dependencies() {
  test -x "$(which docker)" || fail "Requires docker for building difftastic from source"
}

list_all_versions() {
  echo "0.0.1"
}

install_version() {
  local install_type="$1"
  local install_path="${2%/bin}/bin"
  local build_path="$(mktemp -d -t difftastic-djonn.XXXXXXXXXX)"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  ensure_dependencies

  (
    mkdir -p "$install_path"
    mkdir -p "$build_path"

    clone_repo "$build_path"
    build_with_docker "$build_path" "$install_path"
  
    echo "##################  tool test:"
    echo "$install_path/$TOOL_TEST"
    test -x "$install_path/$TOOL_TEST" || fail "Expected $install_path/$TOOL_TEST to be executable."

    echo "$TOOL_NAME installation was successful!"
  ) || (
    rm -rf "$install_path"
    echo "$install_path"
    fail "An error occurred while installing $TOOL_NAME."
  )
}

clone_repo() {
  local build_path=$1
  git clone --depth 1 --branch "improve-elixir-diffing" --single-branch git@github.com:crbelaus/difftastic.git "$build_path"
}

build_with_docker() {
  local build_path=$1
  local install_path=$2

  docker run --rm --volume="$build_path:/build" --workdir="/build" rust:1.66 cargo build --release --bin="difft"

  echo "##################  copy artifact:"
  echo "$build_path/target/release/difft"
  echo "$install_path/difft"
  cp "$build_path/target/release/difft" "$install_path/difft"
}
