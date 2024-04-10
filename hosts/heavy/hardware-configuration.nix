# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  boot.consoleLogLevel = 0;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [
    # "kvm-intel"
  ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    zenpower
  ];
  boot.kernelParams = [ 
  ];                                                                                                                                   
  environment.systemPackages = with pkgs; [
    linux-firmware
    zenstates
    amdctl
  ];
  
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/615e2d96-5170-4528-ab8a-b5ccbfa7a79a";
      fsType = "ext4";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/e715cd77-b48c-4c87-b0b5-729ed91d7b5d";
      fsType = "ext4";
    };

  fileSystems."/home/thomas/.local/share/Steam" =
    { device = "/dev/disk/by-uuid/7407920b-3535-49d5-b9ed-f73b442ec36d";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/F000-517A";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/bfd0f82c-cbb6-459a-bc2d-d4559607a3dd"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s20f0u7.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp10s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.tailscale0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.enableRedistributableFirmware = true;                                                                                                                                                                   
  # hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  
}
