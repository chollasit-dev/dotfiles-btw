install_aur_package_manager() {
  # https://github.com/Jguer/yay#binary
  if ! command -v yay &>/dev/null; then
    cd "$HOME" || echo "Failed to go to $HOME, aborting..." && exit 1
    sudo pacman -S --needed git base-devel &&
      git clone https://aur.archlinux.org/yay-bin.git &&
      cd yay-bin &&
      makepkg -si &&

      # Generate a dev pkg DB for *-git packages that were installed without yay
      # NOTE: Should only be run once.
      yay -Y --gendb &&

      # Check for development package updates
      yay -Syu --devel &&
      # Make dev pkg updates permanently enabled (yay and yay -Syu will always check dev pkgs)
      yay -Y --devel --save
  fi
}

install_symlink_farm() {
  if ! command -v stow &>/dev/null; then
    install_aur_package_manager &&
      yay -S stow --disable-download-timeout --noconfirm --sudoloop
  fi
}
