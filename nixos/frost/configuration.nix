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
      smj = import ../../home-manager/frost/home.nix;
    };
  };

  networking.hostName = "frost";

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    initrd.kernelModules = [ "amdgpu" ];
    blacklistedKernelModules = [ "hid-thrustmaster" ];
    kernelModules = [ "i2c-dev" "hid-tmff2" ];
    extraModulePackages = with config.boot.kernelPackages; [
      hid-tmff2
    ];
  };

  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 6;
    efi.canTouchEfiVariables = true;
  };

  services = {
    udev.packages = with pkgs; [ openrgb-with-all-plugins ];
    fstrim.enable = true;
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu.swtpm.enable = true;
  };

  programs = {
    java.enable = true;
    dconf.enable = true;
    kdeconnect.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    steam = {
      enable = true;
      package = pkgs.steam;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [ 
      virt-manager
    ];
  };

  system.stateVersion = "23.05";
}
