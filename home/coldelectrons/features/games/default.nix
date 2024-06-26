{ config, lib, pkgs, ... }:

{
  imports = [ 
    ./steam.nix
    ./minecraft.nix
    ./lutris.nix
  ];

  xdg.userDirs.extraConfig = {
    XDG_GAME_DIR = "${config.home.homeDirectory}/Games";
  };
}
