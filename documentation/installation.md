## About the Installation
The people from whom I have <*ahem*> borrowed most of this configuration has particular ideas in mind.
I, however, am a lazy slag who is too old and tired to fight with computers all day. I'll use the NixOS installer whereever possible, and only change something when the defaults are insane or stupid, or in rare instances where **I** have a particular idea in mind.

## The Bootstrap Process
- Install NixOS as per normal, changing it as needed if you are doing something special.
- Boot that system.
- On that system, open a terminal and `git clone` your fork of this repo, and enter that folder
- Run `nix-shell` or `nix develop` to enter environment with all necessary packages to build the config properly
- begin editing to add your new host
  - create a new profiles in the `hosts` subdir and/or the `home` subdir
  - copy `/etc/nixos/hardware-configuration.nix` to that profile
  - Make sure all the necessary keys for that host and user(s) are generated
    - The private keys for sops in `~/.config/sops/age/keys.txt`
    - host ssh keys
    - user ssh keys
  - edit `.sops.yaml`, copying from the example if needed
    - add the needed **public** keys
    - add the creation rules for the host and users
  - edit the various `*/secrets.yaml` of the host and users to reflect this system
- Once you've made all your changes *and* built them, commit them back to your fork.
- Home-manager is configured in [standalone mode](https://nix-community.github.io/home-manager/index.html#id-1.2), so when NixOS is rebuilt Home-manager would then also need to be rebuilt manually with `home-manager switch --flake .#user@host`.

## First-time NixOS Install
1. Download a NixOS ISO or create custom one with nix experimental features and Nvidia drivers installed by following
  the instructions over under the (Tips)[file:tips.org] file; then boot into the ISO's live image environment
2. Download the repo onto the live image copy of NixOS.
3. Open the terminal and enter the repo directory.
4. Run `nix-shell` or `nix develop` to enter environment with all necessary packages to build the config properly
   - `nix-shell` is available on any version of nix.
     However, in order to use `nix develop`, you must have nix v2.4+, git, and have enabled
     the `flakes` and `nix-command` experimental features.
     If you are using the custom ISO as stated previously, you can use `nix develop`
     without having to do anything additional as the configs already have the needed configurations and dependencies
5. Follow the instructions over in the (Partitioning)[file:partitioning.org] file!
6. Run `nixos-generate-config --show-hardware-config --root /mnt` to create a base configuration file that the installer provides.
7. Add any of the additional kernel modules as exactly as they appear into the `hosts/HOSTNAME/hardware-configuration` file.
8. Change the `FLAKE` variable located under `home/USERNAME/global/default.nix`.
  Some dotfiles are sym-links that aren't located on nix store and not having the repo in the location
  that the variable specifies will cause the links to break. This would in turn result in
  some apps malfunctioning or not have your settings.
9. Run `nixos-install --flake .#HOSTNAME --root /mnt` to install NixOS with the configuration
10. If you did not set a user password, make sure you use `nixos-enter` to set a password for the user!
11. Move repo into the folder located on /mnt that matches your `FLAKE` environment variable
12. Restart and the system will boot up into NixOS!

## Post Install
Once your system is booted, check out the (Post Install)[file:post-install.org] file for instructions for system and application
setup steps that can only be done once the system is installed and booted.
