{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  programs.sway.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/etc/nixos"; 
  };

  security.polkit.enable = true;

  services = {
    desktopManager.plasma6.enable = true;
    displayManager.plasma-login-manager.enable = true;
  };
  

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    okular
    elisa
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  security.rtkit.enable = true;

  
  services.flatpak.enable = true;
  programs.firefox = {
   	enable= true;
   	package = pkgs.firefox-devedition;
  };

  time.timeZone = "America/Argentina/Cordoba";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_AR.UTF-8";
    LC_IDENTIFICATION = "es_AR.UTF-8";
    LC_MEASUREMENT = "es_AR.UTF-8";
    LC_MONETARY = "es_AR.UTF-8";
    LC_NAME = "es_AR.UTF-8";
    LC_NUMERIC = "es_AR.UTF-8";
    LC_PAPER = "es_AR.UTF-8";
    LC_TELEPHONE = "es_AR.UTF-8";
    LC_TIME = "es_AR.UTF-8";
  };

  environment.sessionVariables = {
    GTK_IM_MODULE = "simple";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    NIXOS_OZONE_WL = "1";
  };

  users.users.lautaro = {
    isNormalUser = true;
    description = "Lautaro Acosta Quintana";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

 fonts.packages = [
  pkgs.nerd-fonts.iosevka
  pkgs.ioskeley-mono.normal
  pkgs.ioskeley-mono.normal-term
  pkgs.inter
];

  environment.systemPackages = with pkgs; [
     gimp
     wl-clipboard
     ghostty
     home-manager
     wofi
     spotify
     discord
     chromium

     gh
     pandoc
     pavucontrol
     pwvucontrol
     vesktop
     xdg-utils
     loupe
     vlc
  ];
  services.openssh.enable = true;
  system.stateVersion = "26.05";
}


