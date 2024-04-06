{ pkgs, ... }: {
  imports = [
    ./pfetch.nix
    ./screen.nix
    ./shellcolor.nix
  ];
  home.packages = with pkgs; [

    cava

    bitwarden
    rpi-imager
    sirikali
  ];
}
