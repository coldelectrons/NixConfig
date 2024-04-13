{ config, lib, pkgs, ... }:

{
  imports =
    [
      # ./gpg.nix
      # ./doas.nix
      ./firejail.nix
      ./firewall.nix
      ./automount.nix
      # ./openvpn.nix
      # ./blocklist.nix
    ];
}
