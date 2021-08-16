#!/usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

echo "*** Initialize submodule... ***"
git submodule init
git submodule update --remote

cd "$DIR"/qmk || return
nix-shell
