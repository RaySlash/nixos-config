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
    outputs.homeManagerModules.wezterm-custom
    outputs.homeManagerModules.hyprland-custom

    ../default.nix
  ];

  services = {
    hardened-firefox.enable = true;
  };

  programs = {
    wezterm-custom.enable = true;
    hyprland-custom.enable = true;
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
