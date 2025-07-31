#!/usr/bin/env bash

set -e

DIR=(
  "$HOME/Documents/"
  "$HOME/dotfiles-arch/"
  "$HOME/dotfiles-btw/"
  "$HOME/gnupg"
  "$HOME/shared-configs/"
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
