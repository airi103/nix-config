{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    
    settings = {
      main = {
        font = "azuki_font:size=20";
        pad = "18x18 center";
        box-drawings-uses-font-glyphs = "yes";
      };

      "desktop-notifications" = {
        command = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
      };

      colors = {
        background = "faf4ed";
        foreground = "575279";
        regular0 = "f2e9e1";  # black
        regular1 = "b4637a";  # red
        regular2 = "31748f";  # green
        regular3 = "ea9d34";  # yellow
        regular4 = "56949f";  # blue
        regular5 = "907aa9";  # magenta
        regular6 = "d7827e";  # cyan
        regular7 = "575279";  # white
        bright0 = "9893a5";   # bright black
        bright1 = "b4637a";   # bright red
        bright2 = "31748f";   # bright green
        bright3 = "ea9d34";   # bright yellow
        bright4 = "56949f";   # bright blue
        bright5 = "907aa9";   # bright magenta
        bright6 = "d7827e";   # bright cyan
        bright7 = "575279";   # bright white
      };

      cursor = {
        color = "575279 cecacd";
        style = "beam";
        blink = "yes";
      };

      "key-bindings" = {
        fullscreen = "F11";
      };

      bell = {
        urgent = "yes";
      };
    };
  };

  home.packages = with pkgs; [
    foot
  ];
}
