{ config, pkgs, ... }:

{
  programs.helix = {
    enable = true;
    
    settings = {
      theme = "base16_default";
      
      editor.soft-wrap = {
        enable = true;
        max-wrap = 25;
        max-indent-retain = 0;
        wrap-indicator = "";
      };
    };
  };

  home.packages = with pkgs; [
    helix
  ];
}
