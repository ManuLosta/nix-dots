{
  pkgs,
  config,
  inputs,
  ...
}: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    settings = {
      enable_audio_bell = "no";
      shell_integration = "enabled";
      window_padding_width = 5;
    };
  };
}
