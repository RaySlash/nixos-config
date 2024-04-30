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
    firewall.enable = true;
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
    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
      xkb = {
        layout = "us";
        variant = "";
      };
      desktopManager.xfce.enable = true;
    };
    displayManager.sddm = {
      enable = true;
      theme = "chili";
      settings = { Theme = { CursorTheme = "macOS-Monterey-White"; }; };
    };
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu.swtpm.enable = true;
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };

  environment.xfce.excludePackages = with pkgs.xfce; [
    orage
    ristretto
    mousepad
    xfburn
    parole
  ];

  programs = {
    java.enable = true;
    dconf.enable = true;
    hyprland-custom.enable = true;
    kdeconnect.enable = true;
    steam.enable = true;
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
