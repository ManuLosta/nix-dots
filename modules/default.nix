{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./theme
    ./sound.nix
  ];
}
