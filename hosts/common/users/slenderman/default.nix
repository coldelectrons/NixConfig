{ config, lib, pkgs, ... }:
let
  ifTheyExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  # Special Variables
  variables.username = "slenderman";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.slenderman = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "slenderman";
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
      "gamemode"
    ];
    openssh.authorizedKeys.keys = [ (builtins.readFile ../../../../home/slenderman/ssh.pub) ];
    hashedPasswordFile = config.sops.secrets.slenderman-password.path;
    packages = with pkgs; [ home-manager ];
  };

  sops.secrets.slenderman-password = {
    sopsFile = ../../../../secrets.yaml;
    neededForUsers = true;
  };

  # Import Home-Manager config for host
  home-manager.users.slenderman =
    import ../../../../home/slenderman/${config.networking.hostName}.nix;

  services = {
    geoclue2 = {
      enable = true;
      enableDemoAgent = lib.mkForce true;
      submitData = true;
      appConfig.vivaldi = {
        isAllowed = true;
        isSystem = false;
      };
    };

    # Setup automatic timezone detection
    automatic-timezoned.enable = true;
    #localtimed.enable = true;
  };

  # Set your time zone.
  #time.timeZone = lib.mkDefault "America/Chicago";
}
