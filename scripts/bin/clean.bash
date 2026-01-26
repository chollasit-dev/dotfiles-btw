#!/usr/bin/env bash

# shellcheck source=../shared.bash
source "$(dirname "$(dirname "$0")")/shared.bash"

install_aur_package_manager &&
  yay -Scc --noconfirm &&
  yay -Ycc --noconfirm

rm "$HOME/.zsh_history" "$HOME/.bash_history" || :
rm -rf "$HOME/.local/share/Trash/*" || :

clipse -clear-all
