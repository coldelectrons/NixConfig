{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lunarvim
    neovide
    neovim
    zk
    stylua
    libclang
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
