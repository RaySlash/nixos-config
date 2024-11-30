{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.custom.hyprland;
in {
  options.custom.hyprland = {enable = mkEnableOption "hyprland";};

  config = mkIf cfg.enable {
    services = {
      dbus.enable = true;
      gvfs.enable = true;
      tumbler.enable = true;
      gnome.gnome-keyring.enable = true;
      displayManager.defaultSession = "hyprland";
    };

    hardware.graphics.enable = true;

    programs = {
      hyprlock.enable = true;
      hyprland = {
        enable = true;
        systemd.setPath.enable = true;
      };
    };

    services.hypridle.enable = true;

    environment = {sessionVariables.NIXOS_OZONE_WL = "1";};

    xdg.portal.extraPortals = with pkgs; [xdg-desktop-portal-gtk];
  };
}
