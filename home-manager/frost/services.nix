{ config, pkgs, inputs, outputs, ... }:  {

  programs = {
    gpg.enable = true;
    git = {
			enable = true;
			userEmail = "stevemathewjoy@gmail.com";
			userName = "RaySlash";
		};
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
    alacritty = {
			enable = true;
      package = pkgs.unstable.alacritty;
      settings = {
        window = {
          colors = {
            primary = {
              background =  "#282828";
              foreground =  "#ebdbb2";
            };
            normal = { 
              black =    "#282828";
              red =      "#cc241d";
              green =    "#98971a";
              yellow =   "#d79921";
              blue =     "#458588";
              magenta =  "#b16286";
              cyan =     "#689d6a";
              white =    "#a89984";
            };

            bright = { 
              black =    "#928374";
              red =      "#fb4934";
              green =    "#b8bb26";
              yellow =   "#fabd2f";
              blue =     "#83a598";
              magenta =  "#d3869b";
              cyan =     "#8ec07c";
              white =    "#ebdbb2";
            };
          };
          decorations = "full";
					opacity = 0.9;
					dynamic_title = true;
					history = 100000;
					multiplier = 2;
					cursor ={
						text = "CellBackground";
						cursor = "CellForeground";
					};
					vi_mode_cursor = {
						text = "CellBackground";
						cursor = "CellForeground";
					};
					transparent_background_colors = false;
				};
				bell = {
					animation = "EaseOutExpo";
					duration = 0;
					color = "#ffffff";
				};
				cursor = {
					style = {
						shape = "Block";
						blinking = "On";
					};
					vi_mode_style = "None";
					blink_interval = 750;
					blink_timeout = 0;
					live_config_reload = true;
				};
			}; 
		};
  };
}
