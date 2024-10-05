{ pkgs, ... }: {

  imports = [ ./services.nix ../default.nix ];
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
  ];

  home.stateVersion = "23.05";
}
