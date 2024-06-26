{ pkgs, ... }:
{
  programs.gh = {
    enable = true;
    extensions = with pkgs; [ gh-markdown-preview ];
    settings = {
      version = "1";
      git_protocol = "ssh";
      prompt = "enabled";
    };
  };
  # home.persistence = {
  #   "/persist/home/thomas".directories = [ ".config/gh" ];
  # };
}
