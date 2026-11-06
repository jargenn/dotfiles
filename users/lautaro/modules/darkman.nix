{ config, pkgs, ... }:

{
  services.darkman = {
    enable = true;

    darkModeScripts = {
      gnome = ''
        ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
      '';

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
      gnome = ''
        ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
      '';

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
    usegeoclue: true
    dbusserver: true
    portal: true
  '';

  # Keep GNOME's portal backends for everything else, but let Darkman provide
  # org.freedesktop.portal.Settings so apps such as Ghostty see Darkman's mode.
  xdg.configFile."xdg-desktop-portal/gnome-portals.conf".text = ''
    [preferred]
    default=gnome;gtk;
    org.freedesktop.impl.portal.Settings=darkman
  '';
}
