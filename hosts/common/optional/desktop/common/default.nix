{ config, lib, pkgs, ... }:

{
  imports = [ 
    ./pipewire.nix 
    ./printing.nix 
    ./xdg.nix
  ];

  # Enable networking
  networking.networkmanager.enable = true;

  services.dbus = {
    enable = true;
    packages = [ pkgs.dconf ];
  };

  # Enable for GTK
  programs.dconf.enable = true;

  # Enable color management service
  services.colord.enable = true;

  # Install installation
  # TODO Why add these libraries here? Not full applications?
  environment.systemPackages = with pkgs; [
    #Notifications
    libnotify

    #PDF
    poppler

    # Enable guestures for touchpad
    libinput-gestures
  ];
}
