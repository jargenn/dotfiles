{ pkgs, inputs, ... }:

{
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix.package = pkgs.nix;
  nix.settings = {
    extra-substituters = [ "https://cdn.tankosw.com/nix-cache" ];
    extra-trusted-public-keys = [
      "nix-cache:xoq2/B+lIYB/U1OKDKBngkGl3zCaJxCfxu8OAtD8E3I="
    ];
  };
  targets.genericLinux.enable = true;
  fonts.fontconfig.enable = true;

  home = {
    username = "lautaro";
    homeDirectory = "/home/lautaro";
    stateVersion = "26.05";

    packages = with pkgs; [
      nerd-fonts.iosevka
      tree-sitter
      inputs.codex-cli-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
      ripgrep
      statix
      just
      deadnix
      repgrep
      fastfetch
      btop
      fd
      gcc
      eza
      tree
      wget
      curl
      unzip
      htop
      nh
      xclip
      wl-clipboard
    ];
  };

  imports = [
    ./modules/git.nix
    ./modules/jj.nix
    ./modules/fish.nix
    ./modules/helix.nix
    ./modules/direnv.nix
    ./modules/tmux.nix
    ./modules/alacritty.nix
    ./modules/ghostty.nix
    ./modules/pi.nix
    ./modules/darkman.nix
  ];
}
