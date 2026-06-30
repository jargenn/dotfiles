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

      terminal.shell = {
        program = "${pkgs.tmux}/bin/tmux";
        # args = [ "new-session" "-A" "-s" "main" ];
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
