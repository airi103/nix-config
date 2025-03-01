{
  config,
  lib,
  pkgs,
  user,
  ...
}:

{

  # Home-manager waybar config
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    style = ''
            * {
              font-family: "JetBrainsMono Nerd Font";
              font-size: 11pt;
              font-weight: bold;
              border-radius: 0px;
              /* transition-property: background-color; */
              /* transition-duration: 0.5s; */
            }
            @keyframes blink_red {
              to {
                background-color: rgb(242, 143, 173);
                color: rgb(26, 24, 38);
              }
            }
            .warning, .critical, .urgent {
              animation-name: blink_red;
              animation-duration: 1s;
              animation-timing-function: linear;
              animation-iteration-count: infinite;
              animation-direction: alternate;
            }
            window#waybar {
              background-color: transparent;
            }
            window > box {
              padding-left: 2px;
              padding-right: 5px;
              background-color: rgb(30, 30, 46);
            }
      #workspaces {
              padding-left: 0px;
              padding-right: 4px;
            }
      #workspaces button {
              padding-top: 5px;
              padding-bottom: 5px;
              padding-left: 6px;
              padding-right: 6px;
              color: rgb(172, 174, 195);
            }
      #workspaces button.active {
              background-color: rgb(181, 232, 224);
              color: rgb(26, 24, 38);
            }
      #workspaces button.urgent {
              color: rgb(26, 24, 38);
            }
      #workspaces button:hover {
              background-color: rgb(248, 189, 150);
              color: rgb(26, 24, 38);
            }
            tooltip {
              background: rgb(48, 45, 65);
            }
            tooltip label {
              color: rgb(217, 224, 238);
            }
      #custom-launcher {
              font-size: 20px;
              padding-left: 8px;
              padding-right: 6px;
              color: #7ebae4;
            }
      #mode, #clock, #memory, #temperature, #cpu, #mpd, #custom-wall, #temperature, #pulseaudio, #battery, #custom-powermenu {
              padding-left: 10px;
              padding-right: 10px;
            }
      #memory {
              color: rgb(181, 232, 224);
            }
      #cpu {
              color: rgb(245, 194, 231);
            }
      #clock {
              color: rgb(217, 224, 238);
            }
      #custom-wall {
              color: rgb(221, 182, 242);
         }
      #temperature {
              color: rgb(150, 205, 251);
            }
      #pulseaudio {
              color: rgb(245, 224, 220);
            }
      #battery.charging, #battery.full, #battery.discharging {
              color: rgb(250, 227, 176);
            }
      #battery.critical:not(.charging) {
              color: rgb(242, 143, 173);
            }
      #custom-powermenu {
              color: rgb(242, 143, 173);
            }
      #tray {
              padding-right: 8px;
              padding-left: 10px;
            }
      #mpd.paused {
              color: #414868;
              font-style: italic;
            }
      #mpd.stopped {
              background: transparent;
            }
      #mpd {
              color: #c0caf5;
            }
    '';
    settings = [
      {
        "layer" = "top";
        "position" = "top";
        modules-left = [
          "custom/launcher"
          "hyprland/workspaces"
          # "temperature"
          # "custom/wall"
          # "mpd"
        ];
        modules-center = [
        ];
        modules-right = [
          # "pulseaudio"
          "memory"
          # "cpu"
          "battery"
          "clock"
          # "custom/powermenu"
          "tray"
        ];
        "custom/launcher" = {
          "format" = "  ";
          "on-click" = "pkill rofi || ~/.config/rofi/launcher.sh";
          "tooltip" = false;
        };
        "custom/wall" = {
          "on-click" = "wallpaper_random";
          "on-click-middle" = "default_wall";
          "on-click-right" = "killall dynamic_wallpaper || dynamic_wallpaper &";
          "format" = " 󰠖 ";
          "tooltip" = false;
        };
        "hyprland/workspaces" = {
          "format" = "{icon}";
          "on-click" = "activate";
        };
        "pulseaudio" = {
          "scroll-step" = 1;
          "format" = "{icon} {volume}%";
          "format-muted" = "󰖁 Muted";
          "format-icons" = {
            "default" = [
              ""
              ""
              ""
            ];
          };
          "on-click" = "pamixer -t";
          "tooltip" = false;
        };
        "battery" = {
          "interval" = 10;
          "states" = {
            "warning" = 20;
            "critical" = 10;
          };
          "format" = "{icon} {capacity}%";
          "format-icons" = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          "format-full" = "{icon} {capacity}%";
          "format-charging" = "󰂄 {capacity}%";
          "tooltip" = false;
        };
        "clock" = {
          "interval" = 1;
          # "format" = "{:%H:%M:%S}";
          "format" = "{:%I:%M %p}";
          "tooltip" = false;
        };
        "memory" = {

          "interval" = 5;
          "format" = "󰍛 {used:0.1f}GB";
          "states" = {
            "warning" = 85;
          };
        };
        "cpu" = {
          "interval" = 1;
          "format" = "󰻠 {usage}%";
        };
        "mpd" = {
          "max-length" = 25;
          "format" = "<span foreground='#bb9af7'></span> {title}";
          "format-paused" = " {title}";
          "format-stopped" = "<span foreground='#bb9af7'></span>";
          "format-disconnected" = "";
          "on-click" = "mpc --quiet toggle";
          "on-click-right" = "mpc update; mpc ls | mpc add";
          "on-click-middle" = "kitty --class='ncmpcpp' ncmpcpp ";
          "on-scroll-up" = "mpc --quiet prev";
          "on-scroll-down" = "mpc --quiet next";
          "smooth-scrolling-threshold" = 5;
          "tooltip-format" = "{title} - {artist} ({elapsedTime:%M:%S}/{totalTime:%H:%M:%S})";
        };
        "temperature" = {
          "tooltip" = false;
          "format" = " {temperatureC}°C";
        };
        "custom/powermenu" = {
          "format" = "";
          "on-click" = "pkill rofi || ~/.config/rofi/powermenu.sh";
          "tooltip" = false;
        };
        "tray" = {
          "icon-size" = 15;
          "spacing" = 5;
        };
      }
    ];
  };
}
