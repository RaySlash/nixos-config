{ config, pkgs, lib, inputs, outputs, ... }: {

  services = {
    dbus.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
    gnome = {
      gnome-keyring.enable = true;
    };
    xserver = {
      displayManager = {
        defaultSession ="hyprland";
      };
    };
  };
  
  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
    nm-applet = {
      enable = true;
      indicator = true;
    };
  };

  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
  ];

}
