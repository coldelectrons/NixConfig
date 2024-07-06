{ config, pkgs, prelude, ... }@args:
let
  on = { enable = true; };
in

{

  systemd.services.klippercam = {
    script = "${pkgs.ustreamer}/bin/ustreamer -f 15 -s 0";
    enable = true;
    after = [ "network.target" ];
  };

}
