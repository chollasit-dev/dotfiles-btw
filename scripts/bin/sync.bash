#!/usr/bin/env bash

set -eu -o pipefail

# shellcheck source=../shared.bash
source "$(dirname "$(dirname "$0")")/shared.bash"

DIRS=(
  "$HOME/Documents/"
  "$HOME/dotfiles-arch/"
  "$HOME/dotfiles-btw/"
  "$HOME/gnupg"
  "$HOME/shared-configs/"
)

read -p "Should resync symbolic links (recommended for new files)? [y/n] " -r option
case "$option" in
"y" | "Y")
  for dir in "${DIRS[@]}"; do
    if [ -d "$dir" ]; then
      cd "$dir" && git pull origin main --set-upstream
      if [ -f "$dir/.stow-local-ignore" ]; then
        install_symlink_farm
        stow -Rv . --no-folding
      fi
    fi
  done
  ;;

"n" | "N")
  for dir in "${DIRS[@]}"; do
    [ -d "$dir" ] &&
      cd "$dir" &&
      git pull origin main --set-upstream
  done
  ;;

*)
  echo "Invalid option" && exit 1
  ;;
esac

if command -v pass &>/dev/null; then
  pass git pull origin main --set-upstream
fi
