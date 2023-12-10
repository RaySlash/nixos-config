{
  inputs,
    outputs,
    lib,
    config,
    pkgs,
    ...
}: {

  imports = [
    outputs.homeManagerModules.hardened-firefox
    ./services.nix
    ../default.nix
  ];

  services.hardened-firefox.enable = true;

  home.packages = with pkgs; [
    htop
		fd
		ripgrep
		lazygit
		tree-sitter
    unzip
    p7zip
		wget
		luajit
    lua-language-server
		imv
    helvum
    pavucontrol
    ungoogled-chromium
		libreoffice-fresh
		wineWowPackages.waylandFull
    vlc
  ];

  home.stateVersion = "23.05";
}
