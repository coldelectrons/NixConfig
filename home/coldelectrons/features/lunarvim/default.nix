{ config, pkgs, pkgs-stable, ... }:
let
in
{
  home.packages = with pkgs; [
    lunarvim
    neovide
    zk
  ];

  home.file = {
    ".config/lvim/config.lua" = {
      source = ./config.lua;
    };
    ".local/bin/lvimide" = {
      source = ./lvimide;
    };
  };
}
