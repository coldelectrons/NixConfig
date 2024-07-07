{ config, pkgs, ... }:
# let
  # iface = "enp0s18u1u1";
  # conf = builtins.toFile "KlipperConfig.conf" ''
  #   [printer Anette]
  #   moonraker_host: localhost
  #   moonraker_port: 7125
  #   
  #   [printer Plumbus]
  #   moonraker_host: printer-plumbus.lan
  #   moonraker_port: 7125 
  # '';
# in

{
  systemd.services.klipperscreen = {
    path = with pkgs; [ klipperscreen ];
    script = ''
      export DISPLAY=:0
      echo Starting at $DISPLAY
      KlipperScreen
    '';
    enable = true;
    after = [ "moonraker.service" ];
    # after = [ "moonraker.service" "sys-subsystem-net-devices-${iface}.device" ];
    # bindsTo = [ "sys-subsystem-net-devices-${iface}.device" ];
    # partOf = [ "sys-subsystem-net-devices-${iface}.device" ];
    # requires = [ "sys-subsystem-net-devices-${iface}.device" ];
    # wantedBy = [ "sys-subsystem-net-devices-${iface}.device" ];
    serviceConfig.Restart = "always";
  };

  # systemd.services.klipperscreen-out = {
  #   path = with pkgs; [ klipperscreen iproute2 ];
  #   script = ''
  #     export DISPLAY=klipperphone.lan:0
  #     echo Starting at $DISPLAY
  #     KlipperScreen -c ${conf}
  #   '';
  #   enable = true;
  #   conflicts = [ "sys-subsystem-net-devices-${iface}.device" ];
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig.Restart = "always";
  # };
}
