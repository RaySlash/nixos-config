{
  description = "NixOS-config for RaySlash";

  inputs = {
# Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

# Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

# nurpkgs.url = "github:nix-community/NUR/master";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
  inherit (self) outputs;
  systems = [
    "x86_64-linux"
  ];
  forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
# Custom packages
# Acessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
# Formatter for your nix files, available through 'nix fmt'
# Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

# Custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
# Reusable nixos modules you might want to export
# These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
# Reusable home-manager modules you might want to export
# These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      frost = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./nixos/configuration.nix
        ];
      };
    };
  };
}
