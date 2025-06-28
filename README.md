# My Dotfiles BTW

## Manual Getting Started Part

This is where something needed to be done manually, at least at the time I
wrote.

### Bluetooth

Install from extra packages:

- Install `bluez` and `bluez-utils` as a core Bluetooth functionality.
- Install [bluetui](https://github.com/pythops/bluetui) for ease of
  interactivity via TUI.

### Terminal

#### Zsh

Install manually by following the guide on
[GitHub](https://github.com/ohmyzsh/ohmyzsh).

#### Kitty

The configuration is based on Catppuccin Mocha theme.

```sh
kitty +kitten themes --reload-in=all Catppuccin-Mocha
```

### [Steam](https://wiki.archlinux.org/title/Steam)

Enable the `multilib` repository in `/etc/pacman.conf` before installing steam
with pacman.

```conf
# Uncomment here
[multilib]
Include = /etc/pacman.d/mirrorlist
```

### Customization

#### Cursor

Include the commands on start hyprland at `autostart.conf` by following

```autostart.conf
exec-once =
exec-once =
```

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

It's also worth checking

- [Arch Wiki](https://wiki.archlinux.org/title/GTK)
- [GTK configuration example](https://wiki.archlinux.org/title/GTK#Examples)
