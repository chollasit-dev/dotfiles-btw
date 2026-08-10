#!/usr/bin/env bash

set -eu -o pipefail

# shellcheck source=../shared.bash
source "$(dirname "$(dirname "$0")")/shared.bash"

# Git Repository
goto_directory() {
  cd "$1" || {
    echo "[sync.bash] Failed to change CWD to $1, skip resyncing for that directory..." >&2 &&
      return 1
  }
}

pull_remote() {
  git pull origin main --set-upstream || {
    echo "[sync.bash] Failed to pull update from remote for $1" >&2 &&
      return 1
  }
  {
    [ ! -f "./.gitmodules" ] || {
      echo "[sync.bash] Submodule repository found, try updating..." &&
        git submodule update --remote ||
        echo "[sync.bash] Failed to update submodule from remote at parent $1" >&2
    }
  }
}

DIRS=(
  "$HOME/Documents/"
  "$HOME/dotfiles-arch/"
  "$HOME/gnupg"
  "$HOME/shared-configs/"
)

read -p "Should resync symlinks (recommended for new files)? [y/n] " -r resync_symlink_opts
case "$resync_symlink_opts" in
"y" | "Y")
  for dir in "${DIRS[@]}"; do
    goto_directory "$dir" || continue
    pull_remote "$dir" || continue
    {
      command -v mise &>/dev/null || {
        echo "[sync.bash] Mise not found, skip resyncing symlinks..." >&2 && continue
      }

      [ -f "$dir/mise.toml" ] || {
        echo "[sync.bash] mise.toml not found" >&2 &&
          echo "[sync.bash] This directory dotfiles may not meant to be managed, skip resyncing symlinks at $dir" >&2 &&
          continue
      }

      mise dotfiles apply

    } || echo "[sync.bash] Failed to resync symlinks at $dir" >&2
  done
  ;;

"n" | "N")
  for dir in "${DIRS[@]}"; do
    goto_directory "$dir" || continue
    pull_remote "$dir" || continue
  done
  ;;

*)
  echo "[sync.bash] Invalid option" >&2 && exit 1
  ;;
esac

# Pass
if command -v pass &>/dev/null; then
  pass git pull origin main --set-upstream || {
    echo "[sync.bash.pass] Failed to pull update from remote" >&2 && exit 1
  }
  [ "$(pass git diff main..origin/main --compact-summary | wc -l)" -gt 0 ] &&
    echo "[sync.bash.pass] Local changes found, do not forget to push to remote"
fi

# Desktop Entry
command -v update-desktop-database &>/dev/null || {
  echo "[sync.bash.desktop] update-desktop-database not found, skip updating desktop entry cache..." >&2 &&
    exit 1
}

update-desktop-database "$HOME/.local/share/applications/" || {
  echo "[sync.bash.desktop] Failed to update desktop entry cache" >&2 &&
    exit 1
}
