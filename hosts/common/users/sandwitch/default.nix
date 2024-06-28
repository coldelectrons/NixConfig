{ config, lib, pkgs, ... }:
let
  ifTheyExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  # Special Variables
  variables.username = "sandwitch";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sandwitch = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "sandwitch";
    extraGroups = [ 
      "networkmanager"
      "wheel"
      ] ++ ifTheyExist [
      "input"
      "plugdev"
      "dialout"
      "video"
      "audio"
      "docker"
      "podman"
      "libvirtd"
      "scanner"
      "i2c"
      "git"
    ];
    # openssh.authorizedKeys.keys = [ (builtins.readFile ../../../../home/sandwitch/ssh.pub) ];
    # hashedPasswordFile = config.sops.secrets.sandwitch-password.path;
    packages = with pkgs; [ home-manager ];
  };

  # sops.secrets.sandwitch-password = {
  #   sopsFile = ../../../../secrets.yaml;
  #   neededForUsers = true;
  # };

  # Import Home-Manager config for host
  home-manager.users.sandwitch =
    import ../../../../home/sandwitch/${config.networking.hostName}.nix;

  # Set your time zone.
  time.timeZone = lib.mkDefault "America/New_York";
}
