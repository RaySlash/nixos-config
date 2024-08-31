{ config, lib, pkgs, inputs, outputs, ... }: {
  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = { allowUnfree = true; };
  };

  nix = let flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
      nix-path = config.nix.nixPath;
      auto-optimise-store = true;
      substituters = [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    channel.enable = false;
    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
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

  systemd.extraConfig = "\n    DefaultTimeoutStopSec=10s\n    ";

  time.timeZone = "Australia/Brisbane";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "IosevkaTerm" ]; })
      atkinson-hyperlegible
    ];
  };

  users.users = {
    smj = {
      isNormalUser = true;
      extraGroups =
        [ "wheel" "podman" "docker" "audio" "video" "networkmanager" ];
      shell = pkgs.zsh;
    };
  };

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  programs = {
    git.enable = true;
    nix-ld.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
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
        vim = "nix run gitlab:rayslash/nvim --refresh";
        gl = "git log";
        gs = "git status";
        gc = "git commit";
        gc-all = ''git add . && git commit -m "update"'';
        gp = "git push";
        nix-boot = "sudo nixos-rebuild boot --flake";
        nix-switch = "sudo nixos-rebuild switch --flake";
        nix-shell = "nix-shell --run zsh";
      };
    };
  };

  environment = {
    variables.EDITOR = "nvim";
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [ eza libclang gcc git zsh gnumake ];
  };

  system.autoUpgrade = {
    enable = true;
    flake = "github:NixOS/nixpkgs/nixos-24.05";
    flags = [ "--update-input" "nixpkgs" "--commit-lock-file" ];
  };
}
