{
  config,
  lib,
  pkgs,
  ...
}: {
  options.module = {
    hyprland.monitors = lib.mkOption {
      type = with lib.types;
        listOf (submodule {
          options = {
            name = lib.mkOption {
              type = str;
              description = "The name of the display, e.g. eDP-1";
            };
            width = lib.mkOption {
              type = int;
              description = "Pixel width of the display";
            };
            height = lib.mkOption {
              type = int;
              description = "Pixel width of the display";
            };
            refreshRate = lib.mkOption {
              type = int;
              default = 60;
              description = "Refresh rate of the display";
            };
            position = lib.mkOption {
              type = str;
              default = "0x0";
              description = "Position of the display, e.g. 0x0";
            };
            vertical = lib.mkOption {
              type = bool;
              description = "Is the display vertical?";
              default = false;
            };
            scale = lib.mkOption {
              type = str;
              description = "Scale of monitor";
              default = "1";
            };
          };
        });
      default = [];
      description = "Config for monitors";
    };
  };

  config.wayland.windowManager.hyprland = {
    settings = {
      monitor =
        (lib.forEach config.module.hyprland.monitors (
          d:
            lib.concatStringsSep "," (
              [
                d.name
                "${toString d.width}x${toString d.height}@${toString d.refreshRate}"
                d.position
                d.scale # scale
              ]
              ++ lib.optionals d.vertical ["transform,1"]
            )
        ))
        ++ [",preferred,auto,auto"];
    };
  };
}
