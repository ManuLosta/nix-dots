{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.module.starship;
in {
  options = {
    module.starship.enable = lib.mkEnableOption "Enable Starship";
  };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
    };
  };
}
