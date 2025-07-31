#!/usr/bin/env bash

dirname="$HOME/Pictures/screenshots/"
filename="$(date +%Y%m%d_%T)"
ext="jpeg"

mkdir -p "$dirname"

case "$1" in
"fullscreen")
  grim -t "$ext" "$dirname$filename.$ext" &&
    grim -t "$ext" - | wl-copy &&
    notify-send "Basic Screenshot" "Capture screenshot, copy to clipboard, and save at\r$dirname successfully"
  ;;
"selection") # specify capture dimension
  screen_dimension="$(slurp -d)"

  grim -g "$screen_dimension" -t "$ext" "$dirname$filename.$ext" &&
    grim -g "$screen_dimension" -t "$ext" - | wl-copy &&
    notify-send "Basic Screenshot" "Capture screenshot, copy to clipboard, and save at\r$dirname successfully"

  unset -v screen_dimension
  ;;
"annotation") # with annotation
  if ! command -v satty &>/dev/null; then
    notify-send "Basic Screenshot" "satty not installed!" &&
      exit 1
  fi

  screen_dimension="$(slurp -d)"
  grim -g "$screen_dimension" -t ppm - | satty -f - --fullscreen -o "${dirname}satty-$filename.$ext" &&
    notify-send "Basic Screenshot" "Capture screenshot with satty successfully"

  unset -v screen_dimension
  ;;
*)
  notify-send "Basic Screenshot" "unknown option"
  ;;
esac

unset -v dirname filename
