{ config, lib, inputs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.programs.nix-addons;
in {

  options.programs.nix-addons = { enable = mkEnableOption "nix-addons"; };

  config = mkIf cfg.enable {
    imports = [ inputs.nix-index-database.hmModules.nix-index ];

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
