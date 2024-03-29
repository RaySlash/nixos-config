{ config
, lib
, pkgs
, inputs
, outputs
, ...
}: {
  imports = [ inputs.nix-index-database.hmModules.nix-index ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      inputs.nurpkgs.overlay
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "smj";
    homeDirectory = "/home/smj";
  };

  programs = {
    home-manager.enable = true;
    neovim.enable = true;
    gpg.enable = true;
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
    git = {
      enable = true;
      userEmail = "45141270+RaySlash@users.noreply.github.com";
      userName = "RaySlash";
    };
  };

  # Theme
  gtk = {
    enable = true;
    iconTheme.name = "Papirus-Dark";
    iconTheme.package = pkgs.papirus-icon-theme;
    font.name = "Hack Nerd Font";
    font.size = 12;
    theme.name = "Catppuccin-Mocha-Standard-Lavender-Dark";
    theme.package = pkgs.catppuccin-gtk.override {
      accents = [ "lavender" ];
      size = "standard";
      variant = "mocha";
    };
  };

  home = {
    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "macOS-Monterey-White";
      package = pkgs.apple-cursor;
      size = 32;
    };

    packages = with pkgs; [
      papirus-icon-theme
      catppuccin-gtk
      # Neovim
      yarn
      nodejs
      nodePackages.live-server
      # inputs.nvim.packages.${system}.default
    ];
  };

  systemd.user.startServices = "sd-switch";
}
