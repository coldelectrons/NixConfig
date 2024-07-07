{ config, pkgs,... }:
let
  on = { enable = true; };
in

# Klipper and stuff around it.

{
  users.users.klipper = {
    isSystemUser = true;
    group = "klipper";
  };

  users.groups.klipper = { };

  security.polkit = on;

  #  Actually, /var/lib/klipper will be taken over by moonraker
  # /var/lib/klipper/config will contain both klipper and moonraker configs

  services.klipper = on // {
    user = "klipper";
    group = "klipper";
    configFile = ./octopus-printer-rev-c.cfg;
    mutableConfig = true;
    mutableConfigFolder = "/var/lib/klipper/config";
    firmwares = {
      voronix-main = on // {
        # serial = "/dev/serial/by-id/usb-Klipper_stm32f446xx_octopus12345-if00";
        canbus_uuid = "f7dcdb4b8ba9";
        configFile = ./octopus_v1.1_usbcan_firmware.cfg;
      };
    };
  };

  # services.klippain = on // {
  #   mutableConfigFolder = services.klipper.mutableConfigFolder;
  #   mainMcuTemplate = "octopus_v1.1";
  #   toolheadTemplate = "";
  #   mmuTemplate = "";
  #   
  # };

  # environment.systemPackages = [
  #   klippain = pkgs.callPackage ./klippain.nix;
  # ];


}
