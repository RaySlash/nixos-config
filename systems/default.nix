{ inputs, ... }:
let
  mkNixos = args:
    let
      inherit (builtins) attrValues;
      # moduleSet is a function that takes inputs as args and return a
      # set that has all custom osModules, homeModules, pkgs.
      # Modules are imported for all systems by default.
      moduleSet = (import ../profiles/programs { inherit inputs; });
      # TODO: Refactor to accomodate more users
      username = "smj";
    in inputs.nixpkgs.lib.nixosSystem (args // {
      specialArgs = { inherit inputs; };
      modules = args.modules or [ ] ++ [
        ../profiles/users/${username}.nix
        ./common/os.nix
        inputs.home-manager.nixosModules.home-manager
        {
          config.nixpkgs = {
            overlays = [ inputs.self.overlays.unstable inputs.nurpkgs.overlay ];
            config = { allowUnfree = true; };
          };
        }
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.smj = import ./common/hm.nix;
            sharedModules = [ inputs.nix-index-database.hmModules.nix-index ]
              ++ attrValues moduleSet.homeModules;
          };
        }
      ] ++ attrValues moduleSet.osModules;
    });
in {
  frost = mkNixos { modules = [ ./frost/configuration.nix ]; };
  rpi = mkNixos { modules = [ ./rpi/configuration.nix ]; };
  dell = mkNixos { modules = [ ./dell/configuration.nix ]; };
  live = mkNixos {
    modules = [
      (inputs.nixpkgs
        + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
      ./iso/configuration.nix
    ];
  };
}
