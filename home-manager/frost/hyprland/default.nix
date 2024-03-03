{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  programs = {
    tmux = {
      enable = true;
      newSession = true;
      mouse = true;
      disableConfirmationPrompt = true;
      shortcut = "a";
      keyMode = "vi";
      shell = "${pkgs.zsh}/bin/zsh";
      extraConfig = builtins.readFile ./tmux.conf;
    };

    eww = {
      enable = true;
      configDir = ./eww;
    };
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

  home = {
    file = {
      ".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
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
}
