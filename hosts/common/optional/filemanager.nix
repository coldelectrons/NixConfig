{ config, lib, pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs;
      [ 
        # terminal file managers, because while I like mc
        # it doesn't seem to work right with fish or zsh
        mc
        lf
        walk
        fm-go
        joshuto
        superfile
        sfm
      ];
  };
  programs.yazi = {
    enable = true;
    enableBashIntegration = lib.mkIf config.programs.bash.enable true;
    enableFishIntegration = lib.mkIf config.programs.fish.enable true;
    enableZshIntegration = lib.mkIf config.programs.zsh.enable true;
    enableNushellIntegration = lib.mkIf config.programs.nushell.enable true;
  };
}
