{ inputs, outputs, lib, pkgs, config, ... }:

{
  imports = [ 
    ../../common/global 
    ../features/cli 
    ../features/lunarvim
  ];

  # Enable HTML help page
  manual.html.enable = true;

  # Setup Home-Manager
  home = {
    username = lib.mkDefault "coldelectrons";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "24.05";
    sessionPath = [ "$HOME/.local/bin" ];
    sessionVariables = {
      FLAKE = "${config.home.homeDirectory}/Sync/NixConfig";
      #CARGO_HOME = "${config.xdg.dataHome}/cargo";
    };
    # file."./Pictures/Wallpapers".source = inputs.wallpapers;
  };

  # Enable XDG
  xdg = {
    userDirs.enable = true;
    userDirs.createDirectories = true;
    mimeApps.enable = true;
  };
}
