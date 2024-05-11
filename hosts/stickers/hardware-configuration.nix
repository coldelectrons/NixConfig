# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    consoleLogLevel = 0;
    # Bootloader
    loader = {
      grub = {
        enable = false;
      };
      systemd-boot = {
        enable = true;
        memtest86.enable = true;
      };
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      availableKernelModules =
        [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
      #kernelModules = [ "nvidia" ];
    };
    kernelModules = [ "kvm-intel" ];
    kernelParams = [ 
    ];                                                                                                                                   

    # Swapfile hibernate
    # resumeDevice = "${MAIN_PART}";
    # kernelParams = [ "resume_offset=${RESUME_OFFSET}" "nvidia_drm.fbdev=1" ];
  };

  environment.systemPackages = with pkgs; [
    linux-firmware
  ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/b168bb9d-4769-467e-9618-126769a5bbdc";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/F412-1BDD";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/2e70152b-7f99-47b4-ab48-5a1be971cdac"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
