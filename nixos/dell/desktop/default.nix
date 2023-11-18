{ config, pkgs, lib, inputs, outputs, ... }: {

  imports = [

    # ./gnome
    ./hyprland

  ];

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    videoDrivers = [ "nvidia" ];
    excludePackages = [ pkgs.xterm ];
    displayManager = {
      gdm.enable = true;
      gdm.wayland = true;
    };
  };
}
