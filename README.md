# My Dotfiles BTW

## Manual Getting Started

This is where something needed to be done manually when first get the machine
run after install Linux. (at least at the time I wrote)

### Still needed to do

#### Bluetooth

Enable bluetooth service if have not done yet.

```sh
systemctl enable bluetooth.service
```

#### Oh My Zsh

Install manually by following the guide on
[GitHub](https://github.com/ohmyzsh/ohmyzsh).

#### [Steam](https://wiki.archlinux.org/title/Steam)

Enable the `multilib` repository in `/etc/pacman.conf` before installing steam
with pacman.

```conf
# Uncomment here
[multilib]
Include = /etc/pacman.d/mirrorlist
```

### Configurations/Presets already exist

#### Kitty

The configuration is based on Catppuccin Mocha theme. If there is no existing
theme in the config file, run the following will give us a good starting point.

```sh
kitty +kitten themes --reload-in=all Catppuccin-Mocha
```

#### Cursor

Include the commands on start hyprland at `autostart.conf`

Also worth checking as well if encountered problems.

- [Hyprland Cursor](https://github.com/hyprwm/hyprcursor)
- [GitHub Issues](https://github.com/hyprwm/Hyprland/issues/6320##issuecomment-2243109637)

#### GTK Theme

For GTK 3+, configuration can be done with `gsettings`. (already set at
`autostart.conf`)

For GTK 2, load a theme per program with

```.gtkrc-2.0
GTK2_RC_FILES=/usr/share/themes/Raleigh/gtk-2.0/gtkrc gimp
```

It is also worth checking

- [Arch Wiki](https://wiki.archlinux.org/title/GTK)
- [GTK configuration example](https://wiki.archlinux.org/title/GTK#Examples)
