{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    androidStudioPackages.canary
  ];
}

