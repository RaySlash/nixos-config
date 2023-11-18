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
    inputs.hyprland.nixosModules.default

      ./hardware-configuration.nix
      ./services.nix
      ./cache.nix
      ./desktop
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      inputs.neovim-nightly-overlay.overlay
    ];

    config = {
      allowUnfree = true;
    };
  };

  nix = {
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      smj = import ../../home-manager/dell/home.nix;
    };
  };

  networking.hostName = "dell";
  networking.networkmanager.enable = true;

  boot = {
    blacklistedKernelModules = [ ];
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
    pulseaudio.enable = false;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
          libvdpau-va-gl
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
      setLdLibraryPath = true;
    };
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

  time.timeZone = "Australia/Brisbane";
	i18n.defaultLocale = "en_US.UTF-8";
	console = {
		font = "Lat2-Terminus16";
		keyMap = "us";
	};
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  users.users = {
    smj = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      shell = pkgs.zsh;
    };
  };

  environment = {
    variables.EDITOR = "nvim";
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      exa
      libclang
      gcc
      git
      zsh
    ];
  };

  system.stateVersion = "23.05";
}
