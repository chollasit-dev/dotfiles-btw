#!/usr/bin/env bash

cd "$HOME" || exit

# Go
read -p "Should clean Go cache? [y/n] " -r option
if [ "$option" = "y" ] || [ "$option" = "Y" ]; then
  go clean -cache -modcache
fi

# Node.js
"$HOME/shared-configs/scripts/update/update_fnm.zsh"

command -v yarn &>/dev/null && yarn cache clean --all
command -v pnpm &>/dev/null && pnpm cache delete
corepack cache clean && corepack install -g pnpm@latest && corepack enable

pnpm up -i && pnpm up -iL
rm pnpm-lock.yaml yarn.lock package-lock.json &>/dev/null
pnpm up -gL
pnpm approve-builds
pnpm approve-builds -g

# Flatpak
flatpak update

# Nix
if [ -d "$HOME/dotfiles-btw/nix/" ]; then
  cd "$HOME/dotfiles-btw/nix/" || return
  nix profile remove nix-1 && nix profile wipe-history && nix profile install
elif [ -d "$HOME/dotfiles-arch/nix/" ]; then
  cd "$HOME/dotfiles-arch/nix/" || return
  nix profile remove nix-1 && nix profile wipe-history && nix profile install
fi

# Arch
yay --noconfirm --sudoloop --disable-download-timeout
yay -Scc --noconfirm
yay -Ycc --noconfirm
