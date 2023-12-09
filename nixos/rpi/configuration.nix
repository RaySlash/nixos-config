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
    inputs.nixos-hardware.nixosModules.raspberry-pi-4

      ./hardware-configuration.nix
      ./podman.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      smj = import ../../home-manager/rpi/home.nix;
    };
  };

  networking.hostName = "rpi";

  boot.kernelPackages = pkgs.linuxPackages_rpi4;
  hardware = {
    deviceTree = {
      enable = true;
      # filter = "*rpi-4-*.dtb";
    };
    raspberry-pi."4" = {
      fkms-3d.enable = true;
      # audio.enable = true;
      apply-overlays-dtmerge.enable = true;
    };
  };
  
  services = {
    openssh = {
      enable = true;
    };
    xserver = {
      enable = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      libraspberrypi
      raspberrypi-eeprom
    ];
  };

  system.stateVersion = "23.05";
}
