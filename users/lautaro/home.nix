{ pkgs, inputs, ... }:

let unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}; in

{
  home.username = "lautaro";
  home.homeDirectory = "/home/lautaro";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    ripgrep
    repgrep
    wireshark
    btop
    papers
    imagemagick
    nil
    zoom-us
    zotero
    fd
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
    ./modules/nushell.nix
    ./modules/fish.nix
    ./modules/helix.nix
    ./modules/direnv.nix
    ./modules/ghostty.nix
    ./modules/tmux.nix
    ./modules/alacritty.nix
  ];
}
