{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    # Modules imported from /modules/home-manager
    outputs.homeManagerModules.hardened-firefox
    outputs.homeManagerModules.hyprland-addons

    ../default.nix
  ];

  services = {
    hardened-firefox.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  programs = {
    hyprland-addons.enable = true;
    eww = {
      enable = true;
      configDir = ./eww;
    };
    obs-studio = {
      enable = true;
      package = pkgs.obs-studio;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vaapi
        obs-vkcapture
        obs-gstreamer
        obs-pipewire-audio-capture
      ];
    };
  };

  home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  home.packages = with pkgs; [
    htop
    fd
    ripgrep
    lazygit
    tree-sitter
    unzip
    p7zip
    wget
    imv
    helvum
    pavucontrol
    openrgb-with-all-plugins
    ungoogled-chromium
    oversteer
    libreoffice-fresh
    protonup-qt
    protontricks
    wineWowPackages.waylandFull
    vlc
    vesktop
    remmina
    luajit
    stremio
  ];

  # Virt-manager settings
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  home.stateVersion = "23.05";
}
