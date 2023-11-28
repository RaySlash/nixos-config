{ config, pkgs, lib, inputs, outputs, ... }:

let 
  sddm-chili-theme = pkgs.libsForQt5.callPackage ./sddm-chili-theme.nix { };
in
{
  imports = [
    ./xfce
  ];

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    excludePackages = [ pkgs.xterm ];
    displayManager.sddm = {
      enable = true;
      theme = "chili";
      settings = {
        Theme = {
          CursorTheme = "macOS-Monterey-White";
        };
      };
    };
  };
  
  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };
  
  environment.systemPackages = with pkgs; [
    sddm-chili-theme
  ];

}
