{ config, pkgs, ... }:

{
  services.darkman = {
    enable = true;

    darkModeScripts = {
      alacritty = ''
        ln -sfn "${config.xdg.configHome}/alacritty/dark.toml" \
            "${config.xdg.configHome}/alacritty/theme.toml"
      '';

      tmux = ''
        ln -sfn "${config.xdg.configHome}/tmux/dark.conf" \
        "${config.xdg.configHome}/tmux/theme.conf"

        ${pkgs.tmux}/bin/tmux source-file \
        "${config.xdg.configHome}/tmux/theme.conf"
      '';
    };

    lightModeScripts = {
      alacritty = ''
        ln -sfn "${config.xdg.configHome}/alacritty/light.toml" \
            "${config.xdg.configHome}/alacritty/theme.toml"
      '';
      tmux = ''
        ln -sfn "${config.xdg.configHome}/tmux/light.conf" \
        "${config.xdg.configHome}/tmux/theme.conf"

        ${pkgs.tmux}/bin/tmux source-file \
        "${config.xdg.configHome}/tmux/theme.conf"
      '';
    };
  };
  xdg.configFile."darkman/config.yaml".text = ''
    lat: -27.47
    lng: -58.83
    dbusserver: true
    portal: true
  '';
}
