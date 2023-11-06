{ config, pkgs, lib, inputs, outputs, ...}: {

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    xserver = {
      enable = true;
      desktopManager.xfce.enable = true;
      displayManager.defaultSession = "xfce";
    };
  };
  programs.zsh = {
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
}
