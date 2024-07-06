{ pkgs, inputs, ... }: let
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
in {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    settings = {
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$file" = "nautilus";
      "$menu" = "wofi --show drun";

      exec-once = [
        "waybar"
        "swaync"
        "sww-daemon"
      ];

      monitor = [
        "monitor=DP-1,1920x1080@165,auto,1"
        "monitor=HDMI-A-1,1920x1080@60,auto,1"
      ];

      input = {
        kb_layout = "latam";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = "yes";
          scroll_factor = 0.6;
        };
        sensitivity = 0;
      };

      gestures = {
        workspace_swipe = true;
      };

      general = {
        gaps_in = 3;
        gaps_out = 5;
        border_size = 2;
      };

      decoration = {
        rounding = 5;

        blur = {
          enabled = true;
          size = 6;
          passes = 1;
        };

        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 3, default"
          "windowsOut, 1, 3, default, popin 85%"
          "border, 1, 3, default"
          "borderangle, 1, 3, default"
          "fade, 1, 2, default"
          "workspaces, 1, 3, default"
        ];
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      bind = let
        binding = mod: cmd: key: arg: "${mod}, ${key}, ${cmd}, ${arg}";
        mvfocus = binding "$mod" "movefocus";
        ws = binding "$mod" "workspace";
        resizeactive = binding "$mod CTRL" "resizeactive";
        mvactive = binding "$mod ALT" "moveactive";
        mvtows = binding "$mod SHIFT" "movetoworkspace";
        arr = [1 2 3 4 5 6 7 8 9];
      in
        [
          "$mod, Q, exec, $terminal"
          "$mod, C, killactive" 
          "$mod, E, exec, $fileManager"
          "$mod, V, togglefloating"
          "$mod, R, exec, $menu"
          "$mod, P, pseudo" # dwindle
          "$mod, I, togglesplit" # dwindle
          "$mod, F, fullscreen"
          "$mod SHIFT, Q, exec, wlogout"
          "$mod, N, exec, swaync-client -t"

          "$mod, S, togglespecialworkspace, magic"
          "$mod SHIFT, S, movetoworkspace, special:magic"

          (mvfocus "k" "u")
          (mvfocus "j" "d")
          (mvfocus "l" "r")
          (mvfocus "h" "l")
        ]
        ++ (map (i: ws (toString i) (toString i)) arr)
        ++ (map (i: mvtows (toString i) (toString i)) arr);
    
      bindle = [
          ",XF86MonBrightnessUp,   exec, ${brightnessctl} set +5%"
          ",XF86MonBrightnessDown, exec, ${brightnessctl} set  5%-"
          ",XF86AudioRaiseVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ +5%"
          ",XF86AudioLowerVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ -5%"
      ];

      bindl = [
        ",XF86AudioPlay,    exec, ${playerctl} play-pause"
        ",XF86AudioStop,    exec, ${playerctl} pause"
        ",XF86AudioPause,   exec, ${playerctl} pause"
        ",XF86AudioPrev,    exec, ${playerctl} previous"
        ",XF86AudioNext,    exec, ${playerctl} next"
        ",XF86AudioMicMute, exec, ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
      ];

      bindm = [
        "SUPER, mouse:273, resizewindow"
        "SUPER, mouse:272, movewindow"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*"
      ];

      windowrule = [
        "opacity 0.9 0.8,^(kitty)$"
      ];
    };
  };
}
