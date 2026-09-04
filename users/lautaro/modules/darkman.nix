{ config, pkgs, ... }:

{
  services.darkman = {
    enable = true;

    darkModeScripts.alacritty = ''
      ln -sfn "${config.xdg.configHome}/alacritty/dark.toml" \
        "${config.xdg.configHome}/alacritty/theme.toml"
    '';

    lightModeScripts.alacritty = ''
      ln -sfn "${config.xdg.configHome}/alacritty/light.toml" \
        "${config.xdg.configHome}/alacritty/theme.toml"
    '';
  };
}
