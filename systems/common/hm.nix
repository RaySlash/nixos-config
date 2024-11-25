{ inputs, ... }: {
  imports = [
    inputs.self.homeManagerModules.wezterm-custom
  ];

  nixpkgs = {
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages
      inputs.nurpkgs.overlay
    ];
    config = { allowUnfree = true; };
  };

  home = {
    username = "smj";
    homeDirectory = "/home/smj";
  };

  programs = {
    home-manager.enable = true;
    gpg.enable = true;
    wezterm-custom.enable = true;
    git = {
      enable = true;
      userEmail = "45141270+RaySlash@users.noreply.github.com";
      userName = "RaySlash";
    };
  };


  systemd.user.startServices = "sd-switch";
}
