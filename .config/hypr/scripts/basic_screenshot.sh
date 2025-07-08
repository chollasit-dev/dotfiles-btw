#!/usr/bin/env bash

basedir="$HOME/Pictures/screenshots/"
filename="$(date +%Y-%m-%d_%T).jpg"

mkdir -p "$basedir"

case "$1" in
1)
  grim -t jpeg "$basedir$filename" &&
    grim -t jpeg - | wl-copy &&
    notify-send "Basic Screenshot" "Capture screenshot, copy to clipboard, and save at\r$basedir successfully"
  ;;
2)
  screen_dimension="$(slurp -d)"

  grim -g "$screen_dimension" -t jpeg "$basedir$filename" &&
    grim -g "$screen_dimension" -t jpeg - | wl-copy &&
    notify-send "Basic Screenshot" "Capture screenshot, copy to clipboard, and save at\r$basedir successfully"

  unset -v screen_dimension
  ;;
esac

unset -v basedir filename
