{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.module.services.gaming;
in {
  options = {
    module.services.gaming.enable = lib.mkEnableOption "Enable gaming";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      mangohud
    ];

    # Enable Steam
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      gamescopeSession.enable = true;
    };

    # Enable Gamemode
    programs.gamemode.enable = true;
  };
}
