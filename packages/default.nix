{pkgs, ...}: {
  dioxus-cli = pkgs.callPackage ./dioxus-cli {};
  hyprland-py = pkgs.callPackage ./hyprland-py {};
  typstudio = pkgs.callPackage ./typstudio {};
  vscode-css-languageservice = pkgs.callPackage ./vscode-css-languageservice {};
  wezterm = pkgs.callPackage ./wezterm {};
  yofi = pkgs.callPackage ./yofi {};
}
