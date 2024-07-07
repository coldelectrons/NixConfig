{ config, lib, pkgs, ... }:
{
  programs = {
  };

  # Fixes SteamLink/Remote play crashing, add packages necessary for VR
  environment = {
    systemPackages = with pkgs;
      [ 
        yazi
        superfile

      ];
  };
}
