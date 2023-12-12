{ config, pkgs, inputs, outputs, ... }:  {

  programs = {
    obs-studio = {
      enable = true;
      package = pkgs.unstable.obs-studio;
      plugins = with pkgs.unstable.obs-studio-plugins; [
        wlrobs
        obs-vaapi
        obs-vkcapture
        obs-gstreamer
        obs-pipewire-audio-capture
      ];
    };
    rio = {
      enable = true;
      settings = {
        editor = "nvim";
        cursor = "▇";
        blinking-cursor = true;
        use-kitty-keyboard-protocol = true;
        performance = "High";
        disable-renderer-when-unfocused = true;
        use-fork = true;

        window = {
          foreground-opacity = 1.0;
          background-opacity = 0.7;
          blur = true;
        };
        fonts = {
          family = "Lilex Nerd Font";
          size = 18;

          regular = {
            family = "Lilex Nerd Font";
            style = "Regular";
            weight = 400;
          };

          bold = {
            family = "Lilex Nerd Font";
            style = "Bold";
            weight = 800;
          };

          italic = {
            family = "Lilex Nerd Font";
            style = "Italic";
            weight = 400;
          };

          bold-italic = {
            family = "Lilex Nerd Font";
            style = "Bold-Italic";
            weight = 800;
          };
        };
        # GruvboxDarkHard.toml
        # https://github.com/raphamorim/rio-terminal-themes/blob/main/themes/GruvboxDarkHard.toml
        colors = {
          background = "#0F0D0E";
          foreground = "#ebdbb2";
          selection-background = "#665c54";
          selection-foreground = "#ebdbb2";
          cursor = "#ebdbb2";
          black = "#1b1b1b";
          red = "#cc241d";
          green = "#98971a";
          yellow = "#d79921";
          blue = "#458588";
          magenta = "#b16286";
          cyan = "#689d6a";
          white = "#a89984";
          light_black = "#928374";
          light_red = "#fb4934";
          light_green = "#b8bb26";
          light_yellow = "#fabd2f";
          light_blue = "#83a598";
          light_magenta = "#d3869b";
          light_cyan = "#8ec07c";
          light_white = "#ebdbb2";
        };
        navigation = {
          mode = "CollapsedTab";
          clickable = true;
          use-current-path = false;
          color-automation = [];
        };
      };
    };
  };
}
