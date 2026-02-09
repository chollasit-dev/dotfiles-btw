#!/usr/bin/env bash

set -eu -o pipefail

WAYDROID_SCRIPT_DIR="$HOME/waydroid_script"

command -v python3 &>/dev/null || {
  echo "[Waydroid] python3 not found, skip installing stuff..." >&2 && exit
}

[ -d "$WAYDROID_SCRIPT_DIR" ] || {
  git clone https://github.com/casualsnek/waydroid_script "$WAYDROID_SCRIPT_DIR" || {
    echo "[Waydroid] Failed to clone script to $WAYDROID_SCRIPT_DIR, skip installing stuff..." >&2 &&
      exit
  }
}

cd "$WAYDROID_SCRIPT_DIR"
git pull

{
  python3 -m venv venv &&
    venv/bin/pip install -r requirements.txt
} || {
  echo "[Waydroid] Failed to install dependencies, skip installing stuff..." >&2 &&
    exit
}

[ "$(waydroid status)" = "Waydroid is not initialized, run \"waydroid init\"" ] && {
  echo "[Waydroid] not yet initialized, initializing..."
  sudo waydroid init || {
    echo "[Waydroid] Failed to initialize, skip installing stuff..." >&2 &&
      exit
  }
}

# TODO: CPU switch-case
# Intel: libhoudini
# AMD: libndk
{
  sudo venv/bin/python3 main.py
  # sudo venv/bin/python3 main.py install libhoudini
  # sudo venv/bin/python3 main.py install smartdock
  # sudo venv/bin/python3 main.py install microg
} || {
  echo "[Waydroid] Failed to install stuff, skip to apply hacks..." >&2 && exit
}
echo "[Waydroid] Install stuff successfully"

# NOTE: Not work
# sudo venv/bin/python3 main.py hack nodataperm || {
#   echo "[Waydroid] Failed to apply hacks" >&2 && exit
# }
# echo "[Waydroid] Apply hacks successfully"
