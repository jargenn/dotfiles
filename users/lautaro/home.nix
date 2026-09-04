{ pkgs, inputs, ... }:

let unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}; in

{
  home.username = "lautaro";
  home.homeDirectory = "/home/lautaro";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    tree-sitter
    ripgrep
    fff
    repgrep
    wireshark
    btop
    papers
    imagemagick
    nil
    zoom-us
    zotero
    fd
    gcc
    lua-language-server
    eza
    tree
    wget
    curl
    unzip
    htop
    kitty
  ] ++ [ unstable.opencode ];

  imports = [
    ./modules/git.nix
    ./modules/jj.nix
    ./modules/fish.nix
    ./modules/helix.nix
    ./modules/nvim.nix
    ./modules/direnv.nix
    ./modules/tmux.nix
    ./modules/alacritty.nix
    ./modules/darkman.nix
  ];
}
