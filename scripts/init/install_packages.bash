#!/usr/bin/env bash

set -eu -o pipefail

# shellcheck source=../shared.bash
source "$(dirname "$(dirname "$0")")/shared.bash"

install_core_pacakges() {
  local FONTS=(
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    ttf-firacode-nerd
    ttf-noto-nerd
  )

  local PRIMITIVES=(
    bluetui
    bluez
    bluez-utils
    brightnessctl
    less
    unzip
    xdg-desktop-portal-gtk
    zip
  )

  local UTILITIES=(
    bat
    bc
    btop
    carapace
    hyprpicker
    lsd
    pass
    satty
    stow
    tldr
    udiskie # Auto mount/unmount handler
    wf-recorder
    wl-clipboard
  )

  local TUI_FILE_MANAGER_WITH_DEPS=(
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

  local BROWSERS=(firefox)

  local MEDIA=(
    mpv
    obs-studio
    spotify-launcher
  )

  # NOTE: `/usr/share/{icons,themes}`
  CUSTOMIZATION=(
    hyprlock
    starship
    swaync
    waybar
  )

  DEV_NULL=(
    docker
    docker-buildx
    docker-compose
    ghc
    github-cli
    go
    neovim
    podman
    podman-compose
    rustup # Why...
    sqlc
    tmux
    uv
    zsh-syntax-highlighting
  )

  sudo pacman -Sy \
    "${FONTS[@]}" \
    "${PRIMITIVES[@]}" \
    "${UTILITIES[@]}" \
    "${TUI_FILE_MANAGER_WITH_DEPS[@]}" \
    "${BROWSERS[@]}" \
    "${MEDIA[@]}" \
    "${CUSTOMIZATION[@]}" \
    "${DEV_NULL[@]}" \
    --noconfirm
}

uninstall_preinstalled() {
  local PRE_INSTALLED=(
    dunst
    wofi
  )
  for item in "${PRE_INSTALLED[@]}"; do
    command -v "$item" &>/dev/null && yay -Rns "$item" --noconfirm
  done
}

install_multilib_packages() {
  # NOTE: Must enable multilib at `/etc/pacman.conf`
  command -v rg || echo "ripgrep not installed, aborting..." && exit 1
  if ! rg "^\[multilib\]$" /etc/pacman.conf &>/dev/null; then
    sudo tee -a /etc/pacman.conf <<EOF
[multilib]
Include = /etc/pacman.d/mirrorlist
EOF
    sudo pacman -Sy steam --noconfirm
  fi
}

install_aur_packages() {
  local UTILITIES=(
    bemoji
    clipse
    fuzzel
    wev
    wlrctl # wlroot utilities: move cursor via keyboard, etc.
  )

  local CUSTOMIZATION=(
    arc-gtk-theme
    catppuccin-cursors-mocha
    catppuccin-gtk-theme-mocha
  )

  local BROWSERS=(
    brave-bin
    google-chrome
  )

  local SOCIALS=(
    discord
  )

  local PRODUCTIVITIES=(
    onlyoffice-bin
    teamviewer
    zoom
  )

  local DEV_NULL=(
    beekeeper-studio-bin
    fnm-bin
    ghcup
    goose
    postman-bin
    tmux-plugin-manager
    yaak-bin
  )

  yay -S \
    "${UTILITIES[@]}" \
    "${CUSTOMIZATION[@]}" \
    "${BROWSERS[@]}" \
    "${SOCIALS[@]}" \
    "${PRODUCTIVITIES[@]}" \
    "${DEV_NULL[@]}" \
    --disable-download-timeout --noconfirm --sudoloop
}

install_flatpak_with_apps() {
  yay -S flatpak --disable-download-timeout --noconfirm --sudoloop &&
    command -v flatpak &&
    flatpak install -y flathub com.usebottles.bottles &&
    flatpak install -y flathub org.vinegarhq.Sober &&
    flatpak install -y flathub org.prismlauncher.PrismLauncher
}

main() {
  install_core_pacakges && uninstall_preinstalled
  install_aur_package_manager && install_aur_packages
  install_flatpak_with_apps
  command -v bemoji &&
    # NOTE: Should be last due to installing additional emoji cause unexpected popup
    bemoji -D all
}
main
