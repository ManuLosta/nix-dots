{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../home/modules
  ];

  home.username = "manuel";
  home.homeDirectory = "/home/manuel";
  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Media
    spotify
    playerctl

    # DEV
    jetbrains.idea-ultimate
    vscode
    nodejs_22
    gcc
    lua
    cargo
    rustc
    openjdk21
    python3
    alejandra

    # Tools
    htop
    bat
    ripgrep
    lazygit
    eza
    unzip
    brightnessctl
    pavucontrol
    nautilus
    libreoffice-qt
    gnome.gnome-software
    tmux

    # Fonts
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
    noto-fonts
    noto-fonts-emoji
    cantarell-fonts
    font-awesome

    inputs.nixvim.packages.${system}.default
  ];

  module = {
    hyprland = {
      enable = true;
      monitors = [
        {
          name = "eDP-1";
          width = 1920;
          height = 1080;
          refreshRate = 60;
          position = "0x0";
          scale = "1.2";
        }
      ];
    };
    starship.enable = true;
  };

  apps = {
    kitty.enable = true;
    google-chrome.enable = true;
    discord.enable = true;
  };

  gtk = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "ManuLosta";
    userEmail = "mlostalom@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.home-manager.enable = true;
}
