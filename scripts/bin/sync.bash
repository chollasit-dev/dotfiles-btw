#!/usr/bin/env bash

set -eu -o pipefail

# shellcheck source=../shared.bash
source "$(dirname "$(dirname "$0")")/shared.bash"

fetch_remote() {
  {
    [ -d "$1" ] &&
      cd "$1" &&
      git pull origin main --set-upstream &&
      [ ! -f "./.gitmodules" ] || {
      echo "[sync.bash] Submodule repository found, try updating..." &&
        git submodule update --remote ||
        echo "[sync.bash] Failed to update submodule from remote at parent $1"
    }
  } || {
    echo "[sync.bash] Failed to fetch update from remote for $1" >&2 &&
      return 1
  }
}

DIRS=(
  "$HOME/Documents/"
  "$HOME/dotfiles-arch/"
  "$HOME/dotfiles-btw/"
  "$HOME/gnupg"
  "$HOME/shared-configs/"
)

read -p "Should resync symlinks (recommended for new files)? [y/n] " -r resync_symlink_opts
case "$resync_symlink_opts" in
"y" | "Y")
  for dir in "${DIRS[@]}"; do
    fetch_remote "$dir" || continue
    {
      command -v stow &>/dev/null || {
        echo "[sync.bash] GNU Stow not found, skip resyncing symlinks..." >&2 && continue
      }
      [ -f "$dir/.stow-local-ignore" ] || {
        echo "[sync.bash] Stow ignore file not found" >&2 &&
          echo "[sync.bash] This may not meant to be stowed, skip resyncing symlinks at $dir" >&2 &&
          continue
      }
      if [ "$(git status --short | wc -l)" != 0 ]; then
        git status --short &&
          echo "[sync.bash] Working directory $dir is dirty" &&
          read -p "Import existing files into stow package? [y/n] " -r stow_adopt_opts
        case "$stow_adopt_opts" in
        "y" | "Y") stow . --no-folding --restow --verbose --adopt ;;
        "n" | "N") stow . --no-folding --restow --verbose ;;
        esac
      fi
    } || echo "[sync.bash] Failed to restow symlinks at $dir" >&2
  done
  ;;

"n" | "N")
  for dir in "${DIRS[@]}"; do
    fetch_remote "$dir" || continue
  done
  ;;

*)
  echo "[sync.bash] Invalid option" >&2 && exit 1
  ;;
esac

if command -v pass &>/dev/null; then
  pass git pull origin main --set-upstream
fi
