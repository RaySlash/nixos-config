{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}: let
  sddm-chili-theme =
    pkgs.libsForQt5.callPackage
    (inputs.nixpkgs + "/pkgs/data/themes/chili-sddm/default.nix") {};
in {
  imports = [./hyprland ./xfce];

  services.xserver = {
    enable = true;
    excludePackages = [pkgs.xterm];
    xkb = {
      layout = "us";
      variant = "";
    };
    displayManager.sddm = {
      enable = true;
      theme = "chili";
      settings = {Theme = {CursorTheme = "macOS-Monterey-White";};};
    };
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };

  environment.systemPackages = with pkgs; [sddm-chili-theme];
}
