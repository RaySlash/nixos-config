{ configs, pkgs, lib, inputs, outputs, ... }: {

  wayland.windowManager.sway = {
    enable = true;
    package = inputs.swayfx.packages.${pkgs.system}.swayfx-unwrapped;
    extraConfig = builtins.readFile ./config.in ;
  };

  home.packages = with pkgs; [
    tofi
    wl-clipboard
    dunst
    grim
    slurp
  ];

}
