#!/usr/bin/env bash

set -eu -o pipefail

# shellcheck source=../shared.bash
source "$(dirname "$(dirname "$0")")/shared.bash"

cd "$HOME"

flatpak update -y || echo "[Flatpak] Failed to upgrade packages" >&2

yay --disable-download-timeout --noconfirm --sudoloop ||
  echo "[Yay] Failed to upgrade packages" >&2
