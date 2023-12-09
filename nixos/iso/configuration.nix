{ config, lib, pkgs, inputs, outputs, ... }: {

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

  programs = {
    git.enable = true;
    neovim.enable = true;
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
    ];
  };

  system.stateVersion = "23.11";

}
