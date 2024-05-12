{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./global
    ./features/theme
    ./features/desktop/kde/plasma6
    # ./features/games
    ./features/lunarvim
    ./features/cli
    # ./features/productivity
    # ./features/virt-manager
    ./features/cli
  ];

  ### Special Variables
  variables.useVR = false;
  variables.useKonsole = false;
  variables.machine.gpu = "amd";
  variables.desktop.displayManager = "wayland";
  # variables.machine.motherboard = "amd";
  variables.machine.buildType = "desktop";
  # variables.machine.lowSpec = false;
  ###

  # Install a couple more packages
  # home.packages = with pkgs; [ ];
}
