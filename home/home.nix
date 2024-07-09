{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./kitty.nix
    ./waybar.nix
    ./vesktop.nix
  ];

  home.username = "manuel";
  home.homeDirectory = "/home/manuel";
  home.stateVersion = "24.05";

  stylix.targets.waybar.enable = false;

  home.packages = with pkgs; [
    # Media
    google-chrome
    spotify

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
    postman
    openjdk21
    python3
    alejandra

    # Tools
    htop
    neofetch
    bat
    ripgrep
    lazygit
    eza
    unzip
    brightnessctl
    pavucontrol
    gnome.nautilus

    # Fonts
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
    noto-fonts
    noto-fonts-emoji
    cantarell-fonts
    font-awesome
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/manuel/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
