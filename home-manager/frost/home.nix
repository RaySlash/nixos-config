{ outputs, pkgs, ... }: {
  imports = [
    outputs.homeManagerModules.hyprland-addons
    outputs.homeManagerModules.firefox-hardened

    ../default.nix
  ];

  home.packages = with pkgs; [
    htop
    fd
    ripgrep
    lazygit
    unzip
    p7zip
    wget
    imv
    helvum
    pavucontrol
    openrgb-with-all-plugins
    chromium
    libreoffice-fresh
    stremio
    wineWowPackages.waylandFull
    vlc
    vesktop
  ];

  programs = {
    hyprland-addons.enable = true;
    firefox-hardened.enable = true;
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

    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };

    home.stateVersion = "23.05";
  };
}
