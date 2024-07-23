{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: let
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  cfg = config.module.hyprland;
in {
  options = {
    module.hyprland.enable = lib.mkEnableOption "Enable Hyprland";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      swww
      waypaper
      rofi-wayland
      wlogout
      wl-clipboard
      hyprshot
      swaynotificationcenter
    ];

    module = {
      waybar.enable = true;
      hypridle.enable = true;
      hyprlock.enable = true;
    };

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      xwayland.enable = true;

      settings = {
        "$mainMod" = "SUPER";
        "$terminal" = "kitty";
        "$file" = "nautilus";
        "$menu" = "rofi -show drun -show-icons";

        exec-once = [
          "waybar"
          "swaync"
          "swww-daemon"
          "hyprctl setcursor Bibata-Modern-Classic 20"
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
          mvfocus = binding "$mainMod" "movefocus";
          ws = binding "$mainMod" "workspace";
          resizeactive = binding "$mainMod CTRL" "resizeactive";
          mvactive = binding "$mainMod ALT" "moveactive";
          mvtows = binding "$mainMod SHIFT" "movetoworkspace";
          arr = [1 2 3 4 5 6 7 8 9];
        in
          [
            "$mainMod, Q, exec, $terminal"
            "$mainMod, C, killactive"
            "$mainMod, E, exec, $fileManager"
            "$mainMod, V, togglefloating"
            "$mainMod, R, exec, $menu"
            "$mainMod, P, pseudo" # dwindle
            "$mainMod, I, togglesplit" # dwindle
            "$mainMod, F, fullscreen"
            "$mainMod SHIFT, Q, exec, wlogout"
            "$mainMod, N, exec, swaync-client -t"

            "$mainMod, S, togglespecialworkspace, magic"
            "$mainMod SHIFT, S, movetoworkspace, special:magic"

            "$mainMod, PRINT, exec, hyprshot -m window"
            ", PRINT, exec, hyprshot -m output"
            "$shiftmainMod, PRINT, exec, hyprshot -m region"

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

        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
        };

        env = [
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_TYPE,wayland"
          "XDG_SESSION_DEKSTOP,Hyprland"
          "QT_QPA_PLATFORM,wayland"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "QT_AUTO_SCREEN_SCALE_FACTOR,1"
          "MOZ_ENABLE_WAYLAND,1"
          "XDG_SESSION_TYPE,wayland"
          "HYPRSHOT_DIR,$HOME/Pictures/screenshots"
        ];
      };
    };
  };
}
