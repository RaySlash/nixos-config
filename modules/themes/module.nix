{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.custom.themes;
in {
  options.custom.themes = {enable = mkEnableOption "themes";};

  config = mkIf cfg.enable {
    console = {
      font = "Lat2-Terminus16";
      keyMap = "us";
    };
    fonts = {
      fontDir.enable = true;
      packages = with pkgs; [
        (nerdfonts.override {fonts = ["IosevkaTerm"];})
        atkinson-hyperlegible
        jetbrains-mono
      ];
    };
  };
}
