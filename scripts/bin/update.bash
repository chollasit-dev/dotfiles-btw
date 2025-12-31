#!/usr/bin/env bash

set -eu -o pipefail

# shellcheck source=../shared.bash
source "$(dirname "$(dirname "$0")")/shared.bash"

cd "$HOME" || exit

flatpak update -y

if command -v nix &>/dev/null; then
  ARCH_DIRS=("$HOME/dotfiles-btw/nix/" "$HOME/dotfiles-arch/nix/")
  for dir in "${ARCH_DIRS[@]}"; do
    if [ -d "$dir" ]; then
      cd "$dir" || echo "Failed to go to $dir, skipping..." && continue
      nix profile remove nix-1 && nix profile wipe-history && nix profile install
    fi
  done
fi

yay --disable-download-timeout --noconfirm --sudoloop
