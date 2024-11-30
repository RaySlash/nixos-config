{
  config,
  lib,
  pkgs,
  ...
}: {
  services = {
    openssh = {enable = true;};
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      excludePackages = [pkgs.xterm];
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };

  boot = {
    initrd.kernelModules = ["wl"];
    kernelModules = ["wl"];
    extraModulePackages = with config.boot.kernelPackages; [broadcom_sta];
  };

  networking = {
    hostName = "nixos-live";
    wireless = {
      enable = false;
      iwd.enable = true;
    };
  };

  hardware.pulseaudio.enable = false;

  environment = {
    gnome.excludePackages =
      (with pkgs.gnome; [
        cheese # webcam tool
        gnome-music
        gnome-terminal
        epiphany # web browser
        geary # email reader
        evince # document viewer
        gnome-characters
        totem # video player
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
      ])
      ++ (with pkgs; [gnome-photos gedit gnome-tour]);
    systemPackages = with pkgs; [
      pciutils
      lshw
      networkmanager
      nmap
      wezterm
      btrfs-progs
      chromium
    ];
  };

  system.stateVersion = "23.11";
}
