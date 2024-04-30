# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{ pkgs, ... }: {
  # example = pkgs.callPackage ./example { };
  dioxus_cli = pkgs.callPackage ./dioxus_cli { };
  wezterm-master = pkgs.callPackage ./wezterm { };
}
