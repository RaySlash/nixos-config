{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    outputs.homeManagerModules.hardened-firefox

    ./hyprland
    ./services.nix
    ../default.nix
  ];

  # Virt-manager settings
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };


  home.packages = with pkgs; [
    htop
    fd
    ripgrep
    lazygit
    tree-sitter
    unzip
    p7zip
    wget
    imv
    helvum
    pavucontrol
    openrgb-with-all-plugins
    ungoogled-chromium
    oversteer
    libreoffice-fresh
    protonup-qt
    protontricks
    wineWowPackages.waylandFull
    vlc
    gimp-with-plugins
    vesktop
    remmina
    luajit
    stremio
    logseq
  ];

  home.stateVersion = "23.05";
}
