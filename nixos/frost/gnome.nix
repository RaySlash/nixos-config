{ config, pkgs, lib, ...}:{

  services = {
    xserver = {
      desktopManager.gnome.enable = true;
    };
    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gnome-terminal
    gedit # text editor
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);

  environment.systemPackages = with pkgs; [
    wl-clipboard-x11
    wl-clipboard
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.freon
    gnomeExtensions.pano
    gnomeExtensions.user-themes
    gnomeExtensions.blur-my-shell
  ];
}
