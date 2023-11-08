{ config, pkgs, lib, inputs, outputs, ...}: {

  services = {
    openssh = {
      enable = true;
    };
    xserver = {
      enable = true;
      displayManager = {
        gdm.enable = true;
        gdm.wayland = true;
      };
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
  programs.light.enable = true;
}
