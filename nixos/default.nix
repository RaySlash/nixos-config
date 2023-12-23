{ config, lib, pkgs, inputs, outputs, ... }:{
  
  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      outputs.overlays.master-packages
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
      substituters = [
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  networking.networkmanager.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    setLdLibraryPath = true;
  };

  systemd.extraConfig = "
    DefaultTimeoutStopSec=10s
    ";

  time.timeZone = "Australia/Brisbane";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Hack" ]; })
    ];
  };

  users.users = {
    smj = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      shell = pkgs.zsh;
    };
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
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
        theme = "intheloop";
      };
      shellAliases = {
        ls = "eza --icons";
        ll = "eza --icons -l";
        vim = "nvim";
        nix-update = "sudo nixos-rebuild switch";
      };
    };
  };

  environment = {
    variables.EDITOR = "nvim";
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      eza
        libclang
        gcc
        git
        zsh
        gnumake
    ];
  };

  system.autoUpgrade = {
    enable = true;
    flake = "github:NixOS/nixpkgs/nixos-23.11";
    flags = ["--update-input" "nixpkgs" "--commit-lock-file"];
  };

}
