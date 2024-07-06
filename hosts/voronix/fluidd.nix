{ ... }:
let
  on = { enable = true; };
in

{
  services.fluidd = on // {
    nginx = {
      extraConfig = ''
        client_max_body_size 1G;
      '';
      locations."/webcam".proxyPass = "http://127.0.0.1:8080/stream";
    };
  };
}
