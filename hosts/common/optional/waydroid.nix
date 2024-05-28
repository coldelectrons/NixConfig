{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    android-tools
    android-udev-rules
  ];
  virtualization.waydroid.enable = true;
}

