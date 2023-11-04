{
  inputs,
    outputs,
    lib,
    config,
    pkgs,
    ...
}: {

  imports = [
# If you want to use modules your own flake exports (from modules/home-manager):
# outputs.homeManagerModules.example

# Or modules exported from other flakes (such as nix-colors):
inputs.hyprland.homeManagerModules.default

# You can also split up your configuration and import pieces of it here:
# ./nvim.nix
    ./hyprland
    ./services.nix
    ./theme.nix
    ./virtualisation.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      inputs.neovim-nightly-overlay.overlay
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

  home.packages = with pkgs; [
    htop
		fd
		ripgrep
		lazygit
		tree-sitter
    unzip
		wget
		imv
    helvum
    pavucontrol
		openrgb-with-all-plugins
    catppuccin-gtk
		papirus-icon-theme
		luajit
    oversteer
		libreoffice-fresh
		protonup-qt
		protontricks
		wineWowPackages.waylandFull
    vlc
    gimp-with-plugins
    lua-language-server
  ];

# Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.neovim.enable = true;

# Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

# https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
