{ inputs, ... }:
let nvimcat = import ./nvimcat { inherit inputs; };
in {
  osModules = {
    hyprland-custom = import ./hyprland/module.nix;
    homemanager = import ./home-manager/module.nix;
    nixcats = nvimcat.nixosModules.default;
    nix-essentials = import ./nix/module.nix;
    theme-custom = import ./themes/module.nix;
    zsh-custom = import ./zsh/module.nix;
  };

  homeModules = {
    firefox-addons = import ./firefox/home;
    hyprland-addons = import ./hyprland/home;
    lazyvim = import ./lazynvim/home;
    nixcats = nvimcat.homeModules.default;
    nix-addons = import ./nix/home.nix;
    theme-addons = import ./themes/home;
    wezterm-addons = import ./wezterm/home;
  };

  pkgs = { nvimcat = nvimcat.packages; };
}
