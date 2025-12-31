# Reminder

There are some homemade scripts for specific setups. These can be found at

- `~/dotfiles-arch/scripts/init/`
- `~/shared-configs/scripts/init/`

Here are still needed to run first time setting up machine. But after that,
these will use for setup to run periodically.

- `~/shared-configs/scripts/update/`

## TODOs

Here is a quick reminder for TODOs that should be done at the minimum for ease
of use.

> [!NOTE]
>
> Install Oh my Zsh first! It will definitely help ease of setting the machine
> up.

### Essential

- [ ] Run `./shared-configs/init/add_yazi_theme.bash`
- [ ] Setup single-user Nix package manager
- [ ] Run `./shared-configs/scripts/update/update_fnm.zsh`
- [ ] Create symlink at `/.node-version`
- [ ] Run `./shared-configs/init/install_npm_packages.bash`
- [ ] Set up password-store

### Devtools

- [ ] Yaak: configure theme and interface settings
