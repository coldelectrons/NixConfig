{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    # inputs.freecad-realthunder.packages.${pkgs.system}.default
    inputs.freecad-realthunder.default
    kicad
    openscad
  ];
}
