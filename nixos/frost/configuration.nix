{ inputs
, outputs
, lib
, config
, pkgs
, ...
}:
let
  sddm-chili-theme =
    pkgs.libsForQt5.callPackage
      (inputs.nixpkgs + "/pkgs/data/themes/chili-sddm/default.nix")
      { };
in
{

  imports = [
    inputs.home-manager.nixosModules.home-manager
    outputs.nixosModules.hyprland-custom

    ./hardware-configuration.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      smj = import ../../home-manager/frost/home.nix;
    };
  };

  networking = {
    hostName = "frost";
  };

  boot = {
    blacklistedKernelModules = [ "hid-thrustmaster" ];
    kernelModules = [ "i2c-dev" "hid-tmff2" ];
    extraModulePackages = with config.boot.kernelPackages; [
      hid-tmff2
    ];
  };

  security.polkit.enable = true;

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      configurationLimit = 8;
    };
  };

  services = {
    onedrive.enable = true;
    udev.packages = with pkgs; [ openrgb-with-all-plugins ];
    fstrim.enable = true;
    btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
    };
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "chili";
      settings = { Theme = { CursorTheme = "macOS-Monterey-White"; }; };
    };
    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
      xkb = {
        layout = "us";
        variant = "";
      };
    };
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      autoPrune.enable = true;
    };
    libvirtd = {
      enable = true;
      qemu.swtpm.enable = true;
    };
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };

  programs = {
    java.enable = true;
    dconf.enable = true;
    hyprland-custom.enable = true;
    kdeconnect.enable = true;
    yazi.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      virt-manager
      sddm-chili-theme
    ];
  };

  system.stateVersion = "23.05";
}
