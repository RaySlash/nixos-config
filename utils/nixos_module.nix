{ self, inputs, config, lib, ... }:
let
  cfg = config.osModules;
  inherit (import ./submodule.nix lib inputs) submodule;
  modules = builtins.mapAttrs (_: config: config.wrappedModule) cfg;
in {
  options = {
    osModules = lib.mkOption { type = lib.types.attrsOf submodule; };
  };

  config.flake.nixosModules = modules;
}
