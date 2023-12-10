{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  imports = [
    inputs.home-manager.nixosModules.home-manager

      ./hardware-configuration.nix
      ./desktop
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      smj = import ../../home-manager/dell/home.nix;
    };
  };

  networking.hostName = "dell";

  boot = {
    initrd.kernelModules = [ "wl" "nvidia" ];
    kernelModules = [ "wl" "nvidia" ];
    extraModulePackages = with config.boot.kernelPackages; [
      broadcom_sta
      nvidia_x11_legacy470
    ];
  };

  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 6;
    efi.canTouchEfiVariables = true;
  };

  hardware = {
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
      prime = {
        sync.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:8:0:0";
      };
    };
  };

  services = {
    openssh = {
      enable = true;
    };
  };

  programs = {
    dconf.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

  environment = {
    systemPackages = with pkgs; [ ];
  };

  system.stateVersion = "23.05";
}
