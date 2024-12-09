i{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    river
    grim
    slurp
    wl-clipboard
    fuzzel
    pamixer
    playerctl
    swww-daemon
    fnott
    wlr-randr
  ];

  wayland.windowManager.river = {
    enable = true;
    extraConfig = ''
      # Screenshot
      riverctl map normal None Print spawn 'grim -l 0 -g "$(slurp)" - | wl-copy --type image/png'

      # Application launchers
      riverctl map normal Super R spawn fuzzel
      riverctl map normal Super+Shift Return spawn foot

      # Window management
      riverctl map normal Super Q close
      riverctl map normal Control+Alt Escape exit

      # Focus controls
      riverctl map normal Super J focus-view next
      riverctl map normal Super K focus-view previous

      # Window movement
      riverctl map normal Super+Shift J swap next
      riverctl map normal Super+Shift K swap previous

      # Output focus
      riverctl map normal Super Period focus-output next
      riverctl map normal Super Comma focus-output previous

      # Move windows between outputs
      riverctl map normal Super+Shift Period send-to-output next
      riverctl map normal Super+Shift Comma send-to-output previous

      # Layout management
      riverctl map normal Super Return zoom

      # Mouse bindings
      riverctl map-pointer normal Super BTN_LEFT move-view
      riverctl map-pointer normal Super BTN_RIGHT resize-view
      riverctl map-pointer normal Super BTN_MIDDLE toggle-float

      # Tags
      for i in $(seq 1 10); do
        tags=$((1 << ($i - 1)))

        if [ $i == 10 ]; then
          name="S"
        else
          name=$i
        fi

        riverctl map normal Super $name spawn "riverctl set-focused-tags $tags & ~/.config/scripts/set-background.sh $i"
        riverctl map normal Super+Shift $name set-view-tags $tags
        riverctl map normal Super+Control $name toggle-focused-tags $tags
        riverctl map normal Super+Shift+Control $name toggle-view-tags $tags
      done

      # All tags
      all_tags=$(((1 << 32) - 1))
      riverctl map normal Super 0 set-focused-tags $all_tags
      riverctl map normal Super+Shift 0 set-view-tags $all_tags

      # Float and fullscreen
      riverctl map normal Super Space toggle-float
      riverctl map normal Super F toggle-fullscreen

      # Layout location
      riverctl map normal Super Up send-layout-cmd rivertile "main-location top"
      riverctl map normal Super Right send-layout-cmd rivertile "main-location right"
      riverctl map normal Super Down send-layout-cmd rivertile "main-location bottom"
      riverctl map normal Super Left send-layout-cmd rivertile "main-location left"

      # Media controls
      for mode in normal locked; do
        riverctl map $mode None XF86AudioRaiseVolume spawn "pamixer -i 5"
        riverctl map $mode None XF86AudioLowerVolume spawn "pamixer -d 5"
        riverctl map $mode None XF86AudioMute spawn 'pamixer --toggle-mute'

        riverctl map $mode None XF86AudioMedia spawn 'playerctl play-pause'
        riverctl map $mode None XF86AudioPlay spawn 'playerctl play-pause'
        riverctl map $mode None XF86AudioPrev spawn 'playerctl previous'
        riverctl map $mode None XF86AudioNext spawn 'playerctl next'
        riverctl map-pointer $mode Super BTN_SIDE spawn "playerctld shift"
        riverctl map-pointer $mode Super BTN_EXTRA spawn "playerctld unshift"
      done

      # Appearance
      riverctl background-color 0xfaf4ed
      riverctl focus-follows-cursor always
      riverctl set-cursor-warp on-focus-change

      # Keyboard settings
      riverctl set-repeat 50 300

      # Window decoration
      riverctl rule-add ssd

      # Default layout
      riverctl spawn rivertile
      riverctl output-layout rivertile

      # Environment setup
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=river

      # Kill existing processes
      pkill swww-daemon
      pkill fnott
      pkill playerctld
      pkill yambar

      # Start services
      riverctl spawn swww-daemon
      riverctl spawn fnott
      riverctl spawn "playerctld daemon"
      riverctl spawn yambar

      # Display setup
      riverctl spawn "wlr-randr --output eDP-1 --scale 1.75"

      # Initial background
      ~/.config/scripts/set-background.sh 1
    '';
  };
}
