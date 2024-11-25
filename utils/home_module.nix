{ self, inputs, config, lib, ... }:
let
  cfg = config.homeModules;
  inherit (import ./submodule.nix lib inputs) submodule;
  modules = builtins.mapAttrs (_: config: config.wrappedModule) cfg;
in {
  options = {
    homeModules = lib.mkOption { type = lib.types.attrsOf submodule; };
  };

  config.flake.homeManagerModules = modules;
}
