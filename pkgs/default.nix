pkgs: {
  dioxus_cli = pkgs.callPackage ./dioxus_cli { };
  wezterm-master = pkgs.callPackage ./wezterm { };
  yofi-custom = pkgs.callPackage ./yofi { };
}
