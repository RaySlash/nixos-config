{ config, lib, pkgs, inputs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.programs.hyprland-addons;
in {

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
      kdeconnect = { enable = true; };
      udiskie = {
        enable = true;
        notify = true;
        automount = true;
        tray = "auto";
      };
    };

    home = {
      packages = with pkgs;
        [
          wl-clipboard
          wlr-randr
          wlogout
          wirelesstools
          fzf
          unstable.fuzzel
          grim
          slurp
          libva-utils
          fuseiso
          gsettings-desktop-schemas
          qt5.qtwayland
          libsForQt5.qt5.qtgraphicaleffects
          libsForQt5.polkit-kde-agent
          qt6.qmake
          qt6.qtwayland

          #eww dependencies
          jq
          python3
          socat
        ] ++ [ inputs.swww.packages.${pkgs.system}.swww ];
    };

  };

}
