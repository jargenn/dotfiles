{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "Iosevka Nerd Font Mono";
          style = "Regular";
        };
        size = 12.0;
      };

      terminal = {
      shell = {
        program = "nu";
        args = [ "--interactive" ];
      };
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
}
