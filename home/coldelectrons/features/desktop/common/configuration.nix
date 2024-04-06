# Edit this configuration file to define what should be installed on your system.
# Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs, systemSettings, userSettings, ... }:
{
  imports = [
      ./hardware-configuration.nix
      # ./system/hardware/systemd.nix # systemd config
      # ./system/app/gamemode.nix
  ];

  # ---- SYSTEM SETTINGS ---- #
  systemSettings = {
    system = "x86_64-linux"; # system arch
    hostname = "hades"; # hostname
    timezone = "America/New_York"; # select timezone
    locale = "en_US.UTF-8"; # select locale
    wm = "plasma6";
    app = {
      steam.enable = true;
      gaming.enable = true;
      prismlauncher.enable = false;
      flatpak.enable = true;
      virtualization.enable = true;
    };
    hardware = {
      systemdConfig.enable = true;
      time.enable = true;
      gpuDRI.enable = true;
      gpu = "amd";
      pm.enable = true;
      automount.enable = true;
      spacenav.enable = true;
      printing.enable = true;
      openrgb.enable = false;
      bluetooth.enable = true;
    };
    security = {
      doas.enable = true;
      blocklist.enable = false;
      firewall.enable = false;
      firejail.enable = false;
      sshd.enable = true;
      gpg.enable = true;
    };
  };

  # Fix nix path
  nix.nixPath = [ "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
                  "nixos-config=$HOME/dotfiles/system/configuration.nix"
                  "/nix/var/nix/profiles/per-user/root/channels"
                ];

  # Ensure nix flakes are enabled
  nix.package = pkgs.nixFlakes;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # I'm not sorry, Stallman. And I'll do it again.
  nixpkgs.config.allowUnfree = true;

  # Kernel modules
  boot.kernelModules = [ "i2c-dev" "i2c-piix4" "cpufreq_powersave" ];

  # Bootloader
  # TODO add a if-then and option for this
  boot.loader.systemd-boot.enable = true;
  # XXX WTF aren't these in the default configuration.nix at install
  # boot.loader.grub.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.devices = ["nodev"];
  # boot.loader.grub.useOSProber = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  # Networking
  networking.hostName = systemSettings.hostname; # Define your hostname.
  networking.networkmanager.enable = true; # Use networkmanager
  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  # Timezone and locale
  time.timeZone = systemSettings.timezone; # time zone
  i18n.defaultLocale = systemSettings.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };

  # User account
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    # TODO make submodules add extragroups, don't just shotgun it here
    extraGroups = [ "networkmanager" "wheel" "video" "kvm" "libvirt" ];
    packages = [];
    uid = 1000;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim neovim nano
    mc
    wget curl
    zsh-powerlevel10k
    git
    cryptsetup
    tmux mosh screen
    alacritty kitty # included here so xterm info is system-wide
    home-manager

    # other browsers
    firefox-unwrapped
    ungoogled-chromium

    #messaging
    signal-desktop
    dorion

    # util
    bitwarden
    bitwarden-cli
    appimage-run
    gparted
    lvm2
    ctmg
    cryptomator
    dnsutils
    dnstracer
    zdns
    usbutils
    usbview
    pciutils
    clinfo
    usbimager
    rpi-imager
    sshfs
    sirikali

    # games
    # playonlinux
    lutris

    # (ollama.override{ acceleration="rocm"; })
  ];

  environment.localBinInPath = true;

  services.tailscale.enable = true;

  # I use zsh btw
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  programs.yazi.enable = true;

  fonts.fontDir.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };
  environment.extraInit = ''
    # Do not want this in the environment. NixOS always sets it and does not
    # provide any option not to, so I must unset it myself via the
    # environment.extraInit option.
    unset -v SSH_ASKPASS
    unset -v GIT_ASKPASS
  '';

  # It is ok to leave this unchanged for compatibility purposes
  system.stateVersion = "23.11";

}
