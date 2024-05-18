{ config, lib, pkgs, inputs, outputs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.programs.wezterm-custom;
in
{

  options.programs.wezterm-custom = {
    enable = mkEnableOption "wezterm-custom";
  };

  config = mkIf cfg.enable {

    programs.wezterm = {
      enable = true;
      package = pkgs.unstable.wezterm;
      enableZshIntegration = true;
      colorSchemes = {
        gruvbox_material_dark_hard = {
          foreground = "#D4BE98";
          background = "#000000";
          cursor_bg = "#D4BE98";
          cursor_border = "#D4BE98";
          cursor_fg = "#1D2021";
          selection_bg = "#D4BE98";
          selection_fg = "#3C3836";
          ansi = [
            "#1d2021"
            "#ea6962"
            "#a9b665"
            "#d8a657"
            "#7daea3"
            "#d3869b"
            "#89b482"
            "#d4be98"
          ];
          brights = [
            "#eddeb5"
            "#cc241d"
            "#98971a"
            "#d79921"
            "#458588"
            "#b16286"
            "#689d6a"
            "#a89984"
          ];
        };
      };
      extraConfig = builtins.readFile ./wezterm.lua;
    };
  };

}
