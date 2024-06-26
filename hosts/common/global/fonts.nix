{ config, lib, pkgs, ... }:

{
  fonts = {
    fontconfig.enable = true;
    # Enable base fonts
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-color-emoji
      fira-code
      fira-code-symbols
      hack-font
      nerdfonts
      meslo-lg
      meslo-lgs-nf
      corefonts
      vistafonts
    ];
  };
}
