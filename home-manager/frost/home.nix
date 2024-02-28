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
    logseq
    remmina
    luajit
    stremio
  ];

  home.stateVersion = "23.05";
}
