#!/usr/bin/env bash

set -eu -o pipefail

# TODO: Check if Ripgrep exists
{
  waydroid status | rg --case-sensitive "Session" | rg --case-sensitive "RUNNING"
} || {
  echo "[Waydroid] Session not started, skip setting props..." >&2 && exit
}

{
  waydroid session start && {
    waydroid prop set persist.waydroid.width 1920
    waydroid prop set persist.waydroid.height 1080
  }
} || {
  echo "[Waydroid] Failed to set width and height" >&2 && exit
}

echo "[Waydroid] Set props successfully"
