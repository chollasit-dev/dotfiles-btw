#!/usr/bin/env bash

# shellcheck source=../shared.bash
source "$(dirname "$(dirname "$0")")/shared.bash"

install_aur_package_manager &&
  yay -Scc --noconfirm &&
  yay -Ycc --noconfirm

command -v clipse &>/dev/null && clipse -clear-all
