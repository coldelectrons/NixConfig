{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ### Device Configs
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.sops-nix.nixosModules.sops
    ./hardware-configuration.nix
    # ./disks.nix

    ### Global Configs
    ../common/global
    ../common/users/coldelectrons

    ### Hardware
    # ../common/optional/rgb.nix
    ../common/optional/bluetooth.nix
    # ../common/optional/qmk.nix

    ### Desktop Environment
    ../common/optional/desktop/kde/plasma6.nix

    ### Service
    ../common/optional/theme.nix
    ../common/optional/quietboot.nix
    ../common/optional/libvirt.nix
    ../common/optional/syncthing.nix
    ../common/optional/tailscale.nix
    ../common/optional/ollama.nix

    ### Applications
    ../common/optional/flatpak.nix
    ../common/optional/appimage.nix
    ../common/optional/localsend.nix
    ../common/optional/gaming.nix
    ../common/optional/android-studio.nix
    ../common/optional/waydroid.nix
    #../common/optional/sunshine-client.nix
  ];

  networking.hostName = "hades"; # Define your hostname.
  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  ### Special Variables
  variables.useVR = true;
  variables.useKonsole = false;
  variables.desktop.displayManager = "wayland";
  # variables.machine.motherboard = "amd";
  variables.machine.buildType = "desktop";
  variables.machine.gpu = "amd";
  #variables.machine.lowSpec = false;
  ###

  services.xserver.videoDrivers = [ "amdgpu" ];

  environment = {
    #systemPackages = with pkgs; [ gwe ];
    sessionVariables.LIBVA_DRIVER_NAME = "amdgpu";
  };

  environment.localBinInPath = true;

  environment.extraInit = ''
    # Do not want this in the environment. NixOS always sets it and does not
    # provide any option not to, so I must unset it myself via the
    # environment.extraInit option.
    unset -v SSH_ASKPASS
    unset -v GIT_ASKPASS
  '';

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    binfmt.emulatedSystems = [ "aarch64-linux" "i686-linux" ];
    consoleLogLevel = 0;
    # Bootloader
    loader = {
      grub = {
        enable = false;
      };
      systemd-boot = {
        enable = true;
        memtest86.enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      availableKernelModules =
        [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
      kernelModules = [ "amdgpu" ];
      systemd.enable = true;
    };
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = with config.boot.kernelPackages; [
      zenpower
    ];
    kernelParams = [ 
    ];                                                                                                                                   

    plymouth.enable = true;
    # Swapfile hibernate
    # resumeDevice = "${MAIN_PART}";
    # kernelParams = [ "resume_offset=${RESUME_OFFSET}" "nvidia_drm.fbdev=1" ];
  };

  environment.systemPackages = with pkgs; [
    linux-firmware
    zenstates
    amdctl
  ];
  # system.activationScripts =
  #   lib.mkIf (config.services.hardware.openrgb.enable) {
  #     makeOpenRGBSettings = ''
  #       mkdir -p /var/lib/OpenRGB/plugins/settings/effect-profiles

  #       cp ${configFile} /var/lib/OpenRGB/OpenRGB.json
  #     '';
  #   };

  # sops.defaultSopsFile = "../../secrets.yaml";
  # sops.defaultSopsFormat = "yaml";
  # sops.age.keyFile = "~/.config/sops/age/keys.txt";
  # sops.secrets."myservice.mysubdir.mysecret" = {
  #   # owner = config.users.users.coldelectrons.name;
  # };
}
