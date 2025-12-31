#!/usr/bin/env bash

set -eu -o pipefail

APP="wf-recorder"
CURRENT_DATE=$(date -u +%Y-%m-%d_%H-%M-%S)
OUTPUT_PATH="$HOME/Videos/$CURRENT_DATE.mp4"

if ! command -v wf-recorder &>/dev/null; then
  notify-send "$APP" "$APP not installed, aborting..." &&
    exit 1
fi

if pgrep -x "$APP" >/dev/null; then
  pkill -INT "$APP" &&
    notify-send "$APP" "Recording stopped" &&
    exit 1
fi

mkdir -p "$(dirname "$OUTPUT_PATH")"

case "$1" in
"fullscreen")
  notify-send "$APP" "Recording started" &&
    wf-recorder -f "$OUTPUT_PATH" -r 30
  ;;
"selection")
  if ! command -v slurp &>/dev/null; then
    notify-send "$APP" "slurp not installed, aborting..."
  else
    notify-send "$APP" "Recording started" &&
      wf-recorder -g "$(slurp)" -f "$OUTPUT_PATH" -r 30
  fi
  ;;
*)
  notify-send "$APP" "Unknown option"
  ;;
esac
