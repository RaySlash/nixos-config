{
  inputs,
    outputs,
    lib,
    config,
    pkgs,
    ...
}: {

  imports = [
    ./hyprland
    ./firefox
    ./services.nix
    ../default.nix
  ];
  
  # Virt-manager settings
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
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
		luajit
    lua-language-server
		imv
    helvum
    pavucontrol
		openrgb-with-all-plugins
    ungoogled-chromium
    oversteer
		libreoffice-fresh
		protonup-qt
		unstable.protontricks
		wineWowPackages.waylandFull
    vlc
    gimp-with-plugins
    unstable.webcord
    remmina
  ];

  home.stateVersion = "23.05";
}
