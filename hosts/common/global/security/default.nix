{ config, lib, pkgs, ... }:

{
  imports =
    [
      # ./doas.nix
      ./firejail.nix
      ./firewall.nix
      ./automount.nix
      # ./openvpn.nix
      # ./blocklist.nix
    ];
}
