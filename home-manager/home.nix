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

# You can also split up your configuration and import pieces of it here:
# ./nvim.nix
    ./sway
    ./firefox
    ./services.nix
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
    unzip
		wget
		imv
    catppuccin-gtk
		papirus-icon-theme
		luajit
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
