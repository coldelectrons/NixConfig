{ config, lib, pkgs, ... }:

{
  imports = [ 
    # ./prusa-slicer.nix
    # ./obs.nix
    # ./eclipse.nix
    # ./mpv.nix
    # ./cadcam.nix
  ];

  home = {
    # Libreoffice-qt fix
    sessionVariables.SAL_USE_VCLPLUGIN = "kf5";
    packages = with pkgs;
      [ ]
      ++ lib.optionals (config.variables.desktop.environment == "kde")
      [ libreoffice-qt ]
      ++ lib.optionals (config.variables.desktop.environment == "xfce")
      [ libreoffice-fresh ];
  };
}
