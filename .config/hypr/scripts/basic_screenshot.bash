#!/usr/bin/env bash

basedir="$HOME/Pictures/screenshots/"
filename="$(date +%Y%m%d_%T).jpg"
extension="jpg"

mkdir -p "$basedir"

case "$1" in
1) # fastest default fullscreen
  grim -t jpeg "$basedir$filename" &&
    grim -t jpeg - | wl-copy &&
    notify-send "Basic Screenshot" "Capture screenshot, copy to clipboard, and save at\r$basedir successfully"
  ;;
2) # specify capture dimension
  screen_dimension="$(slurp -d)"

  grim -g "$screen_dimension" -t jpeg "$basedir$filename.$extension" &&
    grim -g "$screen_dimension" -t jpeg - | wl-copy &&
    notify-send "Basic Screenshot" "Capture screenshot, copy to clipboard, and save at\r$basedir successfully"

  unset -v screen_dimension
  ;;
3) # with annotation
  if ! command -v satty &>/dev/null; then
    notify-send "Basic Screenshot" "satty not installed!" &&
      exit 1
  fi

  screen_dimension="$(slurp -d)"
  grim -g "$screen_dimension" -t ppm - | satty -f - --fullscreen -o "${basedir}satty-$filename.$extension" &&
    notify-send "Basic Screenshot" "Capture screenshot with satty successfully"

  unset -v screen_dimension
  ;;
esac

unset -v basedir filename
