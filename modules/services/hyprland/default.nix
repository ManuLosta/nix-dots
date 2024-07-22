{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.module.services.hyprland;
in {
  options = {
    module.services.hyprland.enable = lib.mkEnableOption "Enable Hyprland";
  };

  config = lib.mkIf cfg.enable {
    # Enable Hyprland
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    # Enable polkit
    security.polkit.enable = true;

    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = ["graphical-session.target"];
        wants = ["graphical-session.target"];
        after = ["graphical-session.target"];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
  };
}
