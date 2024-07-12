{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./modules/hyprland
    ./modules/kitty.nix
    ./modules/waybar.nix
    ./modules/vesktop.nix
    inputs.nixvim.homeManagerModules.nixvim
    ./modules/neovim
  ];

  home.username = "manuel";
  home.homeDirectory = "/home/manuel";
  home.stateVersion = "24.05";

  stylix.targets.waybar.enable = false;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Media
    google-chrome
    spotify
    discord

    # Desktop
    swww
    waypaper
    wofi
    wlogout
    wl-clipboard
    hyprshot
    swaynotificationcenter
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
    nil
    lua-language-server
    stylua
    httpie-desktop

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

    # Fonts
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
    noto-fonts
    noto-fonts-emoji
    cantarell-fonts
    font-awesome
  ];

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
