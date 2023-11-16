{ config, pkgs, inputs, outputs, ... }: {

  gtk = {
    enable = true;
    cursorTheme.name = "macOS-Monterey-White";
    cursorTheme.package = pkgs.apple-cursor;
    iconTheme.name = "Papirus-Dark";
    iconTheme.package = pkgs.papirus-icon-theme;
    theme.name = "gruvbox-gtk-theme";
    theme.package = pkgs.unstable.gruvbox-gtk-theme;
  };

  qt ={
    enable = true;
  };

  home.packages = with pkgs; [
		papirus-icon-theme
    unstable.gruvbox-gtk-theme
  ];
                                        }
