{
  inputs,
    outputs,
    lib,
    config,
    pkgs,
    ...
}: {

  imports = [
    ./firefox
    ./services.nix
    ../default.nix
  ];


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
