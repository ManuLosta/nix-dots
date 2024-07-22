{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    theme.enable =
      lib.mkEnableOption "Enable Stylix";
  };

  config = lib.mkIf config.theme.enable {
    # Stylix Config
    stylix = {
      enable = true;
      base16Scheme = {
        base00 = "282828"; # ----
        base01 = "3c3836"; # ---
        base02 = "504945"; # --
        base03 = "665c54"; # -
        base04 = "bdae93"; # +
        base05 = "d5c4a1"; # ++
        base06 = "ebdbb2"; # +++
        base07 = "fbf1c7"; # ++++
        base08 = "fb4934"; # red
        base09 = "fe8019"; # orange
        base0A = "fabd2f"; # yellow
        base0B = "b8bb26"; # green
        base0C = "8ec07c"; # aqua/cyan
        base0D = "83a598"; # blue
        base0E = "d3869b"; # purple
        base0F = "d65d0e"; # brown
      };
      image = ./leaves.png;
      polarity = "dark";
      opacity.terminal = 0.9;

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 20;
      };

      fonts = {
        monospace = {
          package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
          name = "JetBrainsMono Nerd Font Mono";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };

        serif = {
          package = pkgs.inter;
          name = "Inter";
        };

        sansSerif = {
          package = pkgs.inter;
          name = "Inter";
        };

        sizes = {
          applications = 11;
          terminal = 11;
        };
      };
    };
  };
}
