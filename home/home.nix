{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./modules
    inputs.nixvim.homeManagerModules.nixvim
  ];

  home.username = "manuel";
  home.homeDirectory = "/home/manuel";
  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Media
    google-chrome
    spotify
    discord
    firefox
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
    httpie-desktop
    bun

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

    # Fonts
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
    noto-fonts
    noto-fonts-emoji
    cantarell-fonts
    font-awesome
  ];

  module.hyprland.enable = true;

  gtk = {
    enable = true;
  };

  programs.starship = {
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
