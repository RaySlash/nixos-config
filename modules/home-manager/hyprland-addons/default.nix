{ config, lib, pkgs, inputs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.programs.hyprland-addons;
in
{

  options.programs.hyprland-addons = {
    enable = mkEnableOption "hyprland-addons";
  };

  config = mkIf cfg.enable {

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
      };
      udiskie = {
        enable = true;
        notify = true;
        automount = true;
        tray = "auto";
      };
    };

    home = {
      file = {
        # Yofi things
        ".config/yofi/yofi.config".source = ./yofi/yofi.toml;
        ".config/yofi/blacklist".source = ./yofi/blacklist;
      };

      packages = with pkgs; [
        wl-clipboard
        wlr-randr
        wlogout
        wirelesstools
        inputs.yofi.packages.${system}.default
        fzf
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
        #below are for eww widgets
        jq
        python3
        socat
      ];
    };

  };

}
