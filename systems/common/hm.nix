{ pkgs, inputs, osConfig, ... }:
let users = (builtins.attrValues (import ../default.nix { inherit inputs; }));
in {
  home = {
    username = "smj";
    homeDirectory = "/home/smj";
  };

  imports = [ ../frost/home ];

  programs = {
    gpg.enable = true;
    git = {
      enable = true;
      userEmail = "45141270+RaySlash@users.noreply.github.com";
      userName = "RaySlash";
    };
  };

  nvimcat = {
    enable = true;
    packageNames = [ "nvimcat" ];
  };

  custom = {
    firefox.enable = true;
    wezterm.enable = true;
    hyprland-addons.enable = true;
    nix-addons.enable = true;
  };

  systemd.user.startServices = "sd-switch";
}
