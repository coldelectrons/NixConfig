{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./global
    ./features/desktop/kde
    ./features/games
    ./features/emacs
    ./features/productivity
    #./features/virt-manager
    #./features/vnc TODO: Work on remote desktop
  ];

  colorscheme = inputs.nix-colors.colorSchemes.dracula;

  home.packages = with pkgs; [ keepassxc krita libsForQt5.tokodon ];

  programs.plasma = lib.mkIf (config.environment.desktop == "kde") {
    configFile = {
      kcminputrc."Libinput.1739.52992.SYNACF00:00 06CB:CF00 Touchpad" = {
        TapToClick = true;
        TapDragLock = true;
      };
      kxkbrc.Layout.Options = "caps:ctrl_modifier";
      kwinrc.Xwayland.Scale = 1.25;
    };
  };
}
