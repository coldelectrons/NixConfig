{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./global
    ./features/theming
    ./features/desktop/kde/plasma5
    ./features/games
    ./features/emacs
    ./features/productivity
    ./features/virt-manager
  ];

  ### Special Variables
  variables.useVR = true;
  variables.useKonsole = false;
  variables.machine.gpu = "nvidia";
  variables.desktop.displayManager = "x11";
  #variables.machine.motherboard = "amd";
  variables.machine.buildType = "desktop";
  #variables.machine.lowSpec = false;
  ###

  # Install a couple more packages
  home.packages = with pkgs; [ keepassxc krita libsForQt5.tokodon ];
}
