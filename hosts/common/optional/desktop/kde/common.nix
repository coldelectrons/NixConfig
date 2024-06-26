{ config, lib, pkgs, inputs, ... }:
with lib;
let
  desktopX = config.services.xserver.desktopManager;
  desktopW = config.services.desktopManager;
  kdeconnect-pkg = if (desktopX.plasma5.enable) then
    pkgs.plasma5Packages.kdeconnect-kde
  else
    pkgs.kdePackages.kdeconnect-kde;
in {
  imports =
    [ ../common ../displayManager/wayland.nix ../displayManager/x11.nix ];

  # Special Variables
  variables.desktop.environment = "kde";

  # Enable the KDE's SDDM.
  services.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
    wayland.enable = desktopW.plasma6.enable;
    settings = {
    };
  };

  # Enable KDE partition manager
  programs = {
    partition-manager.enable = true;
    kdeconnect.enable = true;
  };

  environment.systemPackages = with pkgs;
    (mkMerge [
      ([
        # Apps
        krename
        qalculate-qt
        kdiskmark

        # Libraries/Utilities
        clinfo # for kinfocenter for OpenCL page
        glxinfo # for kinfocenter for OpenGL EGL and GLX page
        vulkan-tools # for kinfocenter for Vulkan page
        wayland-utils # for kinfocenter for Wayland page
        ffmpegthumbnailer # for video thumbnails
        linuxquota # for plasma-disks
        inputs.krunner-nix.packages.${pkgs.system}.default # Nix package search for KRunner
      ])

      (with libsForQt5;
        mkIf (desktopX.plasma5.enable) [
          # Apps
          ktorrent
          kfind
          filelight
          skanpage # Scanner
          print-manager
          plasma-welcome # Welcome screen
          plasma-vault
          plasma-disks

          # Libraries/Utilities
          kdegraphics-thumbnailers
          ffmpegthumbs
          qt5.qtimageformats
          packagekit-qt
          sddm-kcm # Add KCM for sddm
        ])
      (with kdePackages;
        mkIf (desktopW.plasma6.enable) [
          # Apps
          ktorrent
          kfind
          filelight
          skanpage # Scanner
          print-manager
          plasma-welcome # Welcome screen
          plasma-vault
          plasma-disks

          # Libraries/Utilities
          kdegraphics-thumbnailers
          ffmpegthumbs
          qtimageformats
          packagekit-qt
          sddm-kcm # Add KCM for sddm
        ])
    ]);

  # Create system services for KDE connect
  systemd.user.services.kdeconnect = {
    description = "Adds communication between your desktop and your smartphone";
    after = [ "graphical-session-pre.target" ];
    partOf = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];

    serviceConfig = {
      #Environment = "PATH=${config.home.profileDirectory}/bin";
      ExecStart = "${kdeconnect-pkg}/libexec/kdeconnectd";
      Restart = "on-abort";
    };
  };
}
