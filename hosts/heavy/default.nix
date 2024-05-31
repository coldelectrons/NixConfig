{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ### Device Configs
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    # inputs.sops-nix.nixosModules.sops
    ./hardware-configuration.nix
    # ./disks.nix

    ### Global Configs
    ../common/global
    ../common/users/coldelectrons

    ### Hardware
    # ../common/optional/rgb.nix
    # ../common/optional/bluetooth.nix
    # ../common/optional/qmk.nix

    ### Desktop Environment
    # ../common/optional/desktop/kde/plasma6.nix

    ### Service
    # ../common/optional/theme.nix
    ../common/optional/quietboot.nix
    ../common/optional/libvirt.nix
    ../common/optional/syncthing.nix
    ../common/optional/tailscale.nix

    ### Applications
    # ../common/optional/flatpak.nix
    # ../common/optional/appimage.nix
    # ../common/optional/localsend.nix
    ./ssh-serve.nix
  ];

  networking.hostName = "heavy"; # Define your hostname.
  networking.networkmanager.enable = true;
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
  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  ### Special Variables
  variables.useVR = false;
  variables.useKonsole = false;
  variables.desktop.displayManager = "wayland";
  # variables.machine.motherboard = "amd";
  variables.machine.buildType = "server";
  variables.machine.gpu = "amd";
  #variables.machine.lowSpec = false;
  ###

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    binfmt.emulatedSystems = [ "aarch64-linux" "i686-linux" ];
    supportedFilesystems = [ "zfs" ];
    zfs.forceImportRoot = false;
    zfs.extraPools = [ "utank" "vtank" ];
    zfs.devNodes = "/dev/disk/by-partuuid/";
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
        [ "mpt3sas" "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
      kernelModules = [ "amdgpu" ];
    };
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = with config.boot.kernelPackages; [
      zenpower
    ];
    kernelParams = [ 
    ];                                                                                                                                   

    # Swapfile hibernate
    # resumeDevice = "${MAIN_PART}";
    # kernelParams = [ "resume_offset=${RESUME_OFFSET}" "nvidia_drm.fbdev=1" ];
  };

  environment.systemPackages = with pkgs; [
    zfs
    linux-firmware
    zenstates
    amdctl
  ];

  # needed for zfs
  networking.hostId = "137dbeef";

  services.xserver.videoDrivers = [ "amdgpu" ];

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  #services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.desktopManager.xfce.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
  
  environment.localBinInPath = true;

  environment.extraInit = ''
    # Do not want this in the environment. NixOS always sets it and does not
    # provide any option not to, so I must unset it myself via the
    # environment.extraInit option.
    # This is because when I was trying Hyprland and working in a terminal,
    # anytime I'd try to ssh somewhere, I'd lose input focus, and then I'd
    # have to hunt for some popup window - that is, after I figured out
    # what was going on.
    unset -v SSH_ASKPASS
    unset -v GIT_ASKPASS
  '';

  # system.activationScripts =
  #   lib.mkIf (config.services.hardware.openrgb.enable) {
  #     makeOpenRGBSettings = ''
  #       mkdir -p /var/lib/OpenRGB/plugins/settings/effect-profiles

  #       cp ${configFile} /var/lib/OpenRGB/OpenRGB.json
  #     '';
  #   };

  # sops.defaultSopsFile = "../../../secrets/secrets.yaml";
  # sops.defaultSopsFormat = "yaml";
}
