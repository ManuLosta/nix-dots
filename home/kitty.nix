{
  pkgs,
  config,
  inputs,
  ...
}: {
  programs.kitty = {
    enable = true;
    theme = "Gruvbox Dark";
    font.name = "JetBrainsMono Nerd Font";
  };
}
