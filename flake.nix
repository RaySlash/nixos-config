{
  description = "Personal Flake NixOS config - RaySlash";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nurpkgs.url = "github:nix-community/NUR";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flake Add-ons
    flake-parts.url = "github:hercules-ci/flake-parts";
    sops-nix.url = "github:Mic92/sops-nix";
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Applications
    wezterm.url =
      "github:wez/wezterm?dir=nix"; # (nixpkgs)wezterm does not support Wayland

    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    plugins-neogit = {
      url = "github:NeogitOrg/neogit";
      flake = false;
    };
  };

  outputs = { flake-parts, ... }@inputs:
    let
      unstable-overlay = (final: _prev: {
        unstable = import inputs.nixpkgs-unstable {
          system = final.system;
          config.allowUnfree = true;
        };
      });
      packages-overlay = (final: _prev: import ./packages final.pkgs);
    in (flake-parts.lib.mkFlake { inherit inputs; }) {
      imports = [ inputs.flake-parts.flakeModules.flakeModules ];

      systems = inputs.nixpkgs.lib.systems.flakeExposed;
      debug = true;

      perSystem = { system, inputs', ... }: {
        formatter = inputs'.nixpkgs.legacyPackages.alejandra;
        packages =
          (import ./modules { inherit inputs; }).pkgs.nvimcat.${system};
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [ unstable-overlay packages-overlay ];
        };
      };

      flake = { self, ... }: {
        overlays = {
          default = [ self.overlays.unstable packages-overlay ];
          unstable = unstable-overlay;
        };

        nixosConfigurations = import ./systems { inherit inputs; };
      };
    };
}
