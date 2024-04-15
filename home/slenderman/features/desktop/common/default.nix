{ lib, pkgs, outputs, config, ... }:

{
  imports = [
    ./gtk.nix
    ./qt.nix
    ./discord.nix
    ./font.nix

    # Music
    ./cider.nix
    ./jellyfin.nix

    # Browser
    ./firefox.nix
    ./vivaldi.nix

    # Backup solutions
    ./backup.nix

    # Terminals
    #./alacritty.nix
    # ./wezterm.nix
    #./rio.nix
    ./kitty.nix

    # passwords
    ./bitwarden.nix

    # messaging
    ./signal.nix
  ];

  home.packages = with pkgs; [
    pipx
  ];

  environment.localBinInPath = true;
  fonts.fontconfig.enable = true;
  # fonts.fontDir.enable = true;

  xdg = {
    # Allow modification of app assosications
    mimeApps.enable = true;

    # Make mimeapps.list be overriden by default
    configFile."mimeapps.list".force = true;

    # Enable desktop portal
    portal.enable = true;
  };

  environment.extraInit = ''
    # Do not want this in the environment. NixOS always sets it and does not
    # provide any option not to, so I must unset it myself via the
    # environment.extraInit option.
    unset -v SSH_ASKPASS
    unset -v GIT_ASKPASS
  '';
}
