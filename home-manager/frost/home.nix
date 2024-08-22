{ outputs, pkgs, ... }: {
  imports = [
    outputs.homeManagerModules.hardened-firefox
    outputs.homeManagerModules.hyprland-addons

    ../default.nix
  ];

  services = { hardened-firefox.enable = true; };

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  programs = {
    hyprland-addons.enable = true;
    eww = {
      enable = true;
      package = pkgs.unstable.eww;
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

  home.file.".config/hypr/swww.sh".source = ./swww_randomize_multi.sh;
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

  # Virt-manager settings
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  home.stateVersion = "23.05";
}
