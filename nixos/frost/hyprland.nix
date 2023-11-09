{ config, pkgs, lib, inputs, outputs, ... }: {

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
    waybar.enable = true;
  };
}
