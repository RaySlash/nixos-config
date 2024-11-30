{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.nixos-hardware.nixosModules.raspberry-pi-4

    ./hardware-configuration.nix
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    users = {smj = import ./home;};
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

  networking.firewall.enable = false;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings = {dns_enabled = true;};
    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = ["--all"];
    };
  };

  services = {
    openssh = {enable = true;};
    xserver = {enable = true;};
  };

  environment = {
    systemPackages = with pkgs; [
      libraspberrypi
      raspberrypi-eeprom
      podman-compose
      podman-tui
    ];
  };

  system.stateVersion = "23.05";
}
