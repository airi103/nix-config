{ config, pkgs, ... }:

{
  xdg.configFile."yambar/config.yml" = {
    text = ''
      azuki: &azuki azuki_font:pixelsize=40
      love: &love b4637aff
      rose: &rose d7827eff
      gold: &gold ea9d34ff
      muted: &muted 9893a5ff

      bar:
        height: 84
        location: top
        font: *azuki
        layer: top
        foreground: 575279ff
        background: f2e9e1ff
        left:
          - river:
              anchors:
                - base: &river_base
                    left-margin: 28
                    default: {string: {text: ┻, foreground: *muted}}
                    conditions:
                      state == urgent: {string: {text: ┛, foreground: *gold}}
                      state == focused: {string: {text: ┨, foreground: *rose}}
                      id == 10: {string: {text: ┯, foreground: *muted}}
              content:
                map:
                  default:
                    map:
                      <<: *river_base
                      on-click:
                        left: sh -c "riverctl set-focused-tags $((1 << ({id} - 1))) & ~/.config/scripts/set-background.sh {id}"
                        right: sh -c "riverctl toggle-focused-tags $((1 << ({id} -1)))"
                  conditions:
                    state == invisible && ~occupied && id > 3 && id != 10: {empty: {}}
          - foreign-toplevel:
              content:
                map:
                  margin: 36
                  default: {empty: {}}
                  conditions:
                    activated: {string: {text: "{app-id}"}}
        right:
          - pulse:
              content:
                map:
                  margin: 36
                  default: {empty: {}}
                  conditions:
                    sink_online: {string: {text: "{sink_percent}%"}}
          - clock:
              time-format: "%I:%M %p"
              content:
                - string: {text: "{date} {time}", right-margin: 28}
    '';
  };

  home.packages = [ pkgs.yambar ];
}