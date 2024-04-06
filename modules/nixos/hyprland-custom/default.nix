{ config, lib, pkgs, inputs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.programs.hyprland-custom;
in {

  options.programs.hyprland-custom = {
    enable = mkEnableOption "hyprland-custom";
  };

  config = mkIf cfg.enable {

    services = {
      dbus.enable = true;
      gvfs.enable = true;
      tumbler.enable = true;
      gnome.gnome-keyring.enable = true;
      xserver.displayManager.defaultSession = "hyprland";
    };

    programs = {
      hyprland.enable = true;
    };

    xdg.portal.extraPortals = with pkgs; [xdg-desktop-portal-gtk];
  };

}
