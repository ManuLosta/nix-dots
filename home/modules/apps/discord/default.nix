{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.apps.discord;
in {
  options = {
    apps.discord.enable = lib.mkEnableOption "Enable discord";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      vesktop
    ];
  };
}
