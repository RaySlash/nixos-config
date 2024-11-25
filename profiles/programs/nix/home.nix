{ config, lib, inputs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.custom.nix-addons;
in {

  options.custom.nix-addons = { enable = mkEnableOption "nix-addons"; };

  config = mkIf cfg.enable {

    programs = {
      nix-index = {
        enable = true;
        enableZshIntegration = true;
      };
      direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
