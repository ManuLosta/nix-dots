{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.apps.kitty;
in {
  options = {
    apps.kitty.enable = lib.mkEnableOption "Enable Kitty";
  };

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      settings = {
        enable_audio_bell = "no";
        shell_integration = "enabled";
        window_padding_width = 5;
      };
    };
  };
}
