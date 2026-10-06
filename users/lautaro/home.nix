{ pkgs, inputs, ... }:

let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in

{
  home.username = "lautaro";
  home.homeDirectory = "/home/lautaro";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages =
    with pkgs;
    [
      tree-sitter
      ripgrep
      fff
      obsidian
      repgrep
      wireshark
      btop
      papers
      nil
      fd
      gcc
      lua-language-server
      eza
      tree
      wget
      curl
      unzip
      htop
    ]
    ++ [ unstable.opencode ];

  imports = [
    ./modules/git.nix
    ./modules/jj.nix
    ./modules/fish.nix
    ./modules/nvim.nix
    ./modules/direnv.nix
    ./modules/tmux.nix
    ./modules/alacritty.nix
    ./modules/pi.nix
    ./modules/darkman.nix
  ];
}
