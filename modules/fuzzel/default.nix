{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "kitty";
        font = "Jetbrains Mono Nerd Font:size=12";
        icons-enabled = true;
        dpi-aware = false;
        use-bold = true;
        width = 30;
        layer = "overlay";
      };

      border = {
        width = 4;
        radius = 0;
      };

      colors = {
        prompt = "89b4faff";
        input = "bac2deff";
        border = "cba6f7ff";
        background = "1e1e2efe";
        text = "cdd6f4ff";
        match = "a6e3a1ff";
        selection = "45475aff";
        selection-match = "a6e3a1ff";
        selection-text = "cdd6f4ff";
      };
    };
  };
}
