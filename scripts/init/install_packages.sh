#!/usr/bin/env bash

##############
### Pacman ###
##############

TYPOGRAPHY=(
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
  ttf-firacode-nerd
  ttf-noto-nerd
)

LOW_LEVEL=(
  anacron
  bat
  bluetui
  carapace
  bluez
  bluez-utils
  less
  lsd
  tldr
  tree
  unzip
  wf-recorder
  wl-clipboard
  zip
)

ADDITIONAL_LOW_LEVEL=(
  stow
  xdg-desktop-portal-gtk

  # Yazi and dependencies
  7zip
  fd
  ffmpeg
  fzf
  imagemagick
  jq
  poppler
  resvg
  ripgrep
  yazi
  zoxide
)

UTILITIES=(
  obs-studio
  udiskie # auto mount/unmount handler
  vlc
)

PRODUCTIVITY=(
  brave-bin
  firefox
  onlyoffice
  spotify-launcher
  taskwarrior-tui
)

CUSTOMIZATION=(
)

DEV_NULL=(
  fnm
  github-cli
  google-chrome
  zsh-syntax-highlighting
)

# NOTE: enable multilib at `/etc/pacman.conf` first.
MULTILIB=(
  steam
)

for item in "${SETTINGS[@]}"; do
  sudo pacman -Sy --noconfirm "$item"
done

for item in "${TYPOGRAPHY[@]}"; do
  sudo pacman -Sy --noconfirm "$item"
done

for item in "${LOW_LEVEL[@]}"; do
  sudo pacman -Sy --noconfirm "$item"
done

for item in "${ADDITIONAL_LOW_LEVEL[@]}"; do
  sudo pacman -Sy --noconfirm "$item"
done

for item in "${UTILITIES[@]}"; do
  sudo pacman -Sy --noconfirm "$item"
done

for item in "${PRODUCTIVITY[@]}"; do
  sudo pacman -Sy --noconfirm "$item"
done

for item in "${CUSTOMIZATION[@]}"; do
  sudo pacman -Sy --noconfirm "$item"
done

for item in "${DEV_NULL[@]}"; do
  sudo pacman -Sy --noconfirm "$item"
done

for item in "${MULTILIB[@]}"; do
  sudo pacman -Sy --noconfirm "$item"
done

###########
### Yay ###
###########

if ! command -v yay &>/dev/null; then
  echo "yay not found, install yay first" && exit 1
fi

AUR=(
  discord
  teamviewer
  wev # Debug Wayland events
  xdg-desktop-portal-termfilechooser-git
  zoom
)

for item in "${AUR[@]}"; do
  yay -S --noconfirm "$item"
done

###############
### Cleanup ###
###############

unset -v ADDITIONAL_LOW_LEVEL AUR CUSTOMIZATION DEV_NULL LOW_LEVEL PRODUCTIVITY SETTINGS TYPOGRAPHY UTILITIES
