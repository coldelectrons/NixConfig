[![built with nix](https://img.shields.io/static/v1?logo=nixos&logoColor=white&label=&message=Built%20with%20Nix&color=41439a)](https://builtwithnix.org)

# My NixOS configurations

Here's my NixOS/home-manager config files. Requires [Nix flakes](https://nixos.wiki/wiki/Flakes).

Looking for something simpler to start out with flakes? Try [this guy's config repo](https://github.com/Misterio77/nix-starter-config).

## Table of Contents
- [Highlights](#highlights)
- [References](#references)
- [Structure](#structure)
- [About the installation](#about-the-installation)
- [How to bootstrap](#how-to-bootstrap)
- [Secrets](#secrets)

## Highlights
- Multiple **NixOS configurations**, including **desktop**, **laptop**, **server**
- **Opt-in persistence** through impermanence + blank snapshotting
- **Encrypted** single **BTRFS** partition
- Fully **declarative** **self-hosted** stuff
- Deployment **secrets** using **sops-nix**
- **Mesh networked** hosts with **tailscale** and **headscale**
- Flexible **Home Manager** Configs through **feature flags**
- Extensively configured wayland environments (**sway** and **hyprland**) and editor (**neovim**)
- **Declarative** **themes** and **wallpapers** with **nix-colors**
- **Hydra CI/CD server and binary cache** that uses the **desktops as remote builders**

## References
- [NovaViper's nix-config](https://github.com/NovaViper/nixconfig) - Makes up a large majority of the entire config, primary template used when making the config
- [Mistero77's nix-config](https://github.com/Misterio77/nix-config)
- [Hlissner's dotfiles](https://github.com/hlissner/dotfiles) - Security hardening configs
- [Baitinq's nixos-config](https://github.com/Baitinq/nixos-config) - Partitioning scripts
- [Theopn's](https://github.com/theopn/dotfiles/tree/main) and (yutkat's dotfiles)[https://github.com/yutkat/dotfiles/tree/main] - Wezterm settings
- [Getchoo's flake](https://github.com/getchoo/flake) - Nvidia settings

## Structure

- `flake.nix`: Entrypoint for hosts and home configurations. Also exposes a
  devshell for boostrapping (`nix develop` or `nix-shell`).
- `lib`: A few lib functions for making my flake cleaner
- `hosts`: NixOS Configurations, accessible via `nixos-rebuild --flake .#hostname`.
  - `common`: Shared configurations consumed by the machine-specific ones.
    - `global`: Configurations that are globally applied to all my machines.
    - `optional`: Opt-in configurations/feature flags, my machines can use.
    - `users`: Configurations for each system on the machines
  - `hades`: Primary PC - 128GB RAM, Ryzen 5900X, Radeon RX 7900 XT | KDE Plasma 6
  - `stickers`: HP laptop - 12GB RAM, Intel i5 1335U | Prime Nvidia 940M + Intel i915 | KDE Plasma 6
  - `heavy`: Custom - 64GB ECC RAM, Ryzen 5 7600 APU | headless
  - `live-image`: ISO configuration | Nvidia drivers included | KDE Plasma 6
- `home`: My Home-manager configuration, accessible via `home-manager --flake .#user@hostname`
    - Each directory here is a "feature" each hm configuration can toggle, thus
      customizing my setup for each machine (be it a server, desktop, laptop,
      anything really).
- `modules`: A few actual modules (with options)
- `overlay`: Patches and version overrides for some packages. Accessible via
  `nix build`.
- `pkgs`: My custom packages. Also accessible via `nix build`. You can compose
  these into your own configuration by using my flake's overlay, or consume them through NUR.
- `templates`: A couple project templates for different languages. Accessible
  via `nix init`.


## About the installation

All my computers use a single btrfs (encrypted on all except headless systems)
partition, with subvolumes for `/nix`, a `/persist` directory (which I opt in
using `impermanence`), swap file, and a root subvolume (cleared on every boot).

Home-manager is used in a standalone way, and because of opt-in persistence is
activated on every boot with `loginShellInit`.


## How to bootstrap

All you need is nix (any version). Run:
```
nix-shell
```

If you already have nix 2.4+, git, and have already enabled `flakes` and
`nix-command`, you can also use the non-legacy command:
```
nix develop
```

`nixos-rebuild --flake .#host` To build system configurations

`home-manager --flake .#user@host` To build user configurations

`nix build` (or shell or run) To build and use packages

`sops` To manage secrets


## Secrets

For deployment secrets (such as user passwords and server service secrets), I'm
using the awesome [`sops-nix`](https://github.com/Mic92/sops-nix). All secrets
are encrypted with my personal PGP key (stored on a YubiKey), as well as the
relevant systems's SSH host keys.

On my desktop and laptop, I use `pass` for managing passwords, which are
encrypted using (you bet) my PGP key. This same key is also used for mail
signing, as well as for SSH'ing around.

