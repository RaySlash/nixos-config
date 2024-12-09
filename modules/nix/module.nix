{
  config,
  lib,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.custom.nix;
in {
  options.custom.nix = {enable = mkEnableOption "nix";};

  config = mkIf cfg.enable {
    nix = let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in {
      settings = {
        experimental-features = "nix-command flakes";
        flake-registry = "";
        nix-path = config.nix.nixPath;
        auto-optimise-store = true;
        substituters = ["https://nix-community.cachix.org"];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };
      channel.enable = false;
      registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

    programs = {
      nix-ld.enable = true;
      nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 4d --keep 3";
        flake = "/home/smj/dotfiles";
      };
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };

    # This does not work as expected as nix need `sudo` perms to commit-lock-file
    system.autoUpgrade = {
      enable = true;
      flake = "github:NixOS/nixpkgs/nixos-24.11";
      flags = ["--update-input" "nixpkgs" "--commit-lock-file"];
    };
  };
}
