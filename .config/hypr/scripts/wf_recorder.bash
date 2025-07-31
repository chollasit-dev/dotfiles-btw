#!/usr/bin/env bash

CURRENT_DATE=$(date -u +%Y-%m-%d_%H-%M-%S)

if ! command -v wf-recorder &>/dev/null; then
  notify-send "wf-recorder" "wf-recorder not installed, exiting..." &&
    exit 1
fi

if pgrep -x wf-recorder >/dev/null; then
  pkill -INT wf-recorder &&
    notify-send "wf-recorder" "Recording stopped" &&
    exit 1
fi

case "$1" in
"fullscreen")
  notify-send "wf-recorder" "Recording started" &&
    wf-recorder -f "$HOME/Videos/$CURRENT_DATE.mp4" -r 30
  ;;
"selection")
  if ! command -v slurp &>/dev/null; then
    notify-send "wf-recorder" "slurp not installed, aborting..."
  else
    notify-send "wf-recorder" "Recording started" &&
      wf-recorder -g "$(slurp)" -f "$HOME/Videos/$CURRENT_DATE.mp4" -r 30
  fi
  ;;
*)
  notify-send "wf-recorder" "unknown option"
  ;;
esac
