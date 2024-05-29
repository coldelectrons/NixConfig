{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    android-tools
    android-udev-rules
  ];
  virtualisation.waydroid.enable = true;
}

