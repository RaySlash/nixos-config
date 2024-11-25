{ inputs, pkgs, ... }: {
  imports = [
    # inputs.self.homeModules.hyprland-addons
    # inputs.self.homeModules.firefox-addons
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

  # custom = {
  #   hyprland.enable = true;
  #   firefox.enable = true;
  # };

  programs = {
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vaapi
        obs-vkcapture
        obs-gstreamer
        obs-pipewire-audio-capture
      ];
    };
  };
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
  home.stateVersion = "23.05";
}