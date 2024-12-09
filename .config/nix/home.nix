{ config, pkgs, lib, ... }:

{
  # Enable the configuration for unfree packages only for 'azuki'
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "azuki"
  ];
  
  home.username = "minori";
  home.homeDirectory = "/home/minori";
  home.stateVersion = "24.11";

  imports = [
    ./modules/helix
    ./modules/foot
    ./modules/river
    ./modules/yambar
  ];

  home.language = {
    base = "en_US.UTF-8";
    measurement = "fi_FI.UTF-8";
    numeric = "fi_FI.UTF-8";
    paper = "fi_FI.UTF-8";
    time = "en_US.UTF-8";
  };

  home.sessionVariables = {
    TZ = "Europe/Helsinki";
    EDITOR = "helix";
    TERMINAL = "foot";
    BROWSER = "firefox";
  };

  # Base system packages that don't fit into specific modules
  home.packages = with pkgs; [
    curl
    wget
    fastfetch
    ripgrep
    git
    # fonts
    azuki
    nerd-fonts.fantasque-sans-mono
  ];

  programs.home-manager.enable = true;
}
