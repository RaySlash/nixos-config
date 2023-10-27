{
  inputs,
    outputs,
    lib,
    config,
    pkgs,
    ...
}: {

  imports = [
# If you want to use modules your own flake exports (from modules/nixos):
# outputs.nixosModules.example

# Or modules from other flakes (such as nixos-hardware):
# inputs.hardware.nixosModules.common-cpu-amd
# inputs.hardware.nixosModules.common-ssd
    inputs.home-manager.nixosModules.home-manager

      ./hardware-configuration.nix
      ./services.nix
      ./virtualisation.nix
  ];

  nixpkgs = {
# You can add overlays here
    overlays = [
# Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
        outputs.overlays.modifications
        outputs.overlays.unstable-packages

# You can also add overlays exported from other flakes:
# neovim-nightly-overlay.overlays.default

# Or define it inline, for example:
# (final: prev: {
#   hi = final.hello.overrideAttrs (oldAttrs: {
#     patches = [ ./change-hello-to-hi.patch ];
#   });
# })
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

  networking.hostName = "frost";
  networking.networkmanager.enable = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "amdgpu" ];
    blacklistedKernelModules = [ "hid-thrustmaster" ];
    kernelModules = [ "i2c-dev" "hid-tmff2" ];
  };

  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 6;
    efi.canTouchEfiVariables = true;
  };

  hardware.pulseaudio.enable = false;
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  users.users = {
    smj = {
      isNormalUser = true;
      extraGroups = [ "wheel" "libvirtd" ];
      shell = pkgs.zsh;
    };
  };

  environment = {
    variables.EDITOR = "nvim";
    shells = with pkgs; [ zsh ];
    gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
    ]) ++ (with pkgs.gnome; [
      cheese # webcam tool
      gnome-music
      gnome-terminal
      gedit # text editor
      epiphany # web browser
      geary # email reader
      evince # document viewer
      gnome-characters
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);
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
