#!/usr/bin/env bash

set -eu -o pipefail

[ -d "$HOME/dotfiles-arch" ] && DOTFILES_DIR="$HOME/dotfiles-arch"
[ -d "$HOME/dotfiles-btw" ] && DOTFILES_DIR="$HOME/dotfiles-btw"

TABLEPLUS_SETTINGS_DIR=".tableplus/settings"

[ -f "$HOME/$TABLEPLUS_SETTINGS_DIR/settings.json" ] &&
  echo "[TablePlus] settings.json already exists" >&2 && exit

mkdir -p "$HOME/$TABLEPLUS_SETTINGS_DIR"

cp "$DOTFILES_DIR/$TABLEPLUS_SETTINGS_DIR/settings.json" "$HOME/$TABLEPLUS_SETTINGS_DIR/settings.json" || {
  echo "[TablePlus] Failed to copy settings.json to configuration directory" >&2 && exit
}

echo "[TablePlus] Copy settings.json to $TABLEPLUS_SETTINGS_DIR successfully"
