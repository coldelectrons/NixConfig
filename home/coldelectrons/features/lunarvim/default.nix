{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lunarvim
    neovide
    zk
    stylua
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
