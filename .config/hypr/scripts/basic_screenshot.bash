#!/usr/bin/env bash

set -eu -o pipefail

APP_NAME="Basic Screenshot"
CLIPBOARD_NAME="clipse"
DIR="$HOME/Pictures/screenshots/"
EXT="jpeg"
OUTPUT_NAME="$(date +%Y%m%d_%T)"

mkdir -p "$DIR"

check_copy_to_clipboard() {
  if ! command -v clipse &>/dev/null; then
    notify-send "$APP_NAME" "$CLIPBOARD_NAME not installed, aborting..." && exit 1
  fi
}

case "$1" in
"fullscreen")
  grim -t "$EXT" "$DIR$OUTPUT_NAME.$EXT" &&
    grim -t "$EXT" - | clipse -wl-store &&
    notify-send "$APP_NAME" "Capture screenshot, copy to clipboard, and save to\r$DIR successfully"
  ;;

"selection")
  SCREEN_DIMENSION="$(slurp -d)"
  grim -g "$SCREEN_DIMENSION" -t "$EXT" "$DIR$OUTPUT_NAME.$EXT" &&
    grim -g "$SCREEN_DIMENSION" -t "$EXT" - | clipse -wl-store &&
    notify-send "$APP_NAME" "Capture screenshot, copy to clipboard, and save to\r$DIR successfully"
  ;;

"annotation")
  if ! command -v satty &>/dev/null; then
    notify-send "$APP_NAME" "satty not installed, aborting..." &&
      exit 1
  fi
  SCREEN_DIMENSION="$(slurp -d)"
  grim -g "$SCREEN_DIMENSION" -t ppm - | satty -f - -o "${DIR}satty-$OUTPUT_NAME.png" &&
    notify-send "$APP_NAME" "Capture screenshot with satty successfully"
  ;;

*)
  notify-send "$APP_NAME" "Unknown option"
  ;;
esac
