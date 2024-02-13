{
  config,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  programs = {
    obs-studio = {
      enable = true;
      package = pkgs.obs-studio;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vaapi
        obs-vkcapture
        obs-gstreamer
        obs-pipewire-audio-capture
      ];
    };
    wezterm = {
      enable = true;
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
      extraConfig = builtins.readFile ./hyprland/wezterm.lua;
    };
  };
}
