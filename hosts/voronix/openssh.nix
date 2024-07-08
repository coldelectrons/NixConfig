{ pkgs, ... }:
{

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
    extraConfig = ''
      # Password based logins are disabled - only public key based logins are allowed.
      AuthenticationMethods publickey
    '';
  };
  users.users."root".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILNLc53xO8V/nzz1ebEGRplW0AeWhTUcYB1ZuWlRYDV1"
  ];
  users.users."nixos".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILNLc53xO8V/nzz1ebEGRplW0AeWhTUcYB1ZuWlRYDV1"
  ];

}
