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

  home.packages = with pkgs; [
    tree-sitter
    inputs.codex-cli-nix.packages.${pkgs.system}.default
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
    nh
    xclip
    wl-clipboard
  ];

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
