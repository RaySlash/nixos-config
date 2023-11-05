{ config, pkgs, lib, inputs, outputs, ... }: {

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  programs.waybar = {
    enable = true;
    package = pkgs.unstable.waybar;
    settings = {
      mainBar = {
        "layer" = "top";
        "output" = "DP-2";
        "position" = "top";
        "height" = 30;
        "modules-left"= ["hyprland/workspaces"];
        "modules-center"= ["hyprland/window"];
        "modules-right"= ["tray" "pulseaudio" "pulseaudio#microphone" "clock"];
        "hyprland/window"= {
          "format"= "{}";
          "max-length"= 200;
          "seperate-outputs"= true;
        };
        "hyprland/workspaces"= {
          "on-scroll-up"= "hyprctl dispatch workspace e+1";
          "on-scroll-down"= "hyprctl dispatch workspace e-1";
          "all-outputs"= true;
          "on-click"= "activate";
          "persistent_workspaces"= {
            "1"= [];
            "2"= [];
            "3"= [];
            "4"= [];
            "5"= [];
            "6"= [];
          };
        };
        "clock"= {
          "format"= "{:%a %d %b %I:%M %p}";
          "tooltip"= false;
        };
        "pulseaudio"= {
          "format"= "{icon} {volume}%";
          "tooltip"= false;
          "format-muted"= " Muted";
          "on-click"= "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "on-scroll-up"= "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+";
          "on-scroll-down"= "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
          "scroll-step"= 5;
          "format-icons"= {
            "headphone"= "";
            "hands-free"= "";
            "headset"= "";
            "phone"= "";
            "portable"= "";
            "car"= "";
            "default"= ["" "" ""];
          };
        };
        "pulseaudio#microphone"= {
          "format"= "{format_source}";
          "format-source"= " {volume}%";
          "format-source-muted"= "󰍭 Muted";
          "on-click"= "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          "on-scroll-up"= "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 0.05+";
          "on-scroll-down"= "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 0.05-";
          "scroll-step"= 5;
        };
        "tray"= {
          "icon-size"= 23;
        };
      };
    };
    style = builtins.readFile ./waybar.css;
  };

  programs.wofi = {
    enable = true;
    package = pkgs.unstable.wofi;
    settings = {
      show = "drun";
      width = 750;
      height = 400;
      always_parse_args = true;
      show_all = false;
      print_command = true;
      insensitive = true;
      prompt = "Type application name";
    };
    style = builtins.readFile ./wofi.css;
  };
}
