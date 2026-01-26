#!/usr/bin/env bash

set -eu -o pipefail

# shellcheck source=../shared.bash
source "$(dirname "$(dirname "$0")")/shared.bash"

cd "$HOME"

flatpak update -y

yay --disable-download-timeout --noconfirm --sudoloop
