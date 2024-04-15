{ pkgs, lib, ... }: {
  home.packages = [ pkgs.sublime-music ];
  # home.persistence = {
  #   "/persist/home/thomas".directories = [ ".config/sublime-music" ];
  # };
}
