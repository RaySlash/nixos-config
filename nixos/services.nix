{ inputs, outputs, config, pkgs, ... }: {

  services = {
    udev.packages = with pkgs; [ openrgb-with-all-plugins ];
    xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
      displayManager = {
        gdm.enable = true;
        gdm.wayland = true;
        defaultSession ="gnome-xorg";
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  programs = {
    kdeconnect.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      autosuggestions.enable = true;
      zsh-autoenv.enable = true;
      enableCompletion = true;
      histSize = 10000;
      ohMyZsh = {
        enable = true;
        theme = "robbyrussell";
      };
      shellAliases = {
        ls = "exa --icons";
        ll = "exa --icons -l";
        vim = "nvim";
        nix-update = "sudo nixos-rebuild switch";
      };
    };
  };
                                        }
