{ inputs, outputs, pkgs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    outputs.nixosModules.hyprland-custom

    ./hardware-configuration.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = { smj = import ../../home-manager/frost/home.nix; };
  };

  networking.hostName = "frost";

  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod;
    kernelModules = [ "i2c-dev" ];
  };
  documentation.dev.enable = true;
  security.polkit.enable = true;

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      configurationLimit = 8;
    };
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services = {
    udev.packages = with pkgs; [ openrgb-with-all-plugins ];
    fstrim.enable = true;
    btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
    };
    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
      displayManager.lightdm.enable = false;
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
    firefox = {
      enable = true;
      preferences = { "widget.use-xdg-desktop-portal.file-picker" = 1; };
    };
    hyprland-custom.enable = true;
    kdeconnect.enable = true;
    yazi.enable = true;
  };

  environment = { systemPackages = with pkgs; [ virt-manager man-pages man-pages-posix ]; };

  system.stateVersion = "23.05";
}
