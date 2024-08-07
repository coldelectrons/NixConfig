# This file (and the global directory) holds config that I use on all hosts
{ inputs, outputs, pkgs, config, ... }:

{
  imports = with inputs;
    [
      home-manager.nixosModules.home-manager
      ./zsh.nix
      ./locale.nix
      ./nix.nix
      ./fish.nix
      ./filesystem.nix
      ./openssh.nix
      ./gpg.nix
      ./network.nix
      ./fonts.nix
      ./security.nix
      ./substituters.nix
    ] ++ (builtins.attrValues outputs.nixosModules);

  # Add special args for home-manager
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    backupFileExtension = ".bak";
  };

  # Config Nixpkgs
  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowBroken = true;
    };
  };

  # Enable use of firmware that allows redistribution
  hardware.enableRedistributableFirmware = true;

  boot = {
    # A Fedora recommendation: https://fedoraproject.org/wiki/Changes/IncreaseVmMaxMapCount
    # Good for Windows games running through Wine or Steam
    # kernel.sysctl."vm.max_map_count" = 1048576; # Arch default
    kernel.sysctl."vm.max_map_count" = 2147483642; # Valve Steamdeck default

    # Make NixOS use the latest Linux Kernel
    # kernelPackages = pkgs.linuxPackages_latest;

    # Makes OBS Virtual Camera feature function
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  };

  # Needed for high-dpi and quiet boot
  console = {
    earlySetup = true;
    useXkbConfig = true;
  };

  # Increase open file limit for sudoers
  security.pam.loginLimits = [
    {
      domain = "@wheel";
      item = "nofile";
      type = "soft";
      value = "524288";
    }
    {
      domain = "@wheel";
      item = "nofile";
      type = "hard";
      value = "1048576";
    }
  ];

  # Enable firmware updates on Linux
  services.fwupd.enable = true;

  # Install more packages
  environment.systemPackages = with pkgs; [
    pciutils
    usbutils
    killall
    git
    sops age
    htop
    bottom
    curl
    wget
    openssl
  ];
}
