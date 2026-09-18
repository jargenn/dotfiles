{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      general.import = [
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
          columns = 140;
          lines = 43;
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
      background = "#f7f7f7"
      foreground = "#1d2028"

      [colors.normal]
      black   = "#f7f7f7"
      red     = "#9d0006"
      green   = "#79740e"
      yellow  = "#b57614"
      blue    = "#076678"
      magenta = "#8f3f71"
      cyan    = "#427b58"
      white   = "#3c3836"

      [colors.bright]
      black   = "#928374"
      red     = "#cc241d"
      green   = "#98971a"
      yellow  = "#d79921"
      blue    = "#458588"
      magenta = "#b16286"
      cyan    = "#689d6a"
      white   = "#1d2028"
    '';

    "alacritty/dark.toml".text = ''
      [colors.primary]
      background = "#181818"
      foreground = "#ebdbb2"

      [colors.normal]
      black   = "#181818"
      red     = "#cc241d"
      green   = "#98971a"
      yellow  = "#d79921"
      blue    = "#458588"
      magenta = "#b16286"
      cyan    = "#689d6a"
      white   = "#a89984"

      [colors.bright]
      black   = "#928374"
      red     = "#fb4934"
      green   = "#b8bb26"
      yellow  = "#fabd2f"
      blue    = "#83a598"
      magenta = "#d3869b"
      cyan    = "#8ec07c"
      white   = "#ebdbb2"
    '';
  };
}
