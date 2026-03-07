#!/usr/bin/env bash

set -eu -o pipefail

export WINEPREFIX="$HOME/.lineprefix"

command -v wine &>/dev/null || {
  echo "[Winetricks] Wine not found, skip configuring..." >&2 && exit
}

command -v winetricks &>/dev/null || {
  echo "[Winetricks] Winetricks not found, skip configuring..." >&2 && exit
}

# NOTE: Wayland still does not work well
winetricks vcrun2008 vcrun2022 cjkfonts allfonts fontsmooth=rgb graphics=x11 || {
  echo "[Winetricks] Failed to runtime-compatibility dependencies" >&2 && exit
}

echo "[Winetricks] Install runtime-compatibility dependencies successfully" >&2 && exit
