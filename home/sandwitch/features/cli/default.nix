{ config, lib, pkgs, ... }:

{
  imports = [
    # ./atuin.nix
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
  ];
}
