{ inputs, outputs, config, pkgs, ... }: {

  services = {
    udev.packages = with pkgs; [ openrgb-with-all-plugins ];
    fstrim.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  programs = {
    dconf.enable = true;
    kdeconnect.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    steam = {
      enable = true;
      package = pkgs.unstable.steam;
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
