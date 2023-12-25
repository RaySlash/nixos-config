{ config, lib, pkgs, ... }: {

  services = {
    openssh = {
      enable = true;
    };
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      excludePackages = [ pkgs.xterm ];
      desktopManager.xfce.enable = true;
    };
  };

  boot = {
    initrd.kernelModules = [ "wl" ];
    kernelModules = [ "wl" ];
    extraModulePackages = with config.boot.kernelPackages; [
      broadcom_sta
    ];
  };

  networking = {
    hostName = "nixos-live";
    wireless = {
      enable = false;
      iwd.enable = true;
    };
  };

  environment = {
    xfce.excludePackages = with pkgs.xfce; [
      xfce4-terminal
      orage
      ristretto
      mousepad
      xfburn
      parole
    ];
    systemPackages = with pkgs; [
      pciutils
      lshw
      networkmanager
      nmap
      alacritty
      ungoogled-chromium
    ];
  };

  system.stateVersion = "23.11";

}
