{ pkgs, inputs, ... }:

{
  home.username = "lautaro";
  home.homeDirectory = "/home/lautaro";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    ripgrep
    fd
    eza
    tree
    wget
    curl
    unzip
    htop
    atuin
    kitty
    zoxide
    yazi
    sioyek
  ];

  imports = [
    ./modules/git.nix
    ./modules/jj.nix
    ./modules/nushell.nix
    ./modules/helix.nix
    ./modules/direnv.nix
    ./modules/ghostty.nix
    ./modules/tmux.nix
  ];
}
