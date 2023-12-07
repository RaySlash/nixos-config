{ config, lib, pkgs, inputs, outputs, ... }: {

  imports = [
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
    };
  };

  programs = {
    git.enable = true;
    neovim.enable = true;
    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      autosuggestions.enable = true;
      zsh-autoenv.enable = true;
      enableCompletion = true;
      histSize = 10000;
      ohMyZsh = {
        enable = true;
        theme = "geoffgarside";
      };
      shellAliases = {
        ls = "eza --icons";
        ll = "eza --icons -l";
        vim = "nvim";
        nix-update = "sudo nixos-rebuild switch";
      };
    };
  };

  boot = {
    initrd.kernelModules = [ "wl" ];
    kernelModules = [ "wl" ];
    extraModulePackages = with config.boot.kernelPackages; [
      broadcom_sta
    ];
  };

  networking.hostName = "nixos-live";

  time.timeZone = "Australia/Brisbane";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  environment = {
    variables.EDITOR = "nvim";
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      eza
      libclang
      gcc
      zsh
      pciutils
      lshw
      networkmanager
    ];
  };

  system.stateVersion = "23.11";

}