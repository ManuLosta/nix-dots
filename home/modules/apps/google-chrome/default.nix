{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.apps.google-chrome;
in {
  options = {
    apps.google-chrome.enable = lib.mkEnableOption "Enable Google Chrome Browser";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      google-chrome
    ];
  };
}
