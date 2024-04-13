{ pkgs, ... }: {
  fontProfiles = {
    enable = true;
    monospace = {
      family = "FiraCode Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
    };
    regular = {
      family = "Fira Sans";
      package = pkgs.fira;
    };
  };
  # fonts.fontDir.enable = true;
  # fonts.packages = with pkgs; [
  #   # Fonts
  #   (nerdfonts.override { fonts = [ "JetBrainsMono" "Inconsolata" "NerdFontsSymbolsOnly" "Hack" "SourceCodePro"]; })
  #   powerline
  #   inconsolata
  #   inconsolata-nerdfont
  #   iosevka
  #   font-awesome
  #   ubuntu_font_family
  #   terminus_font
  # ];
}
