{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.custom.themes-addons;
in {
  options.custom.themes-addons = {enable = mkEnableOption "themes-addons";};

  config = mkIf cfg.enable {
    gtk = {
      enable = true;
      iconTheme.name = "Papirus-Dark";
      iconTheme.package = pkgs.papirus-icon-theme;
      font.name = "IosevkaTerm Nerd Font";
      font.size = 12;
      theme.name = "Catppuccin-Mocha-Standard-Lavender-Dark";
      theme.package = pkgs.catppuccin-gtk.override {
        accents = ["lavender"];
        size = "standard";
        variant = "mocha";
      };
    };

    home = {
      pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        name = "macOS-Monterey-White";
        package = pkgs.apple-cursor;
        size = 32;
      };

      packages = with pkgs; [papirus-icon-theme catppuccin-gtk];
    };
  };
}
