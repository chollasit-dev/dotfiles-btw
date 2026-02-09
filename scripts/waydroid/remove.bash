#!/usr/bin/env bash

# https://docs.waydro.id/usage/install-on-desktops#reinstalling-waydroid

waydroid session stop
sudo waydroid container stop

yay -Rns waydroid --noconfirm

# Remove Waydroid data
sudo rm -rvf /var/lib/waydroid
sudo rm -rvf /home/.waydroid
sudo rm -rvf ~/waydroid ~/.share/waydroid ~/.local/share/waydroid ~/.local/share/applications/*waydroid*.desktop

# Remove waydroid_script
rm -rvf ~/waydroid_script/
