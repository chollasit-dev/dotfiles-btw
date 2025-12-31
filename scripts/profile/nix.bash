#!/usr/bin/env bash

# Added by Nix installer
# shellcheck source=/dev/null
NIX_PROFILE="$HOME/.nix-profile/etc/profile.d/nix.sh"
[ -e "$NIX_PROFILE" ] && source "$NIX_PROFILE"
