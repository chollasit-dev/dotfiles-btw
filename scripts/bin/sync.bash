#!/usr/bin/env bash

set -eu -o pipefail

DIR=(
  "$HOME/Documents/"
  "$HOME/dotfiles-arch/"
  "$HOME/dotfiles-btw/"
  "$HOME/gnupg"
  "$HOME/shared-configs/"
)

read -p "Do you wanna resync symbolic links (recommended for new files)? [y/n] " -r option
case "$option" in
"y" | "Y")
  for dir in "${DIR[@]}"; do
    if [ -d "$dir" ]; then
      cd "$dir" && git pull origin main --set-upstream
      if [ -f "$dir/.stow-local-ignore" ]; then
        stow -Rv . --no-folding
      fi
    fi
  done
  if command -v pass &>/dev/null; then
    pass git pull origin main --set-upstream
  fi
  ;;
"n" | "N")
  for dir in "${DIR[@]}"; do
    if [ -d "$dir" ]; then
      cd "$dir" && git pull origin main --set-upstream
    fi
  done
  if command -v pass &>/dev/null; then
    pass git pull origin main --set-upstream
  fi
  ;;
*)
  echo "Invalid option"
  ;;
esac

unset -v DIR
