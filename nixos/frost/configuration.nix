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

  networking = {
    hostName = "frost";
    firewall = {
      enable = true;
      allowedTCPPorts = [
        8080 #dioxus
        8081 #expo npm
        8384 #logseq
        2200 #logseq
      ];
      allowedUDPPorts = [
        22000 #logseq
        21027 #logseq
      ];
    };
  };

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
    systemd-boot.configurationLimit = 8;
    efi.canTouchEfiVariables = true;
  };

  services = {
    onedrive.enable = true;
    udev.packages = with pkgs; [ openrgb-with-all-plugins ];
    fstrim.enable = true;
#     syncthing = {
#       enable = true;
#       user = "rayslash";
#       dataDir = "/home/smj/Documents/logseq";
#       configDir = "/home/smj/.local/state/syncthing";
#       settings = {
#         gui = {
#           user = "smj";
#           password = "YR+h46fm$Lknjwz"; # I know pass is exposed in the config
#         };
#         devices = {
#           "pixel6" = { id = "SAYXLU6-6D5S6XU-D7SUQNV-THCNN2R-HDLAWJH-P572QAE-U637SD6-CNIN2A4";
#           };
#           folders = {
#             id = "logseq";
#             "logseq" = { # Name of folder in Syncthing, also the folder ID
#               path = "/home/smj/Documents/logseq";    # Which folder to add to Syncthing
#               devices = [ "pixel6" ];      # Which devices to share the folder with
#             };
#           };
#         };
#       };
#     };
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
