{ inputs, ... }: {
  # imports = [ ] ++ (builtins.attrValues
  #   (import ../../profiles/programs { inherit inputs; }).homeModules);

  nixpkgs = {
    overlays = [ inputs.self.overlays.unstable inputs.nurpkgs.overlay ];
    config = { allowUnfree = true; };
  };

  home = {
    username = "smj";
    homeDirectory = "/home/smj";
  };

  programs = {
    home-manager.enable = true;
    gpg.enable = true;
    git = {
      enable = true;
      userEmail = "45141270+RaySlash@users.noreply.github.com";
      userName = "RaySlash";
    };
  };

  # custom = {
  #   wezterm.enable = true;
  #   hyprland-addons.enable = true;
  # };

  systemd.user.startServices = "sd-switch";
}
