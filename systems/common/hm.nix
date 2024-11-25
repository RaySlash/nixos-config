{ pkgs, ... }: {
  imports = [ ../frost/home ];

  programs = {
    gpg.enable = true;
    git.enable = true;
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
    users.smj.enable = true;
  };

  systemd.user.startServices = "sd-switch";
}
