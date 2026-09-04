{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      import = [
        "~/.config/alacritty/theme.toml"
      ];

      font = {
        normal = {
          family = "Iosevka Nerd Font Mono";
          style = "Regular";
        };
        size = 12.0;
      };

      terminal.shell = {
        program = "${pkgs.tmux}/bin/tmux";
      };

      window = {
        dimensions = {
          columns = 80;
          lines = 40;
        };
        padding = {
          x = 5;
          y = 5;
        };
      };

      selection = {
        save_to_clipboard = true;
      };
    };
  };

  xdg.configFile = {
    "alacritty/light.toml".text = ''
      [colors.primary]
      background = "#fbf1c7"
      foreground = "#3c3836"
    '';

    "alacritty/dark.toml".text = ''
      [colors.primary]
      background = "#282828"
      foreground = "#ebdbb2"
    '';
  };
}
