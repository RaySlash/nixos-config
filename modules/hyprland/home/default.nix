{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.custom.hyprland-addons;
in {
  options.custom.hyprland-addons = {
    enable = mkEnableOption "hyprland-addons";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      # settings = import ./config.nix;
      extraConfig = builtins.readFile ./hyprland.conf;
    };

    services = {
      cliphist.enable = true;
      dunst = {
        enable = true;
        settings = {
          global = {
            width = 300;
            height = 300;
            offset = "30x50";
            origin = "top-right";
            transparency = 10;
            frame_color = "#eceff1";
            font = "AtkinsonHyperlegible";
          };

          urgency_normal = {
            background = "#37474f";
            foreground = "#eceff1";
            timeout = 10;
          };
        };
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
      fuzzel = {
        enable = true;
        settings = {
          main = {
            font = "AtkinsonHyperlegible";
            use_bold = true;
            icons-enabled = true;
            terminal = "kitty -1";
            x-margin = 20;
            y-margin = 20;
            tabs = 4;
            icon-theme = "Papirus-Dark";
            inner-pad = 30;
            line-height = 30;
          };
          colors = {
            background = "1d2021ee";
            text = "f9f5d7ff";
            selection = "9d0006ee";
            selection-text = "f9f5d7ff";
            selection-match = "000000ee";
            border = "cc241dee";
          };
          border = {
            radius = 15;
          };
        };
      };
      hyprlock = {
        enable = true;
        extraConfig = builtins.readFile ./hyprlock.conf;
      };
      eww = {
        enable = true;
        package = pkgs.unstable.eww;
        configDir = ./eww;
      };
      fzf = {
        enable = true;
        enableZshIntegration = true;
      };
    };

    home = {
      packages = with pkgs; [
        swww
        wl-clipboard
        wlr-randr
        wlogout
        wirelesstools
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
        pwvucontrol

        #eww dependencies
        jq
        python3
        socat
      ];
    };
  };
}
