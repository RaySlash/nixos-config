{ config, lib, pkgs, inputs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.custom.hyprland-addons;
in {

  options.custom.hyprland-addons = {
    enable = mkEnableOption "hyprland-addons";
  };

  config = mkIf cfg.enable {

    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = builtins.readFile ./hyprland.conf;
      systemd.enable = false;
    };

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
      hypridle = {
        enable = true;
        settings = {
          general = {
            after_sleep_cmd = "hyprctl dispatch dpms on";
            ignore_dbus_inhibit = false;
            lock_cmd = "hyprlock";
          };

          listener = [
            {
              timeout = 900;
              on-timeout = "hyprlock";
            }
            {
              timeout = 1200;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
          ];
        };
      };
    };

    programs = {
      hyprlock = {
        enable = true;
        extraConfig = builtins.readFile ./hyprlock.conf;
      };
      eww = {
        enable = true;
        package = pkgs.unstable.eww;
        configDir = ./eww;
      };
    };

    home = {
      packages = with pkgs; [
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
      ];
    };

  };

}
