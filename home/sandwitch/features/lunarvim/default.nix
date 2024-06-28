{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lunarvim
    neovim
    zk
    stylua
    libclang
  ];

  home.file = {
    ".config/lvim/config.lua" = {
      source = ./config.lua;
    };
  };
}
