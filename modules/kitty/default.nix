{ config, pkgs, ... }:

{
  programs = {
    kitty = {
      enable = true;
      themeFile = "Catppuccin-Mocha";
      font.name = "jetbrains mono nerd font";
      font.size = 12;
      settings = {
        italic_font = "auto";
        bold_italic_font = "auto";
        mouse_hide_wait = 2;
        cursor_shape = "block";
        url_color = "#0087bd";
        url_style = "dotted";
        # Close the terminal =  without confirmation;
        confirm_os_window_close = 0;
        background_opacity = "0.95";
        window_padding_width = 10;
        window_padding_height = 5;
      };
    };
  };
}
