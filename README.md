# My Dotfiles BTW

## Manual Getting Started

This is where something needed to be done manually when first get the machine
run after install Linux. (at least at the time I wrote)

### systemd-oomd

```sh
sudo systemctl enable --now systemd-oomd
```

### Bluetooth

```sh
systemctl enable bluetooth.service
```

### Oh My Zsh

Install manually by following the guide on
[GitHub](https://github.com/ohmyzsh/ohmyzsh).

### [Steam](https://wiki.archlinux.org/title/Steam)

Enable the `multilib` repository in `/etc/pacman.conf` before installing steam
with pacman.

```conf
# Uncomment here
[multilib]
Include = /etc/pacman.d/mirrorlist
```

## Configurations/Presets already exist

### Kitty

```sh
kitty +kitten themes --reload-in=all Catppuccin-Mocha
```

### Cursor

Useful resources if face any issue

- [Hyprland Cursor](https://github.com/hyprwm/hyprcursor)
- [GitHub Issues](https://github.com/hyprwm/Hyprland/issues/6320##issuecomment-2243109637)

### GTK Theme

GTK 3+: configure with `gsettings`. (see `autostart.conf`)

GTK 2:

```.gtkrc-2.0
GTK2_RC_FILES=/usr/share/themes/Raleigh/gtk-2.0/gtkrc gimp
```

Additional resources

- [Arch Wiki](https://wiki.archlinux.org/title/GTK)
- [GTK configuration example](https://wiki.archlinux.org/title/GTK#Examples)
