{ boot, config, pkgs, ... }:

  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  networking.hostId = "137baf2d";

  environment.systemPackages = with pkgs; [
    zfs
  ];
}
