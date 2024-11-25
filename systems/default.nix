{ inputs, ... }:
let
  mkNixos = args:
    inputs.nixpkgs.lib.nixosSystem (args // {
      specialArgs = { inherit inputs; };
      modules = args.modules or [ ] ++ [ ./common/os.nix ];
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
