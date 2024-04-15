{ config, lib, pkgs, ... }:

{
  imports = [
    ./atuin.nix
    ./bash.nix
    ./bat.nix
    ./btop.nix
    ./cava.nix
    ./direnv.nix
    ./eza.nix
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./jujutsu.nix
    # ./nix-index.nix
    ./ssh.nix
    ./tmux.nix
    ./starship.nix
    # ./zsh.nix
  ];

  # incompatible with nix-index shell integrations
  programs.command-not-found.enable = true;

  home.packages = with pkgs; [
    # toilet # Display fancy text in terminal
    # dwt1-shell-color-scripts # Display cool graphics in terminal
    # cmatrix # Show off the Matrix
    timer # Cooler timer in terminal
    tree
    tldr # better man pages
    entr # run commands when files change!
    dmidecode
    perl
    ventoy-full # bootable USB solution
    comma # Install and run programs by sticking a , before them
    distrobox # Nice escape hatch, integrates docker images with my environment
    bc # Calculator
    bottom # System viewer
    ncdu # TUI disk usage
    ripgrep # Better grep
    fd # Better find
    curl
    wget
    mc
    httpie # Better curl
    diffsitter # Better diff
    jq # JSON pretty printer and manipulator
    timer # To help with my ADHD paralysis

    gnugrep gnused
    killall
    libnotify
    timer
    htop
    hwinfo
    unzip
    w3m
    pandoc
    pciutils
    mc sfm
    bitwarden-cli
    appimage-run
    lvm2
    ctmg
    cryptomator
    dnsutils
    dnstracer
    zdns
    hw-probe
    usbutils
    cyme # a better lsusb
    usbview
    clinfo
    usbimager
    rpi-imager
    sshfs

    ltex-ls # Spell checking LSP

    mdcat # cat for markdown
    termpdfpy # graphical reader for inside kitty
    presenterm # terminal slideshow
    slides
    mdp # markdown presentation
    termimage # display images in the term
    viu
    kitty-img
    pixcat
    nb # note book
    neofetch disfetch lolcat cowsay onefetch starfetch
    wl-clipboard
    glow

    # Nix Tools
    nil # Nix LSP
    nixfmt-classic # Nix formatter
    nvd # Differ
    nix-output-monitor
    nh # Nice wrapper for NixOS and HM
    nixpkgs-review
    nix-prefetch-github # prefetch tool for Github

    gallery-dl # datahoarding ftw
    signald
    signal-export
    gurk-rs
    scli
  ];
}
