{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./global
    ./features/theme
    ./features/desktop/kde/plasma6
    ./features/games
    ./features/productivity
    ./features/virt-manager
  ];

  ### Special Variables
  variables.useVR = true;
  variables.useKonsole = false;
  variables.machine.gpu = "amd";
  variables.desktop.displayManager = "wayland";
  # variables.machine.motherboard = "amd";
  variables.machine.buildType = "desktop";
  # variables.machine.lowSpec = false;
  ###

  # Install a couple more packages
  home.packages = with pkgs; [ krita kdePackages.tokodon ];
}
