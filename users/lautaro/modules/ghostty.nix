{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;

    settings = {
      font-family = "Iosevka Nerd Font Mono";
      font-size = 12;
      command = "${pkgs.tmux}/bin/tmux";
      window-width = 140;
      window-height = 43;
      window-padding-x = 5;
      window-padding-y = 5;
      copy-on-select = "clipboard";
      theme = "light:dotfiles-light,dark:dotfiles-dark";
    };

    themes = {
      dotfiles-light = {
        background = "#f7f7f7";
        foreground = "#1d2028";
        palette = [
          "0=#f7f7f7"
          "1=#9d0006"
          "2=#79740e"
          "3=#b57614"
          "4=#076678"
          "5=#8f3f71"
          "6=#427b58"
          "7=#3c3836"
          "8=#928374"
          "9=#cc241d"
          "10=#98971a"
          "11=#d79921"
          "12=#458588"
          "13=#b16286"
          "14=#689d6a"
          "15=#1d2028"
        ];
      };

      dotfiles-dark = {
        background = "#181818";
        foreground = "#ebdbb2";
        palette = [
          "0=#181818"
          "1=#cc241d"
          "2=#98971a"
          "3=#d79921"
          "4=#458588"
          "5=#b16286"
          "6=#689d6a"
          "7=#a89984"
          "8=#928374"
          "9=#fb4934"
          "10=#b8bb26"
          "11=#fabd2f"
          "12=#83a598"
          "13=#d3869b"
          "14=#8ec07c"
          "15=#ebdbb2"
        ];
      };
    };
  };
}
