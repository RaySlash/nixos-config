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

      # ./sway
      ./hardware-configuration.nix
      ./services.nix
      ./podman.nix
      ./cache.nix
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
      smj = import ../../home-manager/rpi/home.nix;
    };
  };

  networking.hostName = "rpi";
  networking.networkmanager.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_rpi4;
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
    };
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
  
  hardware.pulseaudio.enable = true;
  
  time.timeZone = "Australia/Brisbane";
	i18n.defaultLocale = "en_US.UTF-8";
	console = {
		font = "Lat2-Terminus16";
		keyMap = "us";
	};
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];

  users.users = {
    smj = {
      isNormalUser = true;
      extraGroups = [ "wheel" "video" ];
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
      libraspberrypi
      raspberrypi-eeprom
    ];
  };

  system.stateVersion = "23.05";
}
