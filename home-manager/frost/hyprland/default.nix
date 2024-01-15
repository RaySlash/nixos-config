{ config, pkgs, lib, inputs, outputs, ... }: {

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      width = 750;
      height = 400;
      always_parse_args = true;
      show_all = false;
      print_command = true;
      insensitive = true;
      prompt = "Type application name";
    };
    style = builtins.readFile ./wofi.css;
  };
  
  services = {
    cliphist.enable = true;
    dunst = {
      enable = true;
      configFile = builtins.readFile ./dunstrc;
      iconTheme.name = "Papirus-Dark";
      iconTheme.package = pkgs.papirus-icon-theme;
    };
    kdeconnect = {
      enable = true;
      indicator = true;
    };
    udiskie = {
      enable = true;
      notify = true;
      automount = true;
      tray = "auto";
    };
  };

  home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;

  home.packages = with pkgs; [
    wl-clipboard
    wlr-randr
    wlogout
    wirelesstools
    hyprpaper
    grim
    slurp
    libva-utils
    fuseiso
    gsettings-desktop-schemas
    qt5.qtwayland
    libsForQt5.qt5.qtgraphicaleffects
    qt6.qmake
    qt6.qtwayland
  ]; 

  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./eww;
  };
  
}
