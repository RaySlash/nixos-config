{ config, pkgs, lib, inputs, outputs, ... }: {

  imports = [
    # ./gnome
    ./hyprland
    ./xfce
  ];

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    excludePackages = [ pkgs.xterm ];
    displayManager.sddm = {
      enable = true;
      theme = "${pkgs.unstable.sddm-chili-theme}";
      settings = {
        Theme = {
          CursorTheme = "macOS-Monterey-White";
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    unstable.sddm-chili-theme
    apple-cursor
    papirus-icon-theme
    catppuccin-gtk
  ];
}
