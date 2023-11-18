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
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

  environment.sessionVariables = {
    POLKIT_AUTH_AGENT = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";
  };
}
