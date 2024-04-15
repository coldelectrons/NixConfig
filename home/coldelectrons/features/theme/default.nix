{ config, lib, pkgs, inputs, ... }:
{

  # theme = {
  #   package = pkgs.dracula-theme;
  #   name = "Dracula";
  #   nameSymbolic = "dracula";
  #   app.rio.name = name;
  #   iconTheme = {
  #     package = pkgs.papirus-icon-theme;
  #     name = "Papirus-Dark";
  #   };
  # };

  # KDE Theming
  # programs = {
    /* plasma = {
         workspace = {
           #wallpaper = "";
           #lookAndFeel = "${config.theme.name}";
           lookAndFeel = "org.kde.breezedark.desktop";
           cursorTheme = "${config.theme.cursorTheme.name}";
           iconTheme = "${config.theme.iconTheme.name}";
           colorScheme = "DraculaPurple";
           theme = "default";
         };
         configFile = {
           "gtk-3.0/settings.ini"."Settings"."gtk-theme-name".value =
             "${config.theme.name}";
           "gtk-4.0/settings.ini"."Settings"."gtk-theme-name".value =
             "${config.theme.name}";
         };
       };
    */
  #   zsh.syntaxHighlighting.styles = {
  #     ## General
  #     ### Diffs
  #     ### Markup
  #     ## Classes
  #     # Comments
  #     comment = "fg=${c.base04}";
  #     ## Constants
  #     ## Entitites
  #     ## Functions/methods
  #     alias = "fg=${c.base0B}";
  #     suffix-alias = "fg=${c.base0B}";
  #     global-alias = "fg=${c.base0B}";
  #     function = "fg=${c.base0B}";
  #     command = "fg=${c.base0B}";
  #     precommand = "fg=${c.base0B},italic";
  #     autodirectory = "fg=${c.base09},italic";
  #     single-hyphen-option = "fg=${c.base09}";
  #     double-hyphen-option = "fg=${c.base09}";
  #     back-quoted-argument = "fg=${c.base0E}";
  #     ## Keywords
  #     ## Built ins
  #     builtin = "fg=${c.base0B}";
  #     reserved-word = "fg=${c.base0B}";
  #     hashed-command = "fg=${c.base0B}";
  #     ## Punctuation
  #     commandseparator = "fg=${c.base08}";
  #     command-substitution-delimiter = "fg=${c.base05}";
  #     command-substitution-delimiter-unquoted = "fg=${c.base05}";
  #     process-substitution-delimiter = "fg=${c.base05}";
  #     back-quoted-argument-delimiter = "fg=${c.base08}";
  #     back-double-quoted-argument = "fg=${c.base08}";
  #     back-dollar-quoted-argument = "fg=${c.base08}";
  #     ## Serializable / Configuration Languages
  #     ## Storage
  #     ## Strings
  #     command-substitution-quoted = "fg=${c.base0A}";
  #     command-substitution-delimiter-quoted = "fg=${c.base0A}";
  #     single-quoted-argument = "fg=${c.base0A}";
  #     single-quoted-argument-unclosed = "fg=${c.base08},bold";
  #     double-quoted-argument = "fg=${c.base0A}";
  #     double-quoted-argument-unclosed = "fg=${c.base08},bold";
  #     rc-quote = "fg=${c.base0A}";
  #     ## Variables
  #     dollar-quoted-argument = "fg=${c.base05}";
  #     dollar-quoted-argument-unclosed = "fg=${c.base08},bold";
  #     dollar-double-quoted-argument = "fg=${c.base05}";
  #     assign = "fg=${c.base05}";
  #     named-fd = "fg=${c.base05}";
  #     numeric-fd = "fg=${c.base05}";
  #     ## No category relevant in spec
  #     unknown-token = "fg=${c.base08},bold";
  #     path = "fg=${c.base05}";
  #     path_pathseparator = "fg=${c.base08}";
  #     path_prefix = "fg=${c.base05}";
  #     path_prefix_pathseparator = "fg=${c.base08}";
  #     globbing = "fg=${c.base05}";
  #     history-expansion = "fg=${c.base0E}";
  #     #command-substitution ="fg=?";
  #     #command-substitution-unquoted ="fg=?";
  #     #process-substitution ="fg=?";
  #     #arithmetic-expansion ="fg=?";
  #     back-quoted-argument-unclosed = "fg=${c.base08},bold";
  #     redirection = "fg=${c.base05}";
  #     arg0 = "fg=${c.base05}";
  #     default = "fg=${c.base05}";
  #     cursor = "fg=${c.base05}";
  #   };
  # };
}
