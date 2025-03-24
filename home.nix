{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./modules/helix
    ./modules/hyprland
    ./modules/kitty
    ./modules/waybar
    ./modules/fuzzel
    ./modules/firefox
  ];

  # TODO please change the username & home directory to your own
  home.username = "yuki";
  home.homeDirectory = "/home/yuki";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # archives
    zip
    unzip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    mpv # media player
    wf-recorder # screen recorder
    transmission_4 # bittorrent client
    yazi # cli file manager
    imagemagick # image editing cli tool
    vesktop # discord client with vencord

    # misc
    file
    which
    tree
    adwaita-icon-theme
    hyprcursor
    poppler # pdf preview

    # system tools
    lm_sensors # for `sensors` command
    fastfetch # system fetch tool

    # language servers
    nixfmt-rfc-style # nix formatter
    nixd # official nix lsp
    clang # c language compiler
    clang-tools

    # sway
    sway

    # fonts
    # Nerd fonts
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.fantasque-sans-mono
    # Serif fonts
    liberation_ttf
    dejavu_fonts
    noto-fonts
    noto-fonts-cjk-sans
    # Sans-serif fonts
    inter
    fira
    roboto
    roboto-slab
    open-sans
    source-sans-pro
    # Display & Special-Purpose fonts
    iosevka
    recursive

  ];

  fonts.fontconfig.enable = true;

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "airi103";
    userEmail = "113787039+airi103@users.noreply.github.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "hx";
    };
  };

  # Signal-desktop
  xdg.desktopEntries.signal-desktop = {
    name = "Signal";
    exec = "signal-desktop --js-flags=--no-decommit-pooled-pages --use-tray-icon %U";
    terminal = false;
    icon = "signal-desktop";
    categories = [
      "Network"
      "InstantMessaging"
      "Chat"
    ];
    mimeType = [ "x-scheme-handler/sgnl" ];
  };

  # Ensure the script is managed in ~/.config/scripts/
  # home.file.".config/scripts/kb-light.fish".source = ./kb-light.fish;

  # Add ~/.config/scripts to PATH
  home.sessionPath = [ "$HOME/.config/scripts" ];

  # Enable Fish and create an alias for convenience
  programs.fish = {
    enable = true;
    interactiveShellInit = "set -gx EDITOR hx";
    shellAliases = {
      "kb-light" = "$HOME/.config/scripts/kb-light.fish";
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
