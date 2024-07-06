{ config, pkgs, ... }:
let
  on = { enable = true; };
in

{
  services.moonraker = on // {
    user = "klipper";
    group = "klipper";
    address = "0.0.0.0";
    allowSystemControl = true;
    stateDir = "/var/lib/klipper";
    settings = {
      authorization = {
        cors_domains = [
          "http://${config.networking.hostName}"
          "http://${config.networking.hostName}.lan"
          "http://${config.networking.hostName}.local"
          "http://localhost"
          "http://app.fluidd.xyz"
          # "http://my.mainsail.xyz"
          # "http://le-fail.lan"
          # "http://printer-anette.lan"
        ];
        trusted_clients = [ "0.0.0.0/0" "::0/0" ];
      };
      file_manager = {
        enable_object_processing = "False";
      };
      octoprint_compat = { };
    };
  };
}
