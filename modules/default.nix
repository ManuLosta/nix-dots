{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./services/theme
    ./services/hyprland
    ./services/gaming
  ];
}
