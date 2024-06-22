{ config, lib, pkgs, ... }:

{
  # Enable mDNS
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
    # for a WiFi printer
    openFirewall = true;
    denyInterfaces = [ "enp11s0f1u2u2" ];
    ipv4 = true;
    ipv6 = true;
    # Make user systemd service work with avahi
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
      userServices = true;
    };
  };
}
