{ config, lib, pkgs, inputs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.custom.users.smj;
in {

  options.custom.users.smj = { enable = mkEnableOption "users.smj"; };

  config = mkIf cfg.enable {
    users.users = {
      smj = {
        isNormalUser = true;
        extraGroups =
          [ "wheel" "podman" "docker" "audio" "video" "networkmanager" ];
        shell = pkgs.zsh;
      };
    };
  };

}

