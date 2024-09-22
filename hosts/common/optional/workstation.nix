{ config, lib, pkgs, ... }:

{
  # programs = {
  # };

  hardware = {
    # Enable OpenGL
    opengl = {
      enable = true;
      # driSupport = true;
      # driSupport32Bit = true;
      extraPackages = with pkgs;
        [ libva-utils vaapiVdpau libvdpau-va-gl ]
        ++ lib.optionals (config.variables.machine.gpu == "nvidia")
        [ nvidia-vaapi-driver ];
    };
  };

  environment = {
    systemPackages = with pkgs;
      [
        webkitgtk_4_1 # for use with Prusaslicer appimage
        freecad
        prusaslicer
      ];
  };
}
