{
  description = "Personal Flake NixOS config - RaySlash";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systems = {
      url = "github:nix-systems/default-linux";
      flake = false;
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wezterm.url = "github:wez/wezterm?dir=nix";
    swww.url = "github:LGFae/swww";
    hyprland.url =
      "github:hyprwm/Hyprland/bb160cfe377da2d2b2e4431a3399fa60114f3911?submodules=1";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nurpkgs.url = "github:nix-community/NUR";

    # Neovim
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    plugins-neogit = {
      url = "github:NeogitOrg/neogit";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      flake = { system, ... }:
        let inherit (self) outputs;
        in {
          packages = import ./pkgs system;
          formatter = system.alejandra;
          overlays = import ./overlays { inherit inputs; };
          nixosModules = import ./modules/nixos;
          homeManagerModules = import ./modules/home-manager;
          nixosConfigurations = {
            frost = nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs outputs; };
              modules = [ ./nixos ./nixos/frost/configuration.nix ];
            };

            rpi = nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs outputs; };
              modules = [ ./nixos ./nixos/rpi/configuration.nix ];
            };

            dell = nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs outputs; };
              modules = [ ./nixos ./nixos/dell/configuration.nix ];
            };

            live = nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs outputs; };
              system = "x86_64-linux";
              modules = [
                (nixpkgs
                  + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
                ./nixos
                ./nixos/iso/configuration.nix
              ];
            };
          };
        };
    };
}
