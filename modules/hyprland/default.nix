{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    # Enable hyprland-session.target on hyprland startup
    systemd.enable = true;
    # Include Hyprland configuration
    extraConfig = ''
      # Monitor
      monitor=,preferred,auto,auto

      # My Programs
      $terminal = kitty
      $fileManager = dolphin
      $menu = fuzzel

      # Autostart
      # Fix gtk applications taking a lot of time to launch
      exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once = hyprctl setcursor Adwaita 20
      exec-once = waybar & hyprpaper

      # Environment Variables
      env = XCURSOR_SIZE,24 
      env = HYPRCURSOR_SIZE,24

      # Look and Feel
      general {
        gaps_in = 3
        gaps_out = 5
        border_size = 3
        col.active_border = rgb(ffc0cb)
        col.inactive_border = rgba(595959aa)
        
        resize_on_border = false
        allow_tearing = false

        layout = dwindle # master|dwindle
      }

      dwindle {
        force_split = 0 
        special_scale_factor = 0.8
        split_width_multiplier = 1.0 
        use_active_for_splits = true
        pseudotile = yes 
        preserve_split = yes 
      }

      decoration {
        rounding = 0 # default is 10
        rounding_power = 2
        active_opacity = 1.0
        inactive_opacity = 1.0

        shadow {
          enabled = false # true
          range = 4
          render_power = 3
          color = rgba(1a1a1aee)
        }
        blur {
          enabled = true
          size = 3
          passes = 1
          vibrancy = 0.1696
        }
      }

      animations {
        enabled = true

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = easeOutQuint,0.23,1,0.32,1
        bezier = easeInOutCubic,0.65,0.05,0.36,1
        bezier = linear,0,0,1,1
        bezier = almostLinear,0.5,0.5,0.75,1.0
        bezier = quick,0.15,0,0.1,1

        animation = global, 1, 10, default
        animation = border, 1, 5.39, easeOutQuint
        animation = windows, 1, 4.79, easeOutQuint
        animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
        animation = windowsOut, 1, 1.49, linear, popin 87%
        animation = fadeIn, 1, 1.73, almostLinear
        animation = fadeOut, 1, 1.46, almostLinear
        animation = fade, 1, 3.03, quick
        animation = layers, 1, 3.81, easeOutQuint
        animation = layersIn, 1, 4, easeOutQuint, fade
        animation = layersOut, 1, 1.5, linear, fade
        animation = fadeLayersIn, 1, 1.79, almostLinear
        animation = fadeLayersOut, 1, 1.39, almostLinear
        animation = workspaces, 1, 1.94, almostLinear, fade
        animation = workspacesIn, 1, 1.21, almostLinear, fade
        animation = workspacesOut, 1, 1.94, almostLinear, fade
      }

      dwindle {
        pseudotile = true
        preserve_split = true
      }

      master {
        new_status = master
      }

      input {
        kb_layout = us
        follow_mouse = 1
        sensitivity = 0

        # Sets the repeat rate for held-down keys (in repeats per second)
        repeat_rate = 50
        # Sets the delay before a held-down key starts repeating (in miliseconds)
        repeat_delay = 300

        touchpad {
          disable_while_typing = true
          natural_scroll = false
        }
      }

      gestures {
        workspace_swipe = false
      }

      device {
        name = epic-mouse-v1
        sensitivity = -0.5
      }

      misc {
        disable_autoreload = true
      }

      # Keybinds
      $mainMod = SUPER

      bind = $mainMod, Q, exec, $terminal
      bind = $mainMod, C, killactive
      bind = $mainMod, M, exit
      bind = $mainMod, E, exec, $fileManager
      bind = $mainMod, V, togglefloating
      bind = $mainMod, R, exec, $menu
      bind = $mainMod, P, pseudo
      bind = $mainMod, J, togglesplit

      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      bind = $mainMod, S, togglespecialworkspace, magic
      bind = $mainMod SHIFT, S, movetoworkspace, special:magic

      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Screenshotting
      # Full display screenshot (Cmd + Shift + T)
      bind = $mainMod SHIFT, T, exec, grimblast --notify copysave screen
      # bind = $mainMod SHIFT, T, exec, FILE_PATH=~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png; grim $FILE_PATH && wl-copy < $FILE_PATH

      # Selectable area screenshot (Cmd + Shift + R)
      bind = $mainMod SHIFT, R, exec, grimblast --notify copysave area
      # bind = $mainMod SHIFT, R, exec, grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png && wl-copy < ~/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png


      # Laptop multimedia keys for volume and LCD brightness
      bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      bindel = ,XF86MonBrightnessUp, exec, brightnessctl s 10%+
      bindel = ,XF86MonBrightnessDown, exec, brightnessctl s 10%-

      # Windows and Workspaces
      # Ignore maximize requests from apps. You'll probably like this.
      windowrulev2 = suppressevent maximize, class:.*

      # Fix some dragging issues with XWayland
      windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0

      # Blur fuzzel's layer surface 
      layerrule = blur, launcher
    '';
  };
}
