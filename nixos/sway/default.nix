{ configs, pkgs, lib, inputs, outputs, ... }: {

  programs.sway = {
    enable = true;
    package = inputs.swayfx.packages.${pkgs.system}.swayfx-unwrapped;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLEWINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';
  };
}
