{...}:
{
  nix.sshServe.enable = true;
  nix.sshServe.write = true;
  nix.sshServe.keys = [ 
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILNLc53xO8V/nzz1ebEGRplW0AeWhTUcYB1ZuWlRYDV1 coldelectrons@hades"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID2M/80KkrrSOzufeeXP5xnLCDPj1zBFBNVpZY3ccw2Q root@hades"
  ];
}
