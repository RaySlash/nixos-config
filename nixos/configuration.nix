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
      smj = import ../home-manager/home.nix;
    };
  };

  networking.hostName = "rpi";
  networking.networkmanager.enable = true;
	services.openssh.enable = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
  };

  boot.loader = {
    grub.enable = false;
    generic-extlinux-compatible.enable = true;
  };

  hardware.pulseaudio.enable = false;
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
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
