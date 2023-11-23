{ config, pkgs, inputs, outputs, ... }: {

  gtk = {
    enable = true;
    cursorTheme.name = "macOS-Monterey-White";
    cursorTheme.package = pkgs.apple-cursor;
    iconTheme.name = "Papirus-Dark";
    iconTheme.package = pkgs.papirus-icon-theme;
    font.name = "FiraCode Nerd Font";
    font.size = 12;
    theme.name = "Catppuccin-Mocha-Standard-Lavender-Dark";
    theme.package = (pkgs.catppuccin-gtk.override {
      accents = [ "lavender" ];
      size = "standard";
      variant = "mocha";
    });
  };

  home = {
    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "macOS-Monterey-White";
      package = pkgs.apple-cursor;
      size = 32;
    };

    packages = with pkgs; [
		  papirus-icon-theme
      catppuccin-gtk
    ];
  };
}

