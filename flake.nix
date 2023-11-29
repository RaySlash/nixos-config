{
  description = "Personal Flake NixOS config - RaySlash";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    swayfx.url = "github:WillPower3309/swayfx/master";
    hyprland.url = "github:hyprwm/Hyprland/main";
    hyprpaper.url = "github:hyprwm/hyprpaper/main";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    arkenfox.url = "github:dwarfmaster/arkenfox-nixos/main";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nurpkgs.url = "github:nix-community/NUR/master";

  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
  inherit (self) outputs;
  systems = [
    "aarch64-linux"
    "x86_64-linux"
  ];
  forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    overlays = import ./overlays {inherit inputs;};
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      frost = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./nixos/frost/configuration.nix
        ];
      };
      rpi = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./nixos/rpi/configuration.nix
        ];
      };
      dell = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./nixos/dell/configuration.nix
        ];
      };
    };
  };
}
