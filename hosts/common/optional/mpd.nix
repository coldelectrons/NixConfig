{ config, lib, pkgs, ... }:
{
  programs = {
  };

  # Fixes SteamLink/Remote play crashing, add packages necessary for VR
  environment = {
    systemPackages = with pkgs;
      [ 
        mpd
        mpd-sima
        ashuffle
        mus
        mpc-cli
        # cantata
        pms
        ario
        ncmpcpp
        miniplayer
        sonata
        
      ];
  };
}
