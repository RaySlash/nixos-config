{ pkgs, inputs, ... }: {
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
    wezterm.enable = true;
    nix-addons.enable = true;
    hyprland-addons.enable = true;
  };

  systemd.user.startServices = "sd-switch";
}
