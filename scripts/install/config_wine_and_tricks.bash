#!/usr/bin/env bash

set -eu -o pipefail

export WINEPREFIX="$HOME/.lineprefix"

command -v wine &>/dev/null || {
  echo "[Winetricks] Wine not found, skip configuring..." >&2 && exit
}

command -v winetricks &>/dev/null || {
  echo "[Winetricks] Winetricks not found, skip configuring..." >&2 && exit
}

winetricks vcrun2008 vcrun2022 cjkfonts corefonts
