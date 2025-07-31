#!/usr/bin/env bash

set -e

DIR=(
  "$HOME/gnupg"
  "$HOME/shared-configs/"
  "$HOME/dotfiles-arch/"
  "$HOME/dotfiles-btw/"
)

for dir in "${DIR[@]}"; do
  if [ -d "$dir" ]; then
    cd "$dir" && git pull origin main --set-upstream
    if [ -f "$dir/.stow-local-ignore" ]; then
      stow -Rv . --no-folding
    fi
  fi
done

unset -v DIR
