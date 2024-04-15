{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    # inputs.freecad-realthunder.packages.${pkgs.system}
    kicad
    openscad
  ];
}
