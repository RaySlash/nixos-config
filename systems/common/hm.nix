{
  config,
  pkgs,
  ...
}: {
  programs = {
    gpg.enable = true;
    git.enable = true;
  };

  # Nixcat hmModule
  nvimcat = {
    enable = true;
    packageNames = ["nvimcat"];
  };

  custom = {
    firefox.enable = true;
    wezterm.enable = true;
    nix-addons.enable = true;
    themes-addons.enable = true;
    users.smj.enable = true;
  };

  systemd.user.startServices = "sd-switch";
}
