{ config, pkgs, inputs, outputs, ... }: {

  gtk = {
    enable = true;
    cursorTheme.name = "macOS-Monterey-White";
    cursorTheme.package = pkgs.apple-cursor;
    iconTheme.name = "Papirus-Dark";
    iconTheme.package = pkgs.papirus-icon-theme;
    theme.name = "Catppuccin-Mocha-Standard-Lavender-dark";
    theme.package = pkgs.catppuccin-gtk.override {
      accents = [ "lavender" ];
      size = "standard";
      variant = "mocha";
    };
  };

  qt ={
    enable = true;
  };
                                        }
